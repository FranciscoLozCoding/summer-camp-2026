## graphify

This profile **requires** a knowledge graph at `graphify-out/` over `skills/` + `docs/` (god nodes, communities, cross-file relationships).

When the user types `/graphify`, use the bundled **`graphify`** skill before doing anything else. If the user wants to **rebuild incrementally** the graph after it exists, use the bundled **`graphify`** skill before doing anything else.

### Camp rule — discover skills and docs through the graph

This Hermes profile ships a large skill/doc corpus (Sage/Waggle, Hugging Face, NVIDIA Jetson, …). **Do not** mass-read the skills tree to find which skill or reference to use.

Rules:
- For any question about **which skill, which reference, which doc, architecture, or how things connect** in this profile: first run `graphify query "<question>"` when `graphify-out/graph.json` exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts.
- **CWD is usually `$HOME` (e.g. `/root`), not the profile.** Never assume `scripts/setup-graphify.sh` exists in the current directory.

### `scripts/setup-graphify.sh` — **initial setup only**

Use the setup script **only** when `graphify-out/graph.json` is **missing** (first install / cold profile). It unpacks `graphify-baseline.tar.gz` or runs a one-time extract.

**After the graph exists, do not use `setup-graphify.sh` for normal Graphify work.** Load skill **`graphify`** instead (`/graphify`, `/graphify . --update`, query/path/explain).

| Situation | What to use |
|-----------|-------------|
| No `graphify-out/graph.json` yet | `scripts/setup-graphify.sh` (absolute path; baseline unpack preferred) |
| Graph exists; query / navigate | skill **`graphify`** → `graphify query` / `path` / `explain` |
| Graph exists; added/changed skills or docs | skill **`graphify`** → `/graphify . --update` (or equivalent update flow) |
| Graph exists; need a **from-scratch** rebuild | `scripts/setup-graphify.sh --rebuild` **only** (destroys/rebuilds; not for incremental adds) |
| Instructor shipping a new camp baseline | after a scratch rebuild: `--pack-baseline` |

If `graphify-out/graph.json` is **missing**:
1. Prefer the **camp baseline** (fast): run `scripts/setup-graphify.sh` once — if `graphify-baseline.tar.gz` is present it unpacks immediately.
2. Otherwise tell the user initial extract can take a **long time** — do **not** block foreground tools on it.
3. Resolve the setup script with an **absolute path**, then run it **once**:

```bash
# Prefer installed profile, then common clone locations:
SETUP=""
for d in \
  "${HERMES_HOME:-$HOME/.hermes}/profiles/sage" \
  "$HOME/.hermes/profiles/sage" \
  "$HOME/summer-camp-2026/hermes-profile" \
  /root/summer-camp-2026/hermes-profile
 do
  if [ -f "$d/scripts/setup-graphify.sh" ]; then SETUP="$d/scripts/setup-graphify.sh"; break; fi
done
[ -z "$SETUP" ] && SETUP="$(find "$HOME" -path '*/hermes-profile/scripts/setup-graphify.sh' 2>/dev/null | head -1)"
[ -n "$SETUP" ] || { echo "setup-graphify.sh not found"; exit 1; }
bash "$SETUP"           # initial only: baseline unpack OR first extract
bash "$SETUP" --status
```

4. Ready when profile `graphify-out/graph.json` exists. Do **not** re-run setup in a loop; poll `--status` only while initial extract is still running.
5. Do **not** use a relative `bash scripts/setup-graphify.sh` unless you have already `cd`'d into the profile root.
6. **`--rebuild` is start-from-scratch only** (replace the whole graph). If files were added and a graph already exists, use skill **`graphify`** (`--update`) — never `--rebuild` for that.

### After the graph exists

- Dirty `graphify-out/` files are expected after hooks or incremental updates; dirty graph files are not a reason to skip graphify. Only skip if the task is about stale/incorrect graph output, or the user explicitly says not to use it.
- If `graphify-out/wiki/index.md` exists, use it for broad navigation instead of raw source browsing.
- Read `graphify-out/GRAPH_REPORT.md` only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying profile skill/doc files in this session, follow skill **`graphify`** and run an **update** from the **profile root** (not `setup-graphify.sh --rebuild`).
- Then load the **named** skill (`/skill sage-waggle`, `/skill jetson-llm-serve`, …) and follow it. Graphify finds; the skill teaches procedures.
- Still use Sage MCP for live nodes/data/jobs; Graphify does not replace MCP.

Camp setup: `references/graphify-guide.md` (in `sage-waggle`) and `scripts/setup-graphify.sh` (initial only). Ongoing: skill **`graphify`**.
