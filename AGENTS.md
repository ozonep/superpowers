# Repository guidance

This repository is a Codex-only plugin. Keep packaged content limited to `.codex-plugin/`, `assets/`, `README.md`, `LICENSE`, `CODE_OF_CONDUCT.md`, and the directories under `skills/`.

When changing a skill:

- Keep `SKILL.md` frontmatter to `name` and a specific `description` beginning with `Use when`.
- Keep the body under 500 words and state the outcome, authority boundary, evidence bar, and stop condition without requesting private reasoning.
- Put model and reasoning-effort choices in Codex configuration, not reusable skill or starter-prompt text.
- Keep `agents/openai.yaml` aligned with the skill contract; its `default_prompt` must name the skill explicitly.
- Treat historical evaluations as evidence for the exact prompt that was tested. Mark materially rewritten prompts as pending fresh representative evaluation.
- Prefer current Codex capabilities and official OpenAI documentation over hard-coded tool schemas or version-sensitive assumptions.

Run `tests/codex/run-tests.sh` after edits. For prompt behavior changes, also use isolated current-source tasks and record the model, effort, scenario, and limits of the evidence.
