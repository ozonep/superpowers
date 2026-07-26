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

Ten skill prompts were rewritten on July 23, 2026. Historical five-run campaigns explain why those skills and constraints exist, but they exercised earlier prompt revisions and do not validate the current source. All ten rewritten prompts remain pending complete representative re-evaluation.

On July 26, one paired skill/control probe per workflow used Codex CLI `0.146.0-alpha.3.1`, GPT-5.6 Sol, and `max` effort on isolated Sequelize fixtures:

- the now-removed `caveman` and its control were equally correct; the skill answer used 161 words versus 188, but its discovery and activation input did not establish net efficiency;
- `ponytail` and its control produced correct fixes; the unchanged skill used three changed files and 55 insertions versus four files and 81 insertions;
- the pre-update `full-code-review` found five of six verified regressions without false positives, while the control found six of six; and
- the pre-update `test-driven-development` produced authentic RED/GREEN while the control did not, but omitted decisive command-and-result evidence from its final response.

The latter two prompts were rewritten after those runs, so the results are design evidence rather than validation of current source. Fresh post-update launches were blocked before model execution by the Codex state database sandbox and denied external-execution authorization. All four comparisons are one run per arm and are not complete representative campaigns.

Earlier live checks are limited to:

- one GPT-5.6 Sol `xhigh` turn in which `grilling` was discovered, made a recommendation, asked exactly one decision question, and stopped;
- one clean-context `domain-modeling` forward test that separated overloaded concepts and ownership while leaving the integration mechanism open; a cross-workflow output-contract clarification was added afterward, so the run does not validate the exact final prompt text;
- one exact-current-source GPT-5.6 Sol `xhigh` composition turn in which `domain-modeling` supported `grilling`, recommended separating organization and login identity, asked exactly one question, produced no model report or ADR, and left HTTP versus events unresolved;
- one exact-current-source GPT-5.6 Sol `xhigh` design-only `ponytail` turn that returned a minimal bounded-cache API and its concurrency trade-off without attempting repository edits;
- one GPT-5.6 Sol `xhigh` read-only `full-code-review` self-review that exposed an all-files wording gap; that gap was corrected afterward, so the run does not validate the exact final prompt text.

`caveman` was not changed in the July 23 rewrite, but it was removed after the July 26 pair found no measured capability gap and no demonstrated net-token gain. Its earlier source-matched checks remain historical evidence for that removal decision.

## Structural changes

- Removed every non-Codex manifest, bootstrap hook, adapter, test suite, and installation guide.
- Removed the universal skill bootstrap because Codex natively performs progressive skill discovery.
- Removed the custom visual-companion server in favor of native Codex visual capabilities.
- Replaced the broken legacy `AGENTS.md` symlink with a readable Codex-native repository guide and a regression check.
- Checked `agents/openai.yaml` into each skill instead of copying metadata from an older package.
- Made dirty development packaging consume the current working tree.
- Reduced the original runtime to eleven focused Codex skills.
- Rejected the later `lean-code` and `reviewing-plans` candidates after every no-skill control passed 5/5.
- Retained `ponytail` as an explicit product preference despite its earlier no-skill controls passing 5/5; its current prompt has one exact-source paired probe but remains pending representative behavior evaluation.
- Removed `caveman`: controls were already correct, and its modest final-answer reduction did not demonstrate enough savings to justify skill discovery and activation overhead. Prefer `Default final responses to the shortest complete answer; expand only for requested detail, correctness, safety, evidence, or completion.` in the user's global or target repository `AGENTS.md`.
- Treat that `AGENTS.md` rule as an untested lower-overhead replacement surface until it passes matched brevity, safety, requested-depth, and evidence-heavy handoff checks.
- Retained a compact `receiving-code-review` contract for evidence, classification, and action authority despite the earlier review-feedback control passing 5/5; its current rewrite remains pending representative behavior evaluation.
- Added `jcodemunch` as an explicit Codex-native tool adapter; it delegates version-sensitive policy to the server's self-guide and keeps only compact routing, evidence, freshness, and reindexing invariants locally.
- Retained `ponytail-review` as an explicit focused-review entry point despite five GPT-5.6 Sol controls finding the original draft redundant; an earlier optimized revision separated read-only simplification review from `ponytail` implementation and `full-code-review` comprehensive review and passed five fresh-context `max`-effort candidate runs.
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
