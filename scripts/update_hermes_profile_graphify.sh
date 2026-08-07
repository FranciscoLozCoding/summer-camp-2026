#!/usr/bin/env bash
# Run `graphify extract` on the camp distribution profile (hermes-profile/).
#
# Student `sage` brains are installed from this tree. Use this script to rebuild
# the *distribution* knowledge graph (instructor packaging), not the live
# ~/.hermes/profiles/sage agent home — that path stays for day-to-day /graphify.
#
# Streams graphify stdout/stderr live (also tees to a log). Defaults match the
# public-archives script: local NVIDIA NIM (OpenAI-compatible) via brev:
#
#   brev port-forward nim-llama33 -p 8000:8000
#
#   OPENAI_BASE_URL=http://localhost:8000/v1 \
#   OPENAI_API_KEY=not-needed \
#   OPENAI_MODEL=meta/llama-3.3-70b-instruct \
#   ./scripts/update_hermes_profile_graphify.sh
#
# NRP ellm override:
#   OPENAI_BASE_URL=https://ellm.nrp-nautilus.io/v1 \
#   OPENAI_API_KEY=… \
#   OPENAI_MODEL=minimax-m2 \
#   ./scripts/update_hermes_profile_graphify.sh
#
# Do not put API keys in this file.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DEFAULT_PROFILE="$REPO_ROOT/hermes-profile"
PROFILE="${HERMES_PROFILE:-$DEFAULT_PROFILE}"
LOG_DIR="$REPO_ROOT/scripts/graphify-update-logs"
LOG_FILE="$LOG_DIR/hermes-profile.log"

DEFAULT_OPENAI_BASE_URL="http://localhost:8000/v1"
DEFAULT_MODEL="meta/llama-3.3-70b-instruct"
DEFAULT_OPENAI_API_KEY="not-needed"
DEFAULT_BACKEND="openai"
DEFAULT_TOKEN_BUDGET="25000"
DEFAULT_MAX_CONCURRENCY="2"
DEFAULT_API_TIMEOUT="1800"

DRY_RUN=0
FORCE=0
WIPE=0
PACK_BASELINE=0
SKIP_HEALTH_CHECK=0
BACKEND="$DEFAULT_BACKEND"
MODEL="${OPENAI_MODEL:-$DEFAULT_MODEL}"
TOKEN_BUDGET="$DEFAULT_TOKEN_BUDGET"
MAX_CONCURRENCY="$DEFAULT_MAX_CONCURRENCY"
API_TIMEOUT="$DEFAULT_API_TIMEOUT"
GRAPHIFY_BIN="${GRAPHIFY_BIN:-}"

usage() {
  cat >&2 <<'EOF'
Usage:
  update_hermes_profile_graphify.sh [options]

Runs (live, streamed):
  graphify extract <hermes-profile> --backend openai …

Environment (openai-compatible; default = local NIM):
  OPENAI_BASE_URL   default http://localhost:8000/v1
  OPENAI_API_KEY    default not-needed (local NIM; set for remote)
  OPENAI_MODEL      default meta/llama-3.3-70b-instruct
  HERMES_PROFILE    override profile path (default: <repo>/hermes-profile)

  Ensure the NIM is reachable first, e.g.:
    brev port-forward nim-llama33 -p 8000:8000
    curl -s http://localhost:8000/v1/models

Options:
  --profile PATH             hermes-profile directory (default: ../hermes-profile)
  --backend NAME             default: openai
  --model NAME               default: $OPENAI_MODEL or meta/llama-3.3-70b-instruct
  --token-budget N           default: 25000
  --max-concurrency N        default: 2
  --api-timeout S            default: 1800
  --graphify PATH            graphify binary (else .venv, conda hermes, PATH)
  --wipe                     Delete graphify-out/ (+ optional baseline) before extract
  --pack-baseline            After SUCCESS: refresh graphify-baseline.tar.gz and
                             agent-knowledge-graph.html from graphify-out/
  --force                    Pass --force to graphify extract
  --dry-run                  Print commands only
  --skip-health-check        Do not probe OPENAI_BASE_URL before extract
  -h, --help                 This help
EOF
  exit 1
}

resolve_graphify() {
  local candidate
  if [[ -n "$GRAPHIFY_BIN" ]]; then
    [[ -x "$GRAPHIFY_BIN" ]] || { echo "ERROR: --graphify not executable: $GRAPHIFY_BIN" >&2; exit 1; }
    echo "$GRAPHIFY_BIN"
    return 0
  fi
  for candidate in \
    "$REPO_ROOT/.venv/bin/graphify" \
    "$PROFILE/.venv-graphify/bin/graphify" \
    "$PROFILE/.venv/bin/graphify" \
    "${VIRTUAL_ENV:-}/bin/graphify" \
    "${CONDA_PREFIX:-}/bin/graphify"
  do
    [[ -n "$candidate" && -x "$candidate" ]] && { echo "$candidate"; return 0; }
  done
  if command -v conda >/dev/null 2>&1; then
    local base
    base="$(conda info --base 2>/dev/null || true)"
    if [[ -n "$base" && -x "$base/envs/hermes/bin/graphify" ]]; then
      echo "$base/envs/hermes/bin/graphify"
      return 0
    fi
  fi
  if command -v graphify >/dev/null 2>&1; then
    command -v graphify
    return 0
  fi
  echo "ERROR: graphify not found. Create a venv and pip install graphifyy, or set --graphify" >&2
  exit 1
}

check_openai_endpoint() {
  local base="${OPENAI_BASE_URL%/}"
  local root="${base%/v1}"
  local health_url="${root}/v1/health/ready"
  local models_url="${root}/v1/models"

  echo "[HEALTH] probing ${OPENAI_BASE_URL}" >&2
  if curl -sf --max-time 5 "$health_url" >/dev/null 2>&1; then
    echo "[HEALTH] ready via /v1/health/ready" >&2
    return 0
  fi
  if curl -sf --max-time 5 "$models_url" >/dev/null 2>&1; then
    echo "[HEALTH] reachable via /v1/models" >&2
    return 0
  fi
  echo "ERROR: OpenAI-compatible endpoint not reachable at ${OPENAI_BASE_URL}" >&2
  echo "  For local NIM: brev port-forward nim-llama33 -p 8000:8000" >&2
  echo "  Or pass --skip-health-check / set OPENAI_BASE_URL." >&2
  return 1
}

wipe_graph() {
  [[ "$WIPE" == "1" ]] || return 0
  echo "[WIPE] removing existing graph under $PROFILE" >&2
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "[WIPE] would remove: graphify-out/ graphify-baseline.tar.gz agent-knowledge-graph.html" >&2
    return 0
  fi
  rm -rf "$PROFILE/graphify-out"
  rm -f "$PROFILE/graphify-baseline.tar.gz"
  rm -f "$PROFILE/agent-knowledge-graph.html"
}

pack_baseline() {
  [[ "$PACK_BASELINE" == "1" ]] || return 0
  if [[ ! -f "$PROFILE/graphify-out/graph.json" ]]; then
    echo "ERROR: --pack-baseline but graphify-out/graph.json missing" >&2
    return 1
  fi
  echo "[PACK] graphify-baseline.tar.gz + agent-knowledge-graph.html" >&2
  if [[ "$DRY_RUN" == "1" ]]; then
    return 0
  fi
  (
    cd "$PROFILE"
    tar -czf graphify-baseline.tar.gz graphify-out
    if [[ -f graphify-out/graph.html ]]; then
      cp graphify-out/graph.html agent-knowledge-graph.html
    fi
  )
  echo "[PACK] wrote $PROFILE/graphify-baseline.tar.gz" >&2
  [[ -f "$PROFILE/agent-knowledge-graph.html" ]] && echo "[PACK] wrote $PROFILE/agent-knowledge-graph.html" >&2
}

run_extract() {
  local graphify="$1"
  local -a cmd

  cmd=("$graphify" extract "$PROFILE" --backend "$BACKEND")
  [[ -n "$MODEL" ]] && cmd+=(--model "$MODEL")
  [[ -n "$TOKEN_BUDGET" ]] && cmd+=(--token-budget "$TOKEN_BUDGET")
  [[ -n "$MAX_CONCURRENCY" ]] && cmd+=(--max-concurrency "$MAX_CONCURRENCY")
  [[ -n "$API_TIMEOUT" ]] && cmd+=(--api-timeout "$API_TIMEOUT")
  [[ "$FORCE" == "1" ]] && cmd+=(--force)

  echo "[CMD] ${cmd[*]}" >&2
  echo "[ENV] OPENAI_BASE_URL=${OPENAI_BASE_URL:-} OPENAI_MODEL=${OPENAI_MODEL:-$MODEL} backend=$BACKEND" >&2

  if [[ "$DRY_RUN" == "1" ]]; then
    return 0
  fi

  mkdir -p "$LOG_DIR"
  {
    echo "==== $(date -u +%Y-%m-%dT%H:%M:%SZ) ===="
    echo "CMD: ${cmd[*]}"
    echo "PROFILE=$PROFILE"
    echo "OPENAI_BASE_URL=${OPENAI_BASE_URL:-}"
    echo "OPENAI_MODEL=${OPENAI_MODEL:-$MODEL}"
    echo
  } >"$LOG_FILE"

  set +e
  PYTHONUNBUFFERED=1 "${cmd[@]}" 2>&1 | tee -a "$LOG_FILE"
  local rc=${PIPESTATUS[0]}
  set -e
  return "$rc"
}

# --- args ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --force) FORCE=1; shift ;;
    --wipe) WIPE=1; shift ;;
    --pack-baseline) PACK_BASELINE=1; shift ;;
    --skip-health-check) SKIP_HEALTH_CHECK=1; shift ;;
    --profile)
      [[ $# -ge 2 ]] || usage
      PROFILE="$2"; shift 2
      ;;
    --profile=*) PROFILE="${1#--profile=}"; shift ;;
    --backend)
      [[ $# -ge 2 ]] || usage
      BACKEND="$2"; shift 2
      ;;
    --backend=*) BACKEND="${1#--backend=}"; shift ;;
    --model)
      [[ $# -ge 2 ]] || usage
      MODEL="$2"; shift 2
      ;;
    --model=*) MODEL="${1#--model=}"; shift ;;
    --token-budget)
      [[ $# -ge 2 ]] || usage
      TOKEN_BUDGET="$2"; shift 2
      ;;
    --token-budget=*) TOKEN_BUDGET="${1#--token-budget=}"; shift ;;
    --max-concurrency)
      [[ $# -ge 2 ]] || usage
      MAX_CONCURRENCY="$2"; shift 2
      ;;
    --max-concurrency=*) MAX_CONCURRENCY="${1#--max-concurrency=}"; shift ;;
    --api-timeout)
      [[ $# -ge 2 ]] || usage
      API_TIMEOUT="$2"; shift 2
      ;;
    --api-timeout=*) API_TIMEOUT="${1#--api-timeout=}"; shift ;;
    --graphify)
      [[ $# -ge 2 ]] || usage
      GRAPHIFY_BIN="$2"; shift 2
      ;;
    --graphify=*) GRAPHIFY_BIN="${1#--graphify=}"; shift ;;
    -h|--help) usage ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      ;;
    *)
      echo "Unexpected argument: $1" >&2
      usage
      ;;
  esac
done

PROFILE="$(cd "$PROFILE" && pwd)"
if [[ ! -d "$PROFILE/skills" || ! -f "$PROFILE/AGENTS.md" ]]; then
  echo "ERROR: does not look like hermes-profile (need skills/ + AGENTS.md): $PROFILE" >&2
  exit 1
fi

if [[ "$BACKEND" == "openai" ]]; then
  export OPENAI_BASE_URL="${OPENAI_BASE_URL:-$DEFAULT_OPENAI_BASE_URL}"
  export OPENAI_MODEL="${OPENAI_MODEL:-$MODEL}"
  export OPENAI_API_KEY="${OPENAI_API_KEY:-$DEFAULT_OPENAI_API_KEY}"
  if [[ -z "${OPENAI_API_KEY:-}" && "$DRY_RUN" != "1" ]]; then
    echo "ERROR: OPENAI_API_KEY is not set" >&2
    exit 1
  fi
  if [[ "$DRY_RUN" != "1" && "$SKIP_HEALTH_CHECK" != "1" ]]; then
    check_openai_endpoint || exit 1
  fi
fi
[[ "$FORCE" == "1" ]] && export GRAPHIFY_FORCE=1

GRAPHIFY="$(resolve_graphify)"

echo "Repo:          $REPO_ROOT" >&2
echo "Profile:       $PROFILE" >&2
echo "graphify:      $GRAPHIFY" >&2
echo "backend:       $BACKEND" >&2
echo "model:         $MODEL" >&2
echo "token-budget:  $TOKEN_BUDGET" >&2
echo "concurrency:   $MAX_CONCURRENCY" >&2
echo "api-timeout:   $API_TIMEOUT" >&2
[[ "$BACKEND" == "openai" ]] && echo "OPENAI_BASE_URL=$OPENAI_BASE_URL" >&2
[[ "$WIPE" == "1" ]] && echo "wipe=1 (from-scratch)" >&2
[[ "$PACK_BASELINE" == "1" ]] && echo "pack-baseline=1" >&2
[[ "$DRY_RUN" == "1" ]] && echo "DRY RUN — no writes / no extract" >&2

echo >&2
echo "================================================================" >&2
echo "======== hermes-profile ========" >&2
echo "================================================================" >&2

wipe_graph

if ! run_extract "$GRAPHIFY"; then
  echo "[FAIL] graphify extract failed — see $LOG_FILE" >&2
  exit 1
fi

if [[ "$DRY_RUN" == "1" ]]; then
  echo "[DONE] hermes-profile (DRY_RUN)" >&2
  exit 0
fi

if [[ ! -f "$PROFILE/graphify-out/graph.json" ]]; then
  echo "[FAIL] graphify-out/graph.json missing after extract — see $LOG_FILE" >&2
  exit 1
fi

pack_baseline || exit 1

echo "[DONE] hermes-profile (SUCCESS)" >&2
echo "Log: $LOG_FILE" >&2
echo "Graph: $PROFILE/graphify-out/graph.json" >&2
if [[ "$PACK_BASELINE" == "1" ]]; then
  echo "Baseline: $PROFILE/graphify-baseline.tar.gz" >&2
fi
