#!/usr/bin/env bash
# Required camp setup: venv + pip install Graphify + build skills/docs graph via Ollama.
# Run from hermes-profile/ (or ~/.hermes/profiles/sage after install).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> Profile root: $ROOT"

PYTHON="${PYTHON:-python3}"
if ! command -v "$PYTHON" >/dev/null 2>&1; then
  echo "ERROR: $PYTHON not found. Install Python 3.10+ and retry." >&2
  exit 1
fi

# ── PEP 668-safe install: always use a project venv ──────────────────────────
VENV="${GRAPHIFY_VENV:-$ROOT/.venv-graphify}"
if [ ! -x "$VENV/bin/python" ]; then
  echo "==> Creating venv at $VENV (avoids externally-managed-environment / PEP 668)..."
  "$PYTHON" -m venv "$VENV"
fi
# shellcheck disable=SC1091
source "$VENV/bin/activate"
PY="$VENV/bin/python"
PIP="$VENV/bin/pip"
GRAPHIFY="$VENV/bin/graphify"

echo "==> Installing graphifyy[ollama] into $VENV ..."
"$PIP" install --upgrade pip
"$PIP" install --upgrade 'graphifyy[ollama]'

if [ ! -x "$GRAPHIFY" ]; then
  echo "ERROR: $GRAPHIFY missing after pip install." >&2
  exit 1
fi

mkdir -p graphify-out
"$PY" -c 'import sys; print(sys.executable)' > graphify-out/.graphify_python

# ── Ollama OpenAI-compat URL (critical) ──────────────────────────────────────
# graphify --backend ollama uses the OpenAI Python client.
# Correct:  http://127.0.0.1:11434/v1   → POST .../v1/chat/completions
# Wrong:    http://127.0.0.1:11434      → POST .../chat/completions → HTTP 404 page not found
#
# If OLLAMA_BASE_URL is set without /v1, normalize it here.
_raw_url="${OLLAMA_BASE_URL:-http://127.0.0.1:11434/v1}"
_raw_url="${_raw_url%/}"
case "$_raw_url" in
  */v1) ;;
  *)
    echo "==> NOTE: appending /v1 to OLLAMA_BASE_URL for OpenAI-compat (was: $_raw_url)"
    _raw_url="${_raw_url}/v1"
    ;;
esac
export OLLAMA_BASE_URL="$_raw_url"
export OLLAMA_MODEL="${OLLAMA_MODEL:-gemma4:31b}"
# OpenAI client requires a non-empty key; Ollama ignores it.
export OLLAMA_API_KEY="${OLLAMA_API_KEY:-ollama}"
export GRAPHIFY_OLLAMA_NUM_CTX="${GRAPHIFY_OLLAMA_NUM_CTX:-8192}"
export GRAPHIFY_OLLAMA_KEEP_ALIVE="${GRAPHIFY_OLLAMA_KEEP_ALIVE:-0}"

echo "==> OLLAMA_BASE_URL=$OLLAMA_BASE_URL"
echo "==> OLLAMA_MODEL=$OLLAMA_MODEL"

# Smoke-check OpenAI-compat endpoint before a long extract
_native="${OLLAMA_BASE_URL%/v1}"
echo "==> Probing Ollama..."
if ! curl -sf "${_native}/api/tags" >/dev/null; then
  echo "ERROR: cannot reach ${_native}/api/tags — is ollama serve running?" >&2
  exit 1
fi
if ! curl -sf "${OLLAMA_BASE_URL}/models" -H "Authorization: Bearer ${OLLAMA_API_KEY}" >/dev/null; then
  echo "ERROR: ${OLLAMA_BASE_URL}/models failed." >&2
  echo "       Graphify needs the OpenAI-compat API (/v1/...). Upgrade Ollama or fix the URL." >&2
  exit 1
fi
# Optional: verify model name exists
if ! curl -sf "${_native}/api/tags" | grep -F "\"${OLLAMA_MODEL}\"" >/dev/null 2>&1 \
   && ! curl -sf "${_native}/api/tags" | grep -F "${OLLAMA_MODEL%%:*}" >/dev/null 2>&1; then
  echo "WARNING: model '${OLLAMA_MODEL}' not clearly listed in /api/tags — extract may 404 on unknown model." >&2
  echo "         Run: ollama list   and set OLLAMA_MODEL to an exact tag." >&2
fi

# One-shot chat probe (catches wrong URL / missing model early)
echo "==> Probing ${OLLAMA_BASE_URL}/chat/completions with model=${OLLAMA_MODEL}..."
_probe_code=$(curl -s -o /tmp/graphify_ollama_probe.json -w "%{http_code}" \
  -X POST "${OLLAMA_BASE_URL}/chat/completions" \
  -H "Authorization: Bearer ${OLLAMA_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"${OLLAMA_MODEL}\",\"messages\":[{\"role\":\"user\",\"content\":\"ping\"}],\"max_tokens\":8}")
if [ "$_probe_code" != "200" ]; then
  echo "ERROR: chat/completions returned HTTP ${_probe_code} (body follows):" >&2
  cat /tmp/graphify_ollama_probe.json >&2 || true
  echo >&2
  echo "Common fixes:" >&2
  echo "  - OLLAMA_BASE_URL must end with /v1 (OpenAI compat), not bare :11434" >&2
  echo "  - OLLAMA_MODEL must match \`ollama list\` exactly (404 often = unknown model)" >&2
  echo "  - Ensure ollama serve supports /v1/chat/completions" >&2
  exit 1
fi
echo "==> Probe OK (HTTP 200)"

echo "==> Extracting knowledge graph (skills/ + docs/; respects .graphifyignore)..."
echo "    This can take a long time on Thor — prefer when Hermes chat is idle."

"$GRAPHIFY" extract . --backend ollama

echo "==> Done. Outputs under $ROOT/graphify-out/"
echo "    Use: $GRAPHIFY query \"...\" --graph graphify-out/graph.json"
echo "    Or activate: source $VENV/bin/activate"
