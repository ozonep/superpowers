---
name: jcodemunch
description: Use when the jCodeMunch MCP server is available and Codex needs repository orientation, code navigation, symbol or text retrieval, dependency or impact analysis, refactoring preflight, or token-bounded task context.
---

# jCodeMunch

## Source of truth

1. On first jCodeMunch use in a task, call `jcodemunch_guide`. Follow its version-matched policy when it differs from this skill.
2. If the server or guide is unavailable, state that targeted retrieval is unavailable and continue with native repository tools. Do not install, configure, or upgrade jCodeMunch unless the user asks.
3. Treat jCodeMunch as read-only code intelligence. Use normal editing, test, and Git tools for source changes and verification.

## Enter the repository

- Call `resolve_repo` with the current absolute path. If no index exists and the repository is in scope, call `index_folder`. Indexing changes jCodeMunch state; through the counter front door, dispatch it with `order(..., allow_state_change=true)`.
- If only `menu`, `route`, and `order` are visible, use that compact surface. Use `route` for a concrete natural-language task, `menu` when the action is unclear, and `order` for a known action. Do not expand the full tool surface merely to reach an action.
- Prefer `assemble_task_context` with a token budget for a well-defined engineering task. Use `plan_turn` when first deciding whether or where behavior exists; include the active model identifier when known and respect its confidence and negative evidence.

## Retrieve narrowly

- Orient with `get_repo_map` or `suggest_queries`, then a scoped outline or tree.
- Find code with `search_symbols`; include exact identifiers and filters when known, then fetch only selected implementations with `get_symbol_source`. Batch related symbol IDs.
- Inspect a known file with `get_file_outline` before source retrieval. Read a line range or whole file only when the task genuinely depends on non-symbol or file-wide semantics.
- Use `search_text` for strings, comments, configuration, and regex. Use `get_context_bundle` or `get_ranked_context` instead of chaining repeated primitive reads.
- Match relationship questions to structural tools such as `find_references`, `get_call_hierarchy`, `get_blast_radius`, `check_edit_safe`, `check_delete_safe`, or `plan_refactoring`.

## Interpret and refresh

- Check confidence, freshness, negative-evidence verdict, coverage exclusions, truncation, and budget metadata before drawing conclusions. Treat degraded or stale results as incomplete; do not turn an absent result into an implementation by repeated synonym searches.
- Request verified exact source before quoting behavior or editing. Honor budget warnings and avoid rereading session context.
- Accept MUNCH compact output when parseable. Retry once with `format="json"` when it is not.
- After edits, rely on an active watcher if reported; otherwise call `register_edit` with `file_paths` and reindex when current retrieval matters. Then verify behavior with the repository's native tests.
