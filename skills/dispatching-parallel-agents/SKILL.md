---
name: dispatching-parallel-agents
description: Use when the user requests subagents or parallel agents, or when two or more independent workstreams can run concurrently without sequential dependencies, shared mutable state, or overlapping edits. Partition, coordinate, verify, and synthesize their results.
---

# Dispatching Parallel Agents

## Outcome

Run eligible independent work concurrently in bounded Codex subagents. Keep the main thread responsible for decisions, integration, synthesis, and final validation.

Treat invocation as authorization to delegate only the in-scope work. Do not expand mutation, permission, external-action, or cost boundaries.

## Eligibility gate

Delegate only when all are true:

- At least two useful work items exist.
- One item’s result does not determine another item’s next action.
- Agents can work without coordinating shared state.
- Read scopes or write ownership are clearly separable.
- The expected speed or context benefit exceeds coordination cost.

Prefer parallel agents for exploration, log/test analysis, documentation lookup, triage, and focused reviews. For write-heavy work, default to sequential execution; parallelize only when file ownership is disjoint and integration risk is low.

## Workflow

1. Partition by problem domain, not by arbitrary file count.
2. Respect the current session’s concurrency limit. Spawn no more agents than useful workstreams, and leave capacity for adaptive follow-up when practical.
3. Spawn all eligible agents before waiting.
   - Prefer a clean, no-history fork when repository files and a focused prompt provide enough context.
   - Fork recent or full context only when conversation decisions are essential and cannot be restated concisely.
4. Give each agent an outcome-first prompt containing:
   - exact scope and exclusions;
   - source artifacts or files to inspect;
   - mutation policy;
   - required evidence and return shape;
   - stopping condition;
   - whether nested delegation is allowed, defaulting to no.
5. For independent review or validation, provide raw artifacts and acceptance criteria without leaking the parent’s suspected answer.
6. Continue useful main-thread work while agents run, or wait when no independent work remains.
7. Track every agent to a terminal result. If an agent fails, stalls, or becomes blocked, add focused context, reassign the work, or finish it in the main thread; do not wait indefinitely.
8. Treat agent summaries as claims. Check material file references, conflicting conclusions, validation evidence, and shared-worktree edits before relying on them.
9. Synthesize one answer organized by the user’s problem, not by agent identity.

Use the subagent controls exposed by the current Codex surface to steer, continue, interrupt, and wait. If subagents or capacity are unavailable, execute the work sequentially and preserve the same evidence bar.

## Stop rules

Do not parallelize when failures may share one root cause, tasks edit the same area, one result gates the next, or each agent would need the same broad context. Investigate the shared cause in the main thread or sequence the work instead.

Complete only after accounting for every requested agent, resolving conflicts, inspecting integrated edits, and running relevant parent-level validation against the final state.
