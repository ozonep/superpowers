---
name: jcodemunch
description: Use when Codex must locate, read, understand, review, debug, plan, change, refactor, or assess source code under a jCodeMunch navigation policy. Enforce jCodeMunch MCP retrieval without shell or generic-filesystem fallback; skip work that requires no source exploration.
---

# jCodeMunch

## Contract

- On first use in a task, call `jcodemunch_guide`. Follow its version-matched policy when it differs from this playbook.
- Use jCodeMunch for source discovery, reads, relationships, and impact; use native tools only for editing and explicitly permitted commands.
- Never explore source with shell or generic search/read tools. Directly read only a specific file identified by jCodeMunch or the user when required immediately before editing.
- If jCodeMunch is unavailable or the repository cannot be indexed, immediately report the blocker and stop. 

## Enter the repository

After reading the guide, stay on the exposed tool surface:

- On the compact `menu`/`route`/`order` surface, use `route` for a concrete task, `menu` when the action is unclear, and `order` for a known action. Set `allow_state_change=true` for indexing or reindexing. Do not widen the tier to reach primitives.
- On the full surface, call `resolve_repo` with the absolute path and index or refresh only when needed. Then call `plan_turn` with the task and exact model identifier when known; never guess it. Follow the returned routing, confidence, and negative evidence. Use `suggest_queries` only when the repository or subsystem is unfamiliar.
- Prefer `assemble_task_context` with an explicit token budget for a well-defined task. Prefer ranked context, bundles, and batched retrieval over repeated primitive reads.

## Retrieve evidence

- Orient with repository, file-tree, or file outlines. Find code by symbol and fetch only selected implementations; use text search for strings, comments, configuration, and regex.
- Use structural reference, dependency, hierarchy, impact, and safety tools for relationship or change questions. 
- Use hybrid semantic search when terminology is conceptual, synonymous, or legacy-heavy.
- Require verified exact source before quoting or editing. Check confidence, freshness, coverage, negative evidence, truncation, and budget warnings before concluding. Widen one scoped query when evidence is weak or conflicting; otherwise report the gap.
- Avoid rereading session evidence. Accept compact output when parseable and retry once as JSON when it is not.

## Complete changes

1. Before a risky edit, retrieve the affected symbols and run the appropriate impact or safety analysis.
2. Make the change with normal editing tools.
3. Call `register_edit` with every edited path unless an active watcher confirms that it already refreshed them; batch paths in one call.
4. Retrieve changed symbols when semantic verification matters, then run the repository's native tests, lint, type checks, or builds.
