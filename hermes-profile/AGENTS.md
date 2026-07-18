## graphify

This profile **requires** a knowledge graph at `graphify-out/` over `skills/` + `docs/` (god nodes, communities, cross-file relationships).

When the user types `/graphify`, use the bundled **`graphify`** skill before doing anything else. If the user wants to **rebuild incrementally** after the graph exists, use that skill before doing anything else.

**Do not** look for or invent a `scripts/setup-graphify.sh`. Camp Graphify is driven by skill **`graphify`** (`/graphify <path-to-profile>`), which is more flexible than a one-off shell script.

### Camp rule — discover skills and docs through the graph

This Hermes profile ships a large skill/doc corpus (Sage/Waggle, Hugging Face, NVIDIA Jetson, …). **Do not** mass-read the skills tree to find which skill or reference to use.

Rules:
- For any question about **which skill, which reference, which doc, architecture, or how things connect** in this profile: first run `graphify query "<question>"` when `graphify-out/graph.json` exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts.
- **CWD is usually `$HOME` (e.g. `/root`), not the profile.** Always pass the **profile absolute path** to `/graphify` (never assume `.` is the profile).

### Build / update with `/graphify` + `.venv-graphify` + optional tarball

| Situation | What to use |
|-----------|-------------|
| No `graphify-out/graph.json` yet | Unpack `graphify-baseline.tar.gz` if present (fast); else `/graphify <profile>` |
| Graph exists; query / navigate | skill **`graphify`** → `query` / `path` / `explain` |
| Graph exists; added/changed skills or docs | `/graphify <profile> --update` |
| Need a **from-scratch** rebuild | `/graphify <profile>` again (full pipeline; not for incremental adds) |

#### Always use or create `.venv-graphify`

Install Graphify into **`.venv-graphify/`** at the **profile root**. Do **not** start with `which graphify` / `uv tool` / system `pip` (hangs or PEP 668). Hermes CWD is often `$HOME`.

```bash
# Resolve profile root:
PROFILE=""
for d in \
  "${HERMES_HOME:-$HOME/.hermes}/profiles/sage" \
  "$HOME/.hermes/profiles/sage" \
  "$HOME/summer-camp-2026/hermes-profile" \
  /root/summer-camp-2026/hermes-profile
do
  if [ -d "$d/skills/graphify" ] || [ -f "$d/graphify-baseline.tar.gz" ]; then PROFILE="$d"; break; fi
done
[ -n "$PROFILE" ] || { echo "ERROR: sage profile root not found"; exit 1; }
cd "$PROFILE"

# Create venv if missing, then install CLI:
if [ ! -x .venv-graphify/bin/python ]; then
  python3 -m venv .venv-graphify
  .venv-graphify/bin/pip install -U pip
  .venv-graphify/bin/pip install -U 'graphifyy[ollama]'
fi
export PATH="$PROFILE/.venv-graphify/bin:$PATH"
GRAPHIFY="$PROFILE/.venv-graphify/bin/graphify"
PYTHON="$PROFILE/.venv-graphify/bin/python"
mkdir -p graphify-out
"$PYTHON" -c "import sys; open('graphify-out/.graphify_python','w',encoding='utf-8').write(sys.executable)"

# Prefer shipped tarball when graph is missing (skips multi-hour extract):
if [ ! -f graphify-out/graph.json ] && [ -f graphify-baseline.tar.gz ]; then
  tar -xzf graphify-baseline.tar.gz
fi
```

Then in Hermes (pass the absolute profile path — CWD is often `$HOME`):

```text
/graphify /path/to/hermes-profile
# after skills/docs change with an existing graph:
/graphify /path/to/hermes-profile --update
```

Use `"$GRAPHIFY" query …` or `"$PYTHON" -c "…"` for skill bash blocks — not system `python3`.

#### Local Ollama notes (Thor)

When the skill / CLI needs a semantic extract against **local Ollama** (cold build without baseline, or doc-heavy `--update`):

1. **`OLLAMA_BASE_URL` must end with `/v1`** (OpenAI-compat). Example: `http://127.0.0.1:11434/v1` — bare `:11434` → HTTP 404 on every chunk.
2. Set **`OLLAMA_MODEL`** to an exact tag from `ollama list` (camp default often `gemma4:31b`).
3. Set **`OLLAMA_API_KEY=ollama`** (any non-empty string; Ollama ignores auth).
4. Prefer **`GRAPHIFY_OLLAMA_KEEP_ALIVE=0`** so extract does not pin VRAM after chunks.
5. Leave **`GRAPHIFY_OLLAMA_NUM_CTX` unset** (auto). Forcing `8192` truncates large markdown chunks (~57k) and hollows the graph. Use `--token-budget 25000` (and `--max-concurrency 1 --api-timeout 1800` if calling `graphify extract` directly).
6. Probe before a long extract: `curl` `/api/tags`, `/v1/models`, and a tiny `/v1/chat/completions` — expect HTTP 200.
7. Full extract over this corpus is **slow** (often 30+ minutes; can be hours). Prefer the baseline tarball; do not block forever in the foreground without telling the user.

Camp procedure detail: `skills/sage-waggle/references/graphify-guide.md`.

### After the graph exists

- Dirty `graphify-out/` files are expected after hooks or incremental updates; dirty graph files are not a reason to skip graphify. Only skip if the task is about stale/incorrect graph output, or the user explicitly says not to use it.
- If `graphify-out/wiki/index.md` exists, use it for broad navigation instead of raw source browsing.
- Read `graphify-out/GRAPH_REPORT.md` only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying profile skill/doc files in this session, run `/graphify <profile> --update` via **`.venv-graphify`** (not a full rebuild unless starting over).
- Then load the **named** skill (`/skill sage-waggle`, `/skill jetson-llm-serve`, …) and follow it. Graphify finds; the skill teaches procedures.
- Still use Sage MCP for live nodes/data/jobs; Graphify does not replace MCP.
