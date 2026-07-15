# GPT-5.6 optimization decisions

The v7 fork treats prompt text as a measured runtime dependency.

## Applied principles

- State the outcome, constraints, evidence, and completion bar.
- Preserve explicit user values and use decision rules for contextual choices.
- Keep absolute language for genuine invariants only.
- Remove repeated process instructions Codex already followed reliably in fresh-context evaluations.
- Prefer native Codex skill discovery, workspaces, review behavior, Git controls, and validation.
- Use subagents for independent work when an applicable instruction authorizes them; avoid concurrent overlapping writes in the shared workspace.
- Validate prompt changes on representative tasks one group at a time.

## Structural changes

- Removed every non-Codex manifest, bootstrap hook, adapter, test suite, and installation guide.
- Removed the universal skill bootstrap because Codex natively performs progressive skill discovery.
- Removed the custom visual-companion server in favor of native Codex visual capabilities.
- Checked `agents/openai.yaml` into each skill instead of copying metadata from an older package.
- Made dirty development packaging consume the current working tree.
- Reduced the original runtime to eight focused Codex skills.
- Rejected the later `lean-code` and `reviewing-plans` candidates after every no-skill control passed 5/5.
- Retained compact rewrites of `ponytail` and `caveman` as explicit product preferences despite their earlier no-skill controls passing 5/5; the current rewrites remain pending representative behavior evaluation.
- Retained a compact rewrite of `receiving-code-review` as an explicit evidence and action-authority contract despite the earlier review-feedback control passing 5/5; the current rewrite remains pending representative behavior evaluation.
- Rejected `code-review`, `diagnosing-bugs`, `grill-with-docs`, `implement`, `improve-codebase-architecture`, `research`, `tdd`, `triage`, `to-spec`, and `wayfinder` after independent 5/5 controls showed no behavior gap.
- Retained and rewrote `domain-modeling`: the no-skill control stayed architecture-neutral only 3/5, while the compact Codex-native candidate passed 5/5.
- Retained and rewrote `grilling`: no control produced a clean one-question turn, while the 235-word Codex-native candidate passed 5/5.
- Rejected `grill-me-with-docs` and `grill-me` after the retained skills composed and triggered natively in 5/5 controls without either wrapper.
- Rejected `documentation` and `typescript-magician` after GPT-5.6 Sol controls passed 5/5 without either candidate.
- Retained and rewrote the explicitly required `full-code-review` candidate: the compact workflow infers safe review scope, continues without a formal spec, uses parallel read-only lenses only when worthwhile, verifies candidate findings, and emits one prioritized report.
- Capped starter prompts at Codex's three-entry runtime limit and added a regression assertion after live discovery runs exposed the ignored fourth prompt.

## Sources

- [Prompting guidance for GPT-5.6 Sol](https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6)
- [Build skills](https://developers.openai.com/codex/build-skills)
- [Build plugins](https://developers.openai.com/codex/build-plugins)
- [Codex subagents](https://developers.openai.com/codex/agent-configuration/subagents)
