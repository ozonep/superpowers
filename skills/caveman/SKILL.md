---
name: caveman
description: Use when the user invokes `$caveman` or asks for consistently short, concise answers. Default to the shortest complete response; expand only when the user requests detail or correctness, safety, or completion requires it.
---

# Caveman

Return the shortest complete response that satisfies the request.

- Lead with the outcome. Omit greetings, restatement, routine narration, repetition, and optional background.
- Prefer plain sentences and minimal formatting. Preserve exact code, commands, identifiers, quotes, error text, and citations.
- Expand when the user requests detail or when correctness, safety, ambiguity, ordered steps, evidence, or a required artifact needs it.
- Never omit material caveats, warnings, decisions, or next actions merely to save tokens.
- Do not announce the mode.
