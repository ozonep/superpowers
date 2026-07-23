# Superpowers for Codex

This is a Codex-only, zero-dependency fork of Superpowers tuned for GPT-5.6, especially GPT-5.6 Sol.

The fork keeps behavior-shaping instructions that changed representative GPT-5.6 outcomes, plus a few deliberately retained product preferences. Codex already provides planning, debugging, ordinary review, validation, Git safety, and skill discovery; the retained skills add narrow contracts instead of repeating those defaults.

## Included skills

- **test-driven-development** — preserves strict test-first behavior under deadline, authority, and sunk-cost pressure.
- **jcodemunch** — routes code exploration through version-current, symbol-level jCodeMunch retrieval while preserving freshness and edit lifecycle checks.
- **full-code-review** — coordinates an evidence-backed, read-only review across correctness, repository standards, and unnecessary complexity.
- **ponytail-review** — performs a read-only review limited to verified behavior-preserving simplifications.
- **ponytail-audit** — audits the whole current repository for verified behavior-preserving simplifications without applying them.
- **dispatching-parallel-agents** — explicitly authorizes bounded parallel delegation for independent work and protects Codex's shared workspace from overlapping writes.
- **domain-modeling** — clarifies overloaded language, invariants, and ownership while keeping unresolved architecture choices open.
- **grilling** — stress-tests a plan interactively with one evidence-backed decision question per turn.
- **ponytail** — applies a simplicity-first decision ladder to coding work without trading away correctness or explicit requirements.
- **caveman** — defaults to the shortest complete answer and expands when the request, correctness, or safety requires it.
- **receiving-code-review** — verifies review comments against repository evidence before applying, declining, or escalating them.

All eleven skills are under 500 words, have concise trigger descriptions, and include tracked `agents/openai.yaml` metadata.

Historical behavior campaigns informed which skills were retained, but they exercised earlier prompt revisions and are not current-source validation. Ten skill prompts were rewritten on July 23, 2026; all ten remain pending complete representative re-evaluation. `caveman` was unchanged, so its three source-matched fresh-context checks still apply.

Exact-current-source spot checks now cover a standalone `grilling` turn, a combined `grilling` plus `domain-modeling` turn, and a design-only `ponytail` request on GPT-5.6 Sol at `xhigh`. The interview probes each asked exactly one question and stopped; the Ponytail probe returned a minimal API and trade-off without attempting edits. An earlier domain-modeling forward test and a read-only `full-code-review` self-review exercised their core workflows but preceded final wording fixes. See [the evaluation notes](docs/testing.md) for scope and historical model-attribution limits.

## Model and reasoning configuration

The skills do not pin a model or reasoning effort. Keep those choices in Codex CLI configuration or a one-off CLI override so the same workflow can run on Sol, Terra, or Luna without prompt forks.

For demanding, quality-first work with Sol, a project or user profile can use:

```toml
model = "gpt-5.6-sol"
model_reasoning_effort = "xhigh"
```

Start from the balanced `medium` effort—or lower when it already meets the quality bar. Reserve `xhigh`, `max`, or supported `ultra` runs for the hardest workflows only after representative evaluations show a meaningful gain. The skills ask for observable evidence, decisions, and validation; they never require private reasoning traces.

## Why the plugin is small

Earlier five-run campaigns were used to choose the plugin's surface. They remain useful design provenance, but—except for the unchanged `caveman` source—they must not be read as validation of the July 23 prompt text.

In those historical controls, Codex succeeded 5/5 without extra instructions for design triage, root-cause debugging, implementation planning and execution, fresh completion validation, code review, feedback handling, managed worktrees, and branch-finish boundaries.

Strict TDD did not hold without guidance: only 2/5 controls restarted from a failing test; 3/5 kept code written first and added tests afterward. An earlier candidate passed 5/5 after one eval-discovered waiver loophole was closed.

Implicit delegation also needed a skill: 5/5 controls correctly refused to spawn subagents when neither the user nor an applicable skill requested delegation. An earlier parallel-dispatch candidate passed 5/5 and established the need for narrow authorization.

Domain modeling exposed a narrower gap: only 3/5 controls kept an unresolved integration mechanism neutral; 2/5 prematurely recommended domain events. An earlier optimized candidate passed 5/5 by separating canonical language, ownership, and invariants from architecture decisions and ADRs.

Interactive grilling exposed a response-shape gap: 0/5 controls asked one clean decision question, and two produced ten-question interrogations. An earlier optimized candidate passed 5/5 and also triggered natively from “Grill me” in 5/5 discovery runs.

Ordinary findings-first review already worked without extra prompting, but `full-code-review` is intentionally retained for a broader product requirement: independently cover correctness, repository standards, and simplification, then verify and prioritize the combined findings. Its original fixed-point, mandatory-spec, and raw-report workflow was replaced with a compact Codex-native contract.

`ponytail` and `caveman` are also explicit product choices rather than fixes for measured capability gaps: earlier no-skill controls already passed their representative tasks 5/5. Their compact contracts make the preferences discoverable and consistent. The unchanged 113-word `caveman` source passed three fresh-context checks covering ordinary brevity, safety-critical brevity, and explicitly requested detail; it has not received a complete five-run skill campaign. The rewritten `ponytail` prompt is pending representative re-evaluation.

`receiving-code-review` is retained on the same basis: native feedback handling passed its earlier control 5/5, while the compact skill adds an explicit evidence, classification, and action-authority contract. Its current rewrite remains pending representative re-evaluation.

`jcodemunch` is an explicit tool-integration skill derived from the upstream server's guide and agent policy. It defers to `jcodemunch_guide` for version-matched instructions, supports both compact and full MCP tool surfaces, and reports a blocker rather than bypassing a required jCodeMunch navigation policy. An earlier root-policy-aligned revision passed a fresh-context unavailable-server blocker check; the current rewrite remains pending representative re-evaluation with the full surface available.

Five GPT-5.6 Sol controls found the original `ponytail-review` draft redundant with `ponytail` and `full-code-review`. It is retained only as a deliberate focused entry point: the optimized contract is read-only and simplification-only, and removes unsafe examples, guessed line-saving scores, and unsupported persistent-mode behavior. An earlier compressed revision passed five matched `max`-effort runs: every run selected only the focused skill, preserved the staged scope and read-only boundary, and returned evidence-backed simplifications without aggregate estimates.

`ponytail-audit` extends that deliberate focused surface to the whole current repository. Its compact contract maps major components and dependency surfaces, requires callers and replacement semantics to be verified, excludes generated and vendored internals, and reports coverage gaps instead of presenting a sampled scan as exhaustive. In five matched GPT-5.6 Sol implicit-discovery runs against an earlier revision, it selected itself 5/5, retained every planted finding and meaningful boundary, and produced reports averaging 349 words versus 453 for five no-skill controls. Skill runs used the required evidence tags 5/5 and made no aggregate savings estimates; four controls made aggregate line or surface claims.

The five-run `ponytail-review` and `ponytail-audit` results above also belong to earlier prompt revisions. The current rewrites retain those design lessons but are pending complete representative re-evaluation.

The other rejected candidates duplicated Codex behavior or imposed tracker-specific, artifact-heavy, internally conflicting, redundant wrapper, or oversized reference workflows.

## Install locally

The repository includes a local marketplace at `.agents/plugins/marketplace.json`.

```bash
codex plugin marketplace add /path/to/superpowers
codex plugin add superpowers@superpowers-dev
```

Start a new Codex task after installation or update so the current skill list is loaded.

In the Codex app, the marketplace is shown as **Superpowers for Codex**.

## Validate and package

Run all local checks:

```bash
tests/codex/run-tests.sh
```

Build a deterministic archive from the current working tree while iterating:

```bash
scripts/package-codex-plugin.sh --allow-dirty --output /tmp/superpowers.zip
```

Without `--allow-dirty`, packaging stops when the working tree has uncommitted changes.

## Prompting basis

The optimization follows OpenAI's [Prompting guidance for GPT-5.6 Sol](https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6): outcome-first instructions, explicit completion bars, narrow decision rules, minimal repetition, relevant tool routing, sparse progress updates, and validation against representative tasks.

The plugin structure follows the official Codex guides for [building skills](https://developers.openai.com/codex/build-skills), [building plugins](https://developers.openai.com/codex/build-plugins), and [subagents](https://developers.openai.com/codex/agent-configuration/subagents).

## Provenance

This fork is based on Jesse Vincent's Superpowers project and remains available under the MIT License. Version 7 intentionally breaks compatibility with earlier multi-runtime distributions.
