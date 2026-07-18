# Graphify — required skills/docs discovery for this profile

[Graphify](https://github.com/Graphify-Labs/graphify) is **required** on this Hermes profile. The profile ships ~250 skills and ~1.8K markdown files; the agent must discover the right skill/ref via the knowledge graph, not by grepping the tree.

There is **no** camp setup shell script. Use the bundled skill **`graphify`** (`/graphify <path-to-profile>`) — it is more flexible and already includes the procedures for install, extract, update, query, path, and explain.

| | |
|--|--|
| **Upstream** | <https://github.com/Graphify-Labs/graphify> |
| **Bundled skill** | `skills/graphify/` — `/graphify <path-to-profile>` |
| **Always-on rules** | profile `AGENTS.md` |
| **Camp baseline** | `graphify-baseline.tar.gz` (optional fast init for `graphify-out/`) |
| **Corpus** | `skills/` + `docs/` (see `.graphifyignore`) |
| **PyPI** | `graphifyy` (CLI: `graphify`) |
| **Venv (required)** | **`.venv-graphify/`** at profile root — create if missing; always use for CLI/`import graphify` |

## Agent protocol (non-negotiable)

1. If `graphify-out/graph.json` exists → skill **`graphify`**: `query` / `path` / `explain` **before** mass-reading skills.
2. **Always use or create `.venv-graphify`.** Prefer `$PROFILE/.venv-graphify/bin/graphify` and `$PROFILE/.venv-graphify/bin/python`. Do **not** start with `which graphify` / `uv tool` / system `pip`.
3. If the graph is **missing** → unpack `graphify-baseline.tar.gz` if present, else **`/graphify <absolute-path-to-profile>`** (full build; can be slow on Ollama running locally).
4. If the graph exists and files were **added or changed** → **`/graphify <absolute-path-to-profile> --update`**. Do **not** full-rebuild for incremental adds.
5. Load the **specific** skill the graph points to (`sage-waggle`, `jetson-llm-serve`, `hf-cli`, …).
6. Use Sage / HF MCP for live data; Graphify indexes **this profile’s** skills and docs only.

## Install + build (every Thor / every profile install)

After `hermes profile install ./hermes-profile --name sage --alias`:

**Hermes CWD is usually `$HOME`.** Always pass an **absolute profile path** to `/graphify`.

### 1. Create (or reuse) the Graphify venv

```bash
cd ~/.hermes/profiles/sage   # or your clone of hermes-profile/

if [ ! -x .venv-graphify/bin/python ]; then
  python3 -m venv .venv-graphify
  .venv-graphify/bin/pip install -U pip
  .venv-graphify/bin/pip install -U 'graphifyy[ollama]'
fi
export PATH="$PWD/.venv-graphify/bin:$PATH"
```

### 2. Prefer the tarball; otherwise `/graphify`

```bash
# Fast path — unpack shipped baseline when present:
if [ ! -f graphify-out/graph.json ] && [ -f graphify-baseline.tar.gz ]; then
  tar -xzf graphify-baseline.tar.gz
fi
test -f graphify-out/graph.json && echo "graph ok"
```

If there is still no `graph.json`, in a Hermes session:

```text
/graphify /path/to/hermes-profile
```

Examples: `$HOME/.hermes/profiles/sage` or `$HOME/summer-camp-2026/hermes-profile`.

**Expect:** Full semantic extract over ~1.8K files is slow and shares VRAM with Ollama chat. Prefer the baseline tarball.

### Updating an existing graph

```text
/graphify /path/to/hermes-profile --update
```

Or from the profile root with the venv CLI:

```bash
cd ~/.hermes/profiles/sage
export PATH="$PWD/.venv-graphify/bin:$PATH"
.venv-graphify/bin/graphify update .
```

## Local Ollama — what we learned to make extract work

These matter when building/updating **without** (or beyond) the baseline tarball on Thor + Ollama:

| Rule | Why |
|------|-----|
| `OLLAMA_BASE_URL=http://127.0.0.1:11434/v1` | Must end with `/v1`. Bare `:11434` → `404 page not found` on every semantic chunk |
| `OLLAMA_MODEL=<exact ollama list tag>` | e.g. `gemma4:31b` — wrong tag also looks like 404 |
| `OLLAMA_API_KEY=ollama` | Any non-empty string; Ollama ignores auth but the OpenAI client sends a Bearer |
| `GRAPHIFY_OLLAMA_KEEP_ALIVE=0` | Avoid pinning the model in VRAM between chunks / after extract |
| Leave `GRAPHIFY_OLLAMA_NUM_CTX` **unset** | Auto-size from chunk. Forcing `8192` truncates ~57k markdown chunks → hollow graph |
| `--token-budget 25000` | Camp-sized chunks; pair with low VRAM only if you also lower `NUM_CTX` |
| `--max-concurrency 1 --api-timeout 1800` | Thor-friendly when calling `graphify extract` directly |
| Probe before long runs | `/api/tags`, `/v1/models`, tiny `/v1/chat/completions` must return HTTP 200 |

Manual extract (only if you need the CLI outside Hermes):

```bash
cd /path/to/hermes-profile
source .venv-graphify/bin/activate

export OLLAMA_BASE_URL=http://127.0.0.1:11434/v1
export OLLAMA_MODEL=gemma4:31b          # exact tag from `ollama list`
export OLLAMA_API_KEY=ollama
export GRAPHIFY_OLLAMA_KEEP_ALIVE=0
# Leave GRAPHIFY_OLLAMA_NUM_CTX unset

graphify extract . --backend ollama --token-budget 25000 --max-concurrency 1 --api-timeout 1800
```

### Probe Ollama OpenAI-compat

```bash
export OLLAMA_BASE_URL=http://127.0.0.1:11434/v1
export OLLAMA_API_KEY=ollama
export OLLAMA_MODEL=gemma4:31b

curl -s "$OLLAMA_BASE_URL/models" -H "Authorization: Bearer $OLLAMA_API_KEY" | head
curl -s -o /tmp/out.json -w "%{http_code}\n" -X POST "$OLLAMA_BASE_URL/chat/completions" \
  -H "Authorization: Bearer $OLLAMA_API_KEY" -H "Content-Type: application/json" \
  -d "{\"model\":\"$OLLAMA_MODEL\",\"messages\":[{\"role\":\"user\",\"content\":\"ping\"}],\"max_tokens\":8}"
cat /tmp/out.json
```

Expect HTTP **200**. Native `/api/tags` being healthy does **not** prove `/v1/...` works.

### `externally-managed-environment` (PEP 668)

Do **not** `pip install` into system Python. Create `.venv-graphify` and install `graphifyy` there.

## Query examples

```bash
source .venv-graphify/bin/activate
graphify query "pluginctl sideload ECR acpi" --graph graphify-out/graph.json
graphify path "sage-waggle" "jetson-llm-serve" --graph graphify-out/graph.json
graphify explain "pywaggle upload_file" --graph graphify-out/graph.json
```

## Security

Do not put secrets into `skills/` / `docs/` before extracting. Profile `.env` stays user-owned and outside the graph corpus.
