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

## Before merging any of these

1. **Run an instructor canary on a current node.** All grading here is textual —
   retrievability and actionability, not hardware outcomes. Nine of these contradict
   shipped guidance, and a stale correction is worse than none.
2. **Re-check the three that depend on per-node provisioning** — HV2-0002 (sudoers
   allowlist), HV2-0003 (device-plugin presence), HV2-0004 (Podman vs Docker). These
   may vary by node or have changed since July.
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
