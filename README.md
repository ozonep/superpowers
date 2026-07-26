# Superpowers for Codex

This is a Codex-only, zero-dependency fork of Superpowers tuned for GPT-5.6, especially GPT-5.6 Sol.

The fork keeps behavior-shaping instructions that changed representative GPT-5.6 outcomes, plus a few deliberately retained product preferences. Codex already provides planning, debugging, ordinary review, validation, Git safety, and skill discovery; the retained skills add narrow contracts instead of repeating those defaults.

## Included skills

- **test-driven-development** — preserves strict test-first behavior under deadline, authority, and sunk-cost pressure, with RED/GREEN evidence in the final handoff.
- **codegraph-usage** — retrieves current indexed source and best-effort structural context through CodeGraph while preserving freshness, worktree, and validation boundaries.
- **jcodemunch** — routes code exploration through version-current, symbol-level jCodeMunch retrieval while preserving freshness and edit lifecycle checks.
- **full-code-review** — traces changed behavior through callers, contracts, and tests before returning a verified, prioritized read-only review.
- **ponytail-review** — performs a read-only review limited to verified behavior-preserving simplifications.
- **ponytail-audit** — audits the whole current repository for verified behavior-preserving simplifications without applying them.
- **dispatching-parallel-agents** — explicitly authorizes bounded parallel delegation for independent work and protects Codex's shared workspace from overlapping writes.
- **domain-modeling** — clarifies overloaded language, invariants, and ownership while keeping unresolved architecture choices open.
- **grilling** — stress-tests a plan interactively with one evidence-backed decision question per turn.
- **ponytail** — applies a simplicity-first decision ladder to coding work without trading away correctness or explicit requirements.
- **receiving-code-review** — verifies review comments against repository evidence before applying, declining, or escalating them.

All eleven skills are under 500 words, have concise trigger descriptions, and include tracked `agents/openai.yaml` metadata.

Historical behavior campaigns informed which skills were retained, but they exercised earlier prompt revisions and are not current-source validation. Ten skill prompts were rewritten on July 23, 2026; all ten remain pending complete representative re-evaluation. The new `codegraph-usage` prompt is likewise pending a complete representative campaign.

On July 26, one paired skill/control run for each of `caveman`, `ponytail`, `full-code-review`, and `test-driven-development` used Codex CLI with GPT-5.6 Sol at `max` on isolated Sequelize fixtures. The Caveman result led to its removal, the unchanged `ponytail` prompt remains an exact-current-source spot check, and the review and TDD results motivated targeted prompt updates afterward.

Other exact-current-source spot checks cover a standalone `grilling` turn, a combined `grilling` plus `domain-modeling` turn, a design-only `ponytail` request, and three real-MCP `codegraph-usage` probes on GPT-5.6 Sol at `xhigh` or `max`. These are one-run checks, not complete campaigns. An earlier domain-modeling forward test and a read-only `full-code-review` self-review preceded final wording fixes. See [the evaluation notes](docs/testing.md) for scenarios, results, and limits.

## Model and reasoning configuration

The skills do not pin a model or reasoning effort. Keep those choices in Codex CLI configuration or a one-off CLI override so the same workflow can run on Sol, Terra, or Luna without prompt forks.

For demanding, quality-first work with Sol, a project or user profile can use:

```toml
model = "gpt-5.6-sol"
model_reasoning_effort = "xhigh"
```

Start from the balanced `medium` effort—or lower when it already meets the quality bar. Reserve `xhigh`, `max`, or supported `ultra` runs for the hardest workflows only after representative evaluations show a meaningful gain. The skills ask for observable evidence, decisions, and validation; they never require private reasoning traces.

## Why the plugin is small

Earlier five-run campaigns were used to choose the plugin's surface. They remain useful design provenance, but they must not be read as validation of current prompt text except where an exact-current-source check is identified.

In those historical controls, Codex succeeded 5/5 without extra instructions for design triage, root-cause debugging, implementation planning and execution, fresh completion validation, code review, feedback handling, managed worktrees, and branch-finish boundaries.

Strict TDD did not hold without guidance: only 2/5 historical controls restarted from a failing test; 3/5 kept code written first and added tests afterward. An earlier candidate passed 5/5 after one eval-discovered waiver loophole was closed. In the July 26 Sequelize pair, the skill again produced authentic RED/GREEN while the control did not, but its final response omitted the decisive commands and results. The current contract now requires that evidence in the handoff and is pending fresh evaluation.

Implicit delegation also needed a skill: 5/5 controls correctly refused to spawn subagents when neither the user nor an applicable skill requested delegation. An earlier parallel-dispatch candidate passed 5/5 and established the need for narrow authorization.

Domain modeling exposed a narrower gap: only 3/5 controls kept an unresolved integration mechanism neutral; 2/5 prematurely recommended domain events. An earlier optimized candidate passed 5/5 by separating canonical language, ownership, and invariants from architecture decisions and ADRs.

Interactive grilling exposed a response-shape gap: 0/5 controls asked one clean decision question, and two produced ten-question interrogations. An earlier optimized candidate passed 5/5 and also triggered natively from “Grill me” in 5/5 discovery runs.

Ordinary findings-first review already worked without extra prompting, but `full-code-review` is intentionally retained for a broader product requirement. In the July 26 Sequelize pair, its pre-update prompt found five of six verified regressions with no false positives, while the control found all six. The current contract therefore makes changed behavior → callers → contracts → tests an explicit checklist and makes delegation conditional and truthful; this rewrite is pending fresh evaluation.

`ponytail` is also an explicit product choice rather than a fix for a measured capability gap: its earlier no-skill controls passed 5/5. In the July 26 pair, Ponytail produced the same correct implementation in three changed files and 55 inserted lines versus four files and 81 inserted lines. This is a single-run efficiency signal, not proof of a capability gain or a complete representative campaign.

`caveman` was removed after its July 26 skill and control runs were equally correct. The skill answer used 161 words versus 188, but the 830-byte skill file plus discovery and activation overhead did not demonstrate net token efficiency for that 27-word reduction. Earlier controls also passed the 55-word safety task without it.

Replace that personal or repository-wide preference with this durable `AGENTS.md` rule:

```md
- Default final responses to the shortest complete answer; expand only for requested detail, correctness, safety, evidence, or completion.
```

Put it in `~/.codex/AGENTS.md` for a personal cross-repository default, or in a target repository's root `AGENTS.md` when the team wants it on every task. This plugin's own root `AGENTS.md` governs plugin development and is not distributed to installed-plugin users.

This rule is the lower-overhead replacement surface, not a tested equivalent; matched behavior checks remain pending.

`receiving-code-review` is retained on the same basis: native feedback handling passed its earlier control 5/5, while the compact skill adds an explicit evidence, classification, and action-authority contract. Its current rewrite remains pending representative re-evaluation.

`jcodemunch` is an explicit tool-integration skill derived from the upstream server's guide and agent policy. It defers to `jcodemunch_guide` for version-matched instructions, supports both compact and full MCP tool surfaces, and reports a blocker rather than bypassing a required jCodeMunch navigation policy. An earlier root-policy-aligned revision passed a fresh-context unavailable-server blocker check; the current rewrite remains pending representative re-evaluation with the full surface available.

`codegraph-usage` is an explicit tool-integration skill derived from CodeGraph's current MCP instructions, tool definitions, CLI reference, and indexing guidance. It favors the single default `codegraph_explore` surface, supports the CLI equivalent for non-MCP harnesses, distinguishes current source from best-effort relationship evidence, and keeps index mutation under user authority. Its exact prompt remains pending a complete representative evaluation campaign.

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
