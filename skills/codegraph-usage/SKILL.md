---
name: codegraph-usage
description: Use when Codex must locate, read, understand, trace, review, debug, plan, or change source in a project with a .codegraph/ index, or when CodeGraph output is stale, incomplete, ambiguous, or unavailable. Prefer CodeGraph for indexed source structure; use native tools for uncovered content and correctness validation.
---

# CodeGraph Usage

## Outcome

Retrieve enough current source and structural context to answer or edit confidently, then stop. 
Default to one `codegraph_explore` call instead of a grep/read loop.

## Query the graph

- Prefer the read-only MCP tool. If MCP tools are deferred, discover `codegraph_explore` before treating it as unavailable. 
  In a non-MCP harness, use `codegraph explore "<query>"`.
- Pass a short natural-language question or a bag of symbol and file names. For a flow, name both endpoints and any known intermediate symbols. 
  For a known file or symbol, name it directly.
- Pass the absolute `projectPath` when the server has no default indexed project or when querying another indexed repository.
- Treat returned line-numbered source as already read. Do not re-open or grep the same code. 
  Make one narrower follow-up only for omitted, truncated, or missing material.
- Use native search/read for unsupported, ignored, excluded, or oversized files, prose and lockfiles, withheld configuration values, or a specific gap CodeGraph did not cover.

`codegraph affected <files...>` may identify candidate tests for changed files. It does not run tests and never replaces the repository's normal validation.

## Evidence bar

- Trust returned source only when no freshness or worktree warning applies. For a per-file pending-sync banner, read only the listed files directly. 
  If auto-sync is disabled or the index belongs to another worktree, use current-worktree source until the warning is resolved.
- Treat call paths, dynamic-dispatch links, and blast radius as best-effort static analysis. Heuristic edges are useful evidence; missing edges are not proof of no dependency. 
  Use targeted native search when reflection, runtime registration, unsupported framework behavior, ambiguity, or truncation leaves a material gap.
- Use tests, compiler or type checks, lint, and runtime evidence for correctness. CodeGraph supplies navigation and impact context, not behavioral proof.

## Authority and stop conditions

CodeGraph MCP queries are read-only. Do not run `install`, `init`, `index`, `sync`, `uninit`, `upgrade`, or telemetry-changing commands unless the user explicitly asks.
Index creation and repair remain the user's decision.

Stop retrieval when the answer or edit has sufficient current evidence. 
If a project has no `.codegraph/`, both MCP and CLI access are unavailable, or one focused retry still cannot cover the required evidence, use built-in tools for that project and do not keep retrying CodeGraph. 
You may mention `codegraph init`; do not run it.
