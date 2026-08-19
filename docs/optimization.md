# GPT-5.6 optimization decisions

The v7 fork treats prompt text as a measured runtime dependency.

## Applied principles

- State the outcome, constraints, evidence, and completion bar.
- Preserve explicit user values and use decision rules for contextual choices.
- Keep absolute language for genuine invariants only.
- State each instruction once and remove redundant examples or process narration.
- Remove repeated process instructions Codex already followed reliably in fresh-context evaluations.
- Keep model and reasoning selection in Codex configuration, not reusable skill text.
- Request observable evidence and validation, never private chain-of-thought.
- Prefer native Codex skill discovery, workspaces, review behavior, Git controls, and validation.
- Use subagents for independent work when an applicable instruction authorizes them; avoid concurrent overlapping writes in the shared workspace.
- Validate prompt changes on representative tasks one group at a time.

## GPT-5.6 reasoning posture

The skill contracts stay model-agnostic. Start with the balanced `medium` effort—or lower when it meets the quality bar—then raise it only when representative evaluations show a material improvement. Reserve `xhigh`, `max`, or supported `ultra` runs for the hardest, eval-proven workflows; availability depends on the selected model and Codex surface.

For an intentionally demanding Sol run, configure Codex CLI with:

```toml
model = "gpt-5.6-sol"
model_reasoning_effort = "xhigh"
```

Higher reasoning does not justify longer prompts. At elevated effort, keep the destination, material constraints, evidence bar, authority boundary, output contract, and stop condition explicit while leaving implementation choices to the model. Diagnose missing criteria, tool routing, or validation before adding instructions or raising effort.

## Current-source evaluation status

Ten skill prompts were rewritten on July 23, 2026. Historical five-run campaigns explain why those skills and constraints exist, but they exercised earlier prompt revisions and do not validate the current source. All ten rewritten prompts remain pending complete representative re-evaluation, although `receiving-code-review` and `ponytail-review` now have one directional exact-current-source paired probe each.

The `unslop` and `typescript-best-practices` additions received one exact-current-source implicit-discovery probe each on August 19 with GPT-5.6 Sol: `unslop` at `xhigh` preserved every supplied fact, number, quotation, condition, and caveat while removing unsupported promotional copy; the TypeScript skill at `max` found and reproduced all three planted boundary and modeling failures while staying read-only. These unpaired synthetic runs validate only those task shapes, not general reliability or efficiency.

On July 26, one paired skill/control probe per workflow used Codex CLI `0.146.0-alpha.3.1`, GPT-5.6 Sol, and `max` effort on isolated Sequelize fixtures:

- the now-removed `caveman` and its control were equally correct; the skill answer used 161 words versus 188, but its discovery and activation input did not establish net efficiency;
- `ponytail` and its control produced correct fixes; the unchanged skill used three changed files and 55 insertions versus four files and 81 insertions;
- the pre-update `full-code-review` found five of six verified regressions without false positives, while the control found six of six;
- the pre-update `test-driven-development` produced authentic RED/GREEN while the control did not, but omitted decisive command-and-result evidence from its final response;
- the pre-compression `receiving-code-review` scored 20/20 versus 19/20 for its control, but used 3.75× the input, 5.4× the commands, and 57% more elapsed time; and
- the pre-provenance `ponytail-review` and its control both found all four simplifications without false positives and tied at 25/26 combined quality, while the skill used 20% less input and 38% less output. The skill did not identify that a focused Mocha command exercised a stale compiled parent.

The `full-code-review` and `test-driven-development` prompts were rewritten after their runs, so those two results are design evidence rather than validation of current source. Fresh final-source reruns completed for the other two changes: the 320-word Receiving skill scored 20/20 versus 19/20, but used 1.59× the control's input and 1.82× its elapsed time; the 469-word Ponytail Review scored 26/26 versus 25/26, enforced changed-source provenance, and used fewer total tokens, commands, final words, and elapsed time. All comparisons are one run per arm and are not complete representative campaigns.

Earlier live checks are limited to:

- one GPT-5.6 Sol `xhigh` turn in which `grilling` was discovered, made a recommendation, asked exactly one decision question, and stopped;
- one clean-context `domain-modeling` forward test that separated overloaded concepts and ownership while leaving the integration mechanism open; a cross-workflow output-contract clarification was added afterward, so the run does not validate the exact final prompt text;
- one exact-current-source GPT-5.6 Sol `xhigh` composition turn in which `domain-modeling` supported `grilling`, recommended separating organization and login identity, asked exactly one question, produced no model report or ADR, and left HTTP versus events unresolved;
- one exact-current-source GPT-5.6 Sol `xhigh` design-only `ponytail` turn that returned a minimal bounded-cache API and its concurrency trade-off without attempting repository edits;
- one GPT-5.6 Sol `xhigh` read-only `full-code-review` self-review that exposed an all-files wording gap; that gap was corrected afterward, so the run does not validate the exact final prompt text.

`caveman` was not changed in the July 23 rewrite, but it was removed after the July 26 pair found no measured capability gap and no demonstrated net-token gain. Its earlier source-matched checks remain historical evidence for that removal decision.

On July 27, four read-only Codex CLI `0.146.0-alpha.3.1` probes exercised the exact 208-word global repository-discovery rule with GPT-5.6 Sol at `medium`. Identifier lookup used one `fff` call, architecture tracing used one CodeGraph call, exhaustive multiline matching used one native `rg`, and an unavailable-indexed-tools case used one native `rg` without installation or initialization. The MCP tools were deterministic mocks and each scenario ran once, so this is directional routing evidence rather than a real-server or matched performance result.

## Structural changes

- Removed every non-Codex manifest, bootstrap hook, adapter, test suite, and installation guide.
- Removed the universal skill bootstrap because Codex natively performs progressive skill discovery.
- Removed the custom visual-companion server in favor of native Codex visual capabilities.
- Replaced the broken legacy `AGENTS.md` symlink with a readable Codex-native repository guide and a regression check.
- Checked `agents/openai.yaml` into each skill instead of copying metadata from an older package.
- Made dirty development packaging consume the current working tree.
- Reduced the original runtime to ten focused Codex skills before adding the two narrowly triggered skills below.
- Added `typescript-best-practices` as a scoped type-design and boundary contract with a conditionally loaded patterns reference; removed dangling dependencies, unsafe absolutes, and non-TypeScript testing and telemetry policy.
- Added `unslop` as a faithful prose-revision contract; replaced universal activation, word and punctuation bans, and invented-personality instructions with explicit trigger, evidence, authority, and stop boundaries.
- Rejected the later `lean-code` and `reviewing-plans` candidates after every no-skill control passed 5/5.
- Retained `ponytail` as an explicit product preference despite its earlier no-skill controls passing 5/5; its current prompt has one exact-source paired probe but remains pending representative behavior evaluation.
- Removed `caveman`: controls were already correct, and its modest final-answer reduction did not demonstrate enough savings to justify skill discovery and activation overhead. Prefer `Default final responses to the shortest complete answer; expand only for requested detail, correctness, safety, evidence, or completion.` in the user's global or target repository `AGENTS.md`.
- Treat that `AGENTS.md` rule as an untested lower-overhead replacement surface until it passes matched brevity, safety, requested-depth, and evidence-heavy handoff checks.
- Retained `receiving-code-review` as a narrow correctness and authority contract despite the earlier review-feedback control passing 5/5. Compressed it from 484 to 320 words around per-comment disposition, concern/remedy and prerequisite separation, complete-claim evidence, and action boundaries. The fresh score stayed 20/20 versus 19/20 and the command gap narrowed to 13 versus 11, but the skill remained more token- and time-intensive, so no cost-efficiency claim is made.
- Added `jcodemunch` as an explicit Codex-native tool adapter; it delegates version-sensitive policy to the server's self-guide and keeps only compact routing, evidence, freshness, and reindexing invariants locally.
- Removed `codegraph-usage` in favor of a lean global `AGENTS.md` routing rule for `fff`, CodeGraph, and native fallback. The replacement preserves freshness, worktree, best-effort relationship, validation, and index-authority boundaries. Global guidance is simpler operationally but always loaded, so it is not inherently lower-token than a progressively disclosed skill; four mock-tool routing probes passed, while real-server matched evaluation remains pending.
- Retained `ponytail-review` as an explicit focused-review entry point despite five GPT-5.6 Sol controls finding the original draft redundant. Added a compact rule that validation must exercise the reviewed revision or disclose stale, prebuilt, or unknown provenance. In the fresh final-source pair, both arms handled the stale-output gap correctly; the skill scored one contract point higher and used less total input, output, commands, words, and elapsed time.
- Added `ponytail-audit` as the repository-wide counterpart to `ponytail-review`; an earlier optimized revision narrowed implicit triggering to simplification-only audits, verified use and replacement semantics, reported coverage gaps, and removed guessed aggregate savings and unsupported persistent-mode instructions. Five matched GPT-5.6 Sol implicit-discovery runs against that earlier revision selected it 5/5 and preserved all planted findings while producing reports 23% shorter on average than five no-skill controls.
- Rejected `code-review`, `diagnosing-bugs`, `grill-with-docs`, `implement`, `improve-codebase-architecture`, `research`, `tdd`, `triage`, `to-spec`, and `wayfinder` after independent 5/5 controls showed no behavior gap.
- Retained and rewrote `domain-modeling`: the historical no-skill control stayed architecture-neutral only 3/5, while an earlier compact Codex-native candidate passed 5/5.
- Retained and rewrote `grilling`: no historical control produced a clean one-question turn, while an earlier 235-word Codex-native candidate passed 5/5.
- Rejected `grill-me-with-docs` and `grill-me` after the retained skills composed and triggered natively in 5/5 controls without either wrapper.
- Rejected `documentation` and `typescript-magician` after GPT-5.6 Sol controls passed 5/5 without either candidate.
- Retained and rewrote the explicitly required `full-code-review` candidate: the current compact workflow infers safe review scope, continues without a formal spec, uses parallel read-only lenses only when worthwhile, verifies candidate findings, and emits one prioritized report. Its earlier five-run campaign belongs to a previous prompt revision.
- Tightened `full-code-review` after the July 26 pair to trace every changed behavior through callers, boundary contracts, conversions, and tests, and to claim delegation only after a successful call.
- Tightened `test-driven-development` after the July 26 pair to require authentic RED/GREEN command-and-result evidence in the final handoff.
- Capped starter prompts at Codex's three-entry runtime limit and added a regression assertion after live discovery runs exposed the ignored fourth prompt.

## Sources

- [Prompting guidance for GPT-5.6 Sol](https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6)
- [Build skills](https://developers.openai.com/codex/build-skills)
- [Build plugins](https://developers.openai.com/codex/build-plugins)
- [AGENTS.md guidance](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
- [Codex subagents](https://developers.openai.com/codex/agent-configuration/subagents)
