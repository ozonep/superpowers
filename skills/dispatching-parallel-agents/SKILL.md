---
name: dispatching-parallel-agents
description: Use when two or more read-heavy or otherwise independent subtasks can run concurrently without shared mutable state, sequential dependencies, or overlapping edits.
---

# Dispatching Parallel Agents

## Outcome

Independent work runs concurrently in bounded Codex subagents, while the main thread retains decisions, synthesis, and final validation.

Selecting this skill is an explicit instruction to use subagents for the eligible work below. It satisfies Codex’s delegation boundary even when the user did not use the word “subagent.”

## Eligibility gate

Delegate only when all are true:

- At least two useful work items exist.
- One item’s result does not determine another item’s next action.
- Agents can work without coordinating shared state.
- Read scopes or write ownership can be separated clearly.
- The expected speed or context benefit exceeds coordination cost.

Prefer parallel agents for exploration, log/test analysis, documentation lookup, triage, and focused reviews. For write-heavy work, default to sequential execution; parallelize only when file ownership is disjoint and integration risk is low.

## Workflow

1. Partition by problem domain, not by arbitrary file count.
2. Reserve one concurrency slot for the main thread and avoid spawning more agents than useful domains.
3. Call `spawn_agent` once per domain without waiting between spawns.
   - Use `fork_turns: "none"` for clean isolation when the task can be explained from repository files.
   - Fork recent or full context only when conversation decisions are essential and cannot be named concisely.
4. Give each agent an outcome-first prompt containing:
   - exact scope and exclusions;
   - evidence or files to inspect;
   - mutation policy;
   - required return shape and stopping condition.
5. Continue useful main-thread work or call `wait_agent`; collect every requested result before synthesis.
6. Treat agent summaries as claims. Check material file references, conflicting conclusions, and any edits before relying on them.
7. Synthesize one answer organized by the user’s problem, not by agent identity.

Use `send_message` to add context to a running agent, `followup_task` for a new turn on an existing agent, and `interrupt_agent` when its current route is no longer useful.

## Stop rules

Do not parallelize when failures may share one root cause, tasks edit the same area, one result gates the next, or the partition requires duplicated broad context. Investigate the shared cause in the main thread or sequence the work instead.

Completion requires all requested agents accounted for, conflicts resolved, edits integrated safely, and the relevant parent-level validation run.
