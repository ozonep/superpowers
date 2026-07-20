---
name: jcodemunch
description: Mandatory jCodeMunch MCP workflow for repository code navigation. Use whenever Codex must locate, search, read, understand, review, debug, plan, change, refactor, or assess the impact of source code in a repository where jCodeMunch is available. Do not use for shell-only Git, build, test, lint, formatting, or package-management work that requires no source exploration.
---

# jCodeMunch

## Operating contract

- On first use in a session, call `jcodemunch_guide`. Follow its version-matched policy when it differs from this skill.
- Treat the applicable `AGENTS.md` as the mandatory policy and this skill as its execution playbook.
- Use jCodeMunch for repository code discovery and reading. Use normal editing, test, build, lint, package, and Git tools for changes and verification.
- For indexed source, never fall back to shell search, generic file search, or generic filesystem reads. Read a file directly only immediately before editing a specific file that the user named or jCodeMunch identified, and only when jCodeMunch cannot supply the required content. Do not turn that exception into exploratory reading.
- If the MCP server is unavailable or indexing fails, report the blocker instead of silently falling back. Do not install, configure, or upgrade jCodeMunch unless the user asks.

## Start the task

1. Call `resolve_repo` with the repository's absolute path. If no usable index exists, call `index_folder` with the absolute path. If freshness metadata says the repository index is stale, refresh it before claiming current behavior.
2. Call `plan_turn` with the resolved repository, the concrete task, and the exact active model identifier when known. Do not guess a model identifier. Use `announce_model` only when `plan_turn` is inappropriate.
3. Obey the returned routing envelope:
   - `high`: open the recommended symbols or files directly and use at most two supplementary reads.
   - `medium`: inspect the recommendations and use at most five supplementary reads.
   - `low`: report that the implementation probably does not exist; do not keep searching for a preferred answer.
4. Call `suggest_queries` when the repository or subsystem is unfamiliar.
5. Prefer `assemble_task_context` with an explicit token budget for a well-defined engineering task. Use `get_ranked_context` when ranked evidence from several files is more useful than a single symbol.

If only `menu`, `route`, and `order` are exposed, stay on that compact surface: use `route` for a concrete task, `menu` when the action is unclear, and `order` for a known action. Set `allow_state_change=true` for indexing or reindexing. Do not widen the tool tier merely to reach primitives.

## Retrieve narrowly

- Orient with `get_repo_outline`, `get_repo_map`, or a scoped `get_file_tree`.
- Find named code with `search_symbols`; add `kind`, `language`, `file_pattern`, or `decorator` filters when useful. Fetch selected implementations with `get_symbol_source`, batching related symbol IDs.
- For conceptual, synonym-heavy, or legacy-terminology searches, use hybrid `search_symbols(..., semantic=true)`. Keep lexical ranking in the blend; use `semantic_only=true` only for deliberate similarity exploration.
- Use `search_text` for strings, comments, configuration values, and regex, and `search_columns` for database-column questions.
- Call `get_file_outline` before retrieving from a known file. Prefer `get_context_bundle` for a symbol plus imports. Use `get_file_content` only for the smallest necessary range when symbol retrieval cannot answer the question.
- Match relationship and change questions to structural tools: `find_importers`, `find_references`, `check_references`, `get_dependency_graph`, `get_call_hierarchy`, `get_class_hierarchy`, `get_blast_radius`, `get_impact_preview`, `check_edit_safe`, `check_rename_safe`, `check_delete_safe`, or `plan_refactoring`.
- When `search_symbols` returns `negative_evidence.verdict="no_implementation_found"`, report the missing implementation and stop searching synonyms. Treat `related_existing` as nearby context, not proof that the requested behavior exists. Examine `low_confidence_matches` critically.

## Use embeddings deliberately

- Prefer hybrid semantic search for conceptual navigation in large or legacy repositories; do not make `semantic_only` the default.
- Treat `embed_repo` as an optional warm-up, not a prerequisite: semantic search can lazily embed missing symbols, but precomputing avoids a slow first semantic query in a large repository.
- Do not run `embed_repo` on every task. Use `force=true` only after changing the embedding model or provider, repairing drift, or when the user explicitly requests a full rebuild.
- Use `check_embedding_drift` when stored-vector consistency is in doubt. Model and provider selection belongs in global jCodeMunch configuration, not per-project task instructions.

## Interpret and refresh

- Check `_meta.confidence`, `_meta.freshness`, negative-evidence verdicts, coverage exclusions, truncation, `auto_compacted`, and budget warnings before drawing conclusions. If `repo_is_stale=true`, refresh the index before claiming current behavior.
- Trust a strong top result when confidence is at least `0.8`. At `0.4` or below, widen one scoped search or report the gap; do not repeatedly reformulate the same query.
- Request verified exact source before quoting behavior or editing. Use `get_session_context` to avoid rereading evidence already loaded in the current session, and stop exploring when a budget warning appears.
- Accept MUNCH compact output when parseable. Retry once with `format="json"` when it is not.

## Complete changes

1. Before a risky edit, retrieve the exact affected symbols and use the appropriate impact or safety tool.
2. Make the change with normal editing tools.
3. Call `register_edit` with every edited path unless `get_watch_status` confirms that an active watcher has already refreshed them. Batch five or more paths in one call.
4. Use `get_changed_symbols` or targeted retrieval when semantic verification of the edit matters.
5. Run the repository's native tests, lint, type checks, or builds appropriate to the change.
