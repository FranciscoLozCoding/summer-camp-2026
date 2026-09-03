# Foundry v2 proposals — staged, NOT merged

Ten proposed `sage-waggle` reference pages from the second mining pass over the 2026
camp Hermes brains (Hermes Learning Foundry v2).

**Status: proposals.** Nothing here is wired into the profile. `distribution.yaml`
and `skills/sage-waggle/` are untouched on this branch. These files sit under
`docs/proposals/` so they can be reviewed and A/B'd without affecting any agent.

Method, evidence and full results live in the logs repo
`2026-summer-camp-sage-agent-logs`, branch `hermes-foundry-v2-transcript-mining`,
under `hermes/foundry-v2/` — start with its `README.md` and `notes/02-results.md`.

> **Branch note.** This branch is cut from `main`, whose profile is **1.1.0**; v1's
> release (`hermes-profile-1.2.0-foundry-uptake`) was never merged to `main`. The A/B
> below nevertheless grades against the true **1.2.0** tree, extracted from the v1
> branch, so these ten are measured on top of v1's work rather than beside it.

## What these are

Mined from **conversation transcripts** — each brain's `state.db`: 9,077 messages,
4,424 tool calls, 237.8 logged agent-hours across 11 students — rather than from the
agent-written skill artifacts the first pass used. Selection was semantic: six LLM
miners read all 331 episodes against a coverage map of every current baseline file,
with no keyword or topic gate.

## The proposals

| File | Candidate | n | Corrects baseline? |
| --- | --- | ---: | --- |
| `agent-shell-environment.md` | HV2-0001 | **9** | gap (uncovered) |
| `sudo-allowlist-and-image-import.md` | HV2-0002 | 2 | **yes** — `SKILL.md` ×6 |
| `pluginctl-gpu-runtimeclass.md` | HV2-0003 | 2 | **yes** — `runtime-packaging-patterns.md:106` |
| `podman-cdi-gpu-passthrough.md` | HV2-0004 | 2 | **yes** — `SKILL.md:660`, `docker-build-deploy.md:73` |
| `thor-host-torch-hang.md` | HV2-0005 | 1 | **yes** — `thor-host-cpu-dev-first.md` (v1's own) |
| `thor-conda-forge-no-sm110.md` | HV2-0006 | 1 | **yes** — host envs uncovered |
| `pywaggle-snapshot-channel-order.md` | HV2-0007 | 1 | **yes** — `reolink-http-snapshot.md:54` |
| `pywaggle-camera-offline-dev.md` | HV2-0008 | 1 | **yes** — camera guidance assumes a camera |
| `pywaggle-offnode-local-testing.md` | HV2-0009 | 1 | **yes** — "Local testing" section |
| `node-registry-x509-trust.md` | HV2-0010 | 1 | **yes** — ImagePullBackOff causes |

`n` = independent students. **Nine of ten correct guidance the profile currently
ships**, rather than only adding to it.

## Measured effect (offline, deterministic, no LLM)

BM25 retrieval@k plus actionability *within the retrieved text*. Control = 1.2.0
`sage-waggle` (112 files); treatment = control + these ten (122 files):

**10/10 targeted tasks improved · 0 regressions · 5/5 regression guards hold**,
stable at k ∈ {1, 2, 3, 5}.

The guards check that existing knowledge stays retrievable after ten pages are
added: the `/dev/nvmap` pitfall, the camp `pluginctl` workflow, the ECR `/proc/acpi`
bug, v1's SES-is-not-pod-liveness, and the local-cache pages.

### Why "retrieval + actionability" and not keyword coverage

On the host-torch-hang task, v1's `thor-host-cpu-dev-first.md` is retrieved **first**
from the 1.2.0 control — the topic is squarely covered, and a keyword grader scores
it a pass. But that page lacks `D-state` and the module-level-import rule, so an
agent that loads it still cannot fix the problem: it sets `CUDA_VISIBLE_DEVICES=`
and hangs anyway. `retrieval_hit=True, actionable=False`. Coverage is not the same
as being able to act.

## Live canary — `node-H039.sage`, 2026-09-02

Six of the ten are now verified on real hardware. Highlights:

- **HV2-0003 proved causally.** Two pods identical but for one line, same image, same
  `nodeSelector`: without `runtimeClassName` → `CUDA: False`, 0 `/dev/nvidia*`; with
  `runtimeClassName: nvidia` → `CUDA: True`, 5 devices. `pluginctl deploy --dry-run`
  emits that field in **none** of plain / `--selector resource.gpu=true` /
  `--privileged`. The `nvidia` RuntimeClass exists and the node carries
  `resource.gpu=true` — the node looks GPU-ready by every label a student would
  check, while every pluginctl GPU plugin silently runs on CPU.
- **HV2-0002 read straight from node config.** `/etc/sudoers.d/admin-users` lists the
  `%develop` allowlist character-for-character as the July transcript showed, on a
  different node. `k3s` is absent.
- **HV2-0004 was corrected by the canary.** The draft implied `--gpus all` fails. It
  does not: it exits 0 and injects **zero** GPU devices — worse than erroring. Only
  hardware caught this; assume similar risk in the four still untested.
- HV2-0006 (sm_110, cap `(11,0)`), HV2-0007 and HV2-0008 (pywaggle RGB conversion and
  the misleading zero-arg `Camera()` `TypeError`) all confirmed.

The three candidates flagged as possibly stale since July all reproduce six weeks
later, on a different node.

**Still untested:** HV2-0005 (unsafe on shared hardware — its claim is that the
process becomes unkillable by SIGKILL; needs a node with a reboot window), HV2-0001
(a Hermes harness property, not a node property), HV2-0009 and HV2-0010 (need a
non-root student context).

The canary ran as **root**; students were non-root `%develop` members. Config-level
findings transfer directly; student-permission experience was read from config.

Full log: logs repo, `hermes/foundry-v2/notes/03-canary.md`.

## Before merging any of these

1. **Run the HV2-0005 reproduction on a node you can reboot**, and exercise HV2-0001
   through Hermes itself rather than an SSH shell.
2. Treat the four untested pages with the caution HV2-0004 earned.
3. **Do not add prose to `sage-waggle/SKILL.md`.** It is already 115,244 B against a
   100 KB limit, and the 1.2.0 release grew it further; in-place patches now abort
   with a size error. New material belongs in `references/`, and splitting the skill
   body is a separate packaging task.
4. Each candidate's `REVIEW.md` in the logs repo carries a per-item checklist and its
   evidence trail (students, episode ids, verbatim de-identified quotes).

## A writing rule these pages follow

They name neighbouring references **without quoting their error strings**. An earlier
draft of `thor-host-torch-hang.md` carried a disambiguation banner quoting the nvmap
symptom text; that pushed it above `direct-node-testing.md` for nvmap queries and
caused a measurable retrieval regression at k=1. Describe a neighbour's symptom in
your own words and link the page — do not import its vocabulary.
