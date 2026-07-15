# Graphify — required skills/docs discovery for this profile

[Graphify](https://github.com/Graphify-Labs/graphify) is **required** on this Hermes profile. The profile ships ~250 skills and ~1.8K markdown files; the agent must discover the right skill/ref via the knowledge graph, not by grepping the tree.

| | |
|--|--|
| **Upstream** | <https://github.com/Graphify-Labs/graphify> |
| **Bundled skill** | `skills/graphify/` (Hermes/claw skill bundle) |
| **Always-on rules** | profile `AGENTS.md` |
| **Setup script** | `scripts/setup-graphify.sh` |
| **Corpus** | `skills/` + `docs/` (see `.graphifyignore`) |
| **PyPI** | `graphifyy` (CLI: `graphify`) |

## Agent protocol (non-negotiable)

1. If `graphify-out/graph.json` exists → `graphify query` / `path` / `explain` **before** mass-reading skills.
2. If the graph is missing → run `scripts/setup-graphify.sh` (or `graphify extract . --backend ollama`) from the profile root, then query.
3. Load the **specific** skill the graph points to (`sage-waggle`, `jetson-llm-serve`, `hf-cli`, …).
4. Use Sage / HF MCP for live data; Graphify indexes **this profile’s** skills and docs only.

Complementary routers: `nvidia-skill-finder`, `huggingface-skills-index.md`, `nvidia-skills-index.md` — still prefer the graph first when unsure.

## Install + build (every Thor / every profile install)

After `hermes profile install ./hermes-profile --name sage --alias`:

```bash
cd ~/.hermes/profiles/sage   # or the cloned hermes-profile/

chmod +x scripts/setup-graphify.sh
./scripts/setup-graphify.sh
```

Manual equivalent:

```bash
python3 -m pip install --user --upgrade 'graphifyy[ollama]'
export PATH="$(python3 -m site --user-base)/bin:$HOME/.local/bin:$PATH"
export OLLAMA_BASE_URL=http://127.0.0.1:11434
export OLLAMA_MODEL=gemma4:31b          # or gemma4-64k
export GRAPHIFY_OLLAMA_NUM_CTX=8192
export GRAPHIFY_OLLAMA_KEEP_ALIVE=0
graphify extract . --backend ollama
```
Outputs:

```text
graphify-out/
├── graph.html
├── GRAPH_REPORT.md
└── graph.json
```

Rebuild after `hermes profile update sage` (or run `graphify update .` for code-only AST refresh).

**Expect:** Markdown semantic extract over ~1.8K files is slow and shares VRAM with Ollama chat. Instructors should pre-run `./scripts/setup-graphify.sh` on fleet images when possible so `graphify-out/` is warm.

## Query examples

```bash
graphify query "pluginctl sideload ECR acpi" --graph graphify-out/graph.json
graphify path "sage-waggle" "jetson-llm-serve" --graph graphify-out/graph.json
graphify explain "pywaggle upload_file" --graph graphify-out/graph.json
```

Optional MCP:

```bash
python -m graphify.serve graphify-out/graph.json
```

## Security

Do not put secrets into `skills/` / `docs/` before extracting. Profile `.env` stays user-owned and outside the graph corpus.
