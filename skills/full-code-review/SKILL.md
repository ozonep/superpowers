---
name: full-code-review
description: Use when the user requests a comprehensive, read-only review of a PR, branch, commit, diff, or working tree across correctness, repository standards, and unnecessary complexity. Do not use for review-feedback triage or a review explicitly limited to simplification.
---

# Full Code Review

Review the requested change without editing files or Git state. Return a prioritized review built from verified, actionable findings.

## Establish scope and evidence

Preserve any target or base the user gives. Otherwise infer the narrowest safe scope from context:

- Working tree or uncommitted changes: tracked staged and unstaged changes plus relevant untracked files.
- Branch or PR: the merge-base diff against the PR base, upstream default branch, or obvious base.
- Commit or range: the requested commit or range.

Record the resolved base and head. Inspect applicable `AGENTS.md`, repository standards, referenced requirements, surrounding implementation, callers, and tests. Ask only when ambiguity would materially change the review. Without a formal spec, use documented behavior and public contracts and label uncertainty.

## Review lenses

For substantive changes, use up to three parallel read-only subagents when independent lenses add signal. Review small diffs sequentially. Do not let workers edit, mutate Git, or delegate.

- **Correctness & contract:** runtime failures, requirement gaps, unsafe state transitions, boundary/error/concurrency behavior, security, compatibility, performance, and specific high-risk test gaps.
- **Standards & maintainability:** apply repository rules first; report duplication, coupling, or smells only with concrete cost. Skip tool-owned formatting and lint.
- **Simplicity:** find behavior-preserving deletion, inlining, native replacements, and speculative abstractions. Avoid broad redesigns and line-count churn.

Require a changed-file location, concrete trigger, impact, evidence, and confidence for every candidate. Verify candidates in the main thread against implementation, plausible callers, tests, and current primary docs for version-dependent behavior. Run safe targeted checks when practical. Treat unavailable validation as a gap, not proof. Deduplicate and discard unsupported findings.

## Report

Order findings by severity, then confidence:

- **P0:** release-blocking catastrophic risk.
- **P1:** serious regression to fix before merge.
- **P2:** bounded functional defect or material maintainability risk.
- **P3:** low-impact concrete defect.

Format each as `[P0]` through `[P3]` with a precise title, changed file/line, trigger, and impact. Add the smallest useful fix direction when clear. Report only issues the author would likely address.

If none exist, say so. Then state scope, validation, and residual risks or questions. Omit raw lane reports, smell inventories, and line-saving estimates.

Stop after examining all changed behavior and affected call paths with plausible material risk. If a required artifact or validation is unavailable, name the gap instead of guessing.
