#!/usr/bin/env bash
# Required camp setup: install Graphify CLI via pip + build profile skills/docs graph.
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

echo "==> Installing graphifyy[ollama] with pip (CLI: graphify)..."
# Prefer user install so students don't need sudo; fall back for managed envs.
"$PYTHON" -m pip install --user --upgrade 'graphifyy[ollama]' \
  || "$PYTHON" -m pip install --upgrade 'graphifyy[ollama]'

# Ensure user-site scripts are on PATH (Linux/macOS typical)
USER_BASE="$("$PYTHON" -m site --user-base 2>/dev/null || true)"
if [ -n "${USER_BASE:-}" ]; then
  export PATH="${USER_BASE}/bin:${PATH}"
fi
export PATH="${HOME}/.local/bin:${PATH}"

if ! command -v graphify >/dev/null 2>&1; then
  # Some pip layouts only expose the module entrypoint
  if "$PYTHON" -m graphify --help >/dev/null 2>&1; then
    graphify() { "$PYTHON" -m graphify "$@"; }
    export -f graphify
  else
    echo "ERROR: graphify not on PATH after pip install." >&2
    echo "       Try: export PATH=\"\$(\"$PYTHON\" -m site --user-base)/bin:\$PATH\"" >&2
    exit 1
  fi
fi

# Record interpreter so later `graphify` / MCP serve resolve the same env
mkdir -p graphify-out
"$PYTHON" -c 'import sys; print(sys.executable)' > graphify-out/.graphify_python

export OLLAMA_BASE_URL="${OLLAMA_BASE_URL:-http://127.0.0.1:11434}"
export OLLAMA_MODEL="${OLLAMA_MODEL:-gemma4:31b}"
export GRAPHIFY_OLLAMA_NUM_CTX="${GRAPHIFY_OLLAMA_NUM_CTX:-8192}"
export GRAPHIFY_OLLAMA_KEEP_ALIVE="${GRAPHIFY_OLLAMA_KEEP_ALIVE:-0}"

echo "==> OLLAMA_BASE_URL=$OLLAMA_BASE_URL OLLAMA_MODEL=$OLLAMA_MODEL"
echo "==> Extracting knowledge graph (skills/ + docs/; respects .graphifyignore)..."
echo "    This can take a long time on Thor — prefer when Hermes chat is idle."

graphify extract . --backend ollama

echo "==> Done. Outputs under $ROOT/graphify-out/"
echo "    GRAPH_REPORT.md  graph.json  graph.html"
echo "    Hermes uses AGENTS.md + skills/graphify — query before grepping skills."
