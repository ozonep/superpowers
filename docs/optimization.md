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
- Reduced the runtime from fourteen skills to two measured skills.

## Sources

- [Prompting guidance for GPT-5.6 Sol](https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6)
- [Build skills](https://developers.openai.com/codex/build-skills)
- [Build plugins](https://developers.openai.com/codex/build-plugins)
- [Codex subagents](https://developers.openai.com/codex/agent-configuration/subagents)
