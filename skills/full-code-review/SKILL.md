---
name: full-code-review
description: Use when the user requests a comprehensive, read-only review of a PR, branch, commit, diff, or working tree across correctness, repository standards, and unnecessary complexity.
---

# Full Code Review

Review the requested change without editing files or Git state. Success means the scope is explicit, changed behavior is traced into relevant callers and tests, every reported finding is verified and actionable, and the final answer is prioritized rather than a dump of suspicions.

## Establish scope and evidence

Preserve any target or base the user gives. Otherwise infer the narrowest safe scope from context:

- Working tree or uncommitted changes: tracked staged and unstaged changes plus relevant untracked files.
- Branch or PR: the merge-base diff against the PR base, upstream default branch, or obvious base.
- Commit or range: the requested commit or range.

Ask only when ambiguity would materially change the review. Record resolved revisions and inspect applicable `AGENTS.md`, repository standards, referenced issue/spec/PR, surrounding implementation, callers, and tests. A missing formal spec does not stop review; use documented behavior and public contracts, and label remaining uncertainty.

## Review lenses

For substantive changes, this skill authorizes up to three parallel read-only subagents for independent lenses; use fewer or review sequentially when the diff is small or capacity/cost outweighs separation. Workers must not edit, mutate Git, or delegate.

- **Correctness & contract:** runtime failures, requirement gaps, unsafe state transitions, boundary/error/concurrency behavior, security, compatibility, performance, and tests that falsely pass or omit a specific high-risk path.
- **Standards & maintainability:** applicable repository rules first; then names, duplication, coupling, and code smells only when they create a concrete maintenance or correctness cost. Skip formatting and lint nits tooling owns.
- **Simplicity:** behavior-preserving deletion, inlining, standard-library or native replacement, and removal of speculative abstractions. Do not propose broad redesigns or line-count churn.

Each candidate finding needs a changed-file location, concrete trigger, impact, evidence, and confidence. The main reviewer must inspect the relevant code and use targeted read-only checks, tests, or documentation when practical; deduplicate overlaps, resolve conflicts, and discard unsupported findings.

## Report

Lead with findings ordered by severity, then confidence. Use `[P0]` through `[P3]`, a precise title, file/line, and a concise explanation of trigger and impact; include the smallest useful fix direction when clear. Report only issues the author would likely address. Do not hide correctness findings inside style advice.

If there are no findings, say so explicitly. Then state the reviewed scope and validation performed, followed by residual risks or open questions. Do not emit raw lane reports, smell inventories, or aggregate line-saving estimates.

Stop once all changed behavior with plausible material risk is examined. If a required artifact or validation is unavailable, name the gap instead of guessing.
