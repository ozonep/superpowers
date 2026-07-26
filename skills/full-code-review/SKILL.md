---
name: full-code-review
description: Use when the user requests a comprehensive, read-only review of a PR, branch, commit, diff, or working tree across correctness, repository standards, and unnecessary complexity. Do not use for review-feedback triage or a review explicitly limited to simplification.
---

# Full Code Review

Review the requested change without editing files or Git state. Return only prioritized, verified, actionable findings.

## Scope and evidence

Preserve the user's target and base. Otherwise use the narrowest safe scope: staged, unstaged, and relevant untracked files for a working tree; a merge-base diff for a branch or PR; or the requested commit range. Record base and head.

Read applicable `AGENTS.md`, repository rules, requirements, surrounding code, and tests. Ask only if ambiguity would materially change the review. Treat documented behavior and public APIs as contracts; label uncertainty.

## Trace changed behavior

For every substantive changed symbol or behavior, inspect:

1. The changed entry point, state, representation, or invariant.
2. Direct and indirect callers or consumers.
3. Contracts and conversions at each boundary.
4. Tests for that path and its nearest material boundary cases.

Follow at least one plausible end-to-end call path per behavior change. Reconcile representations and error semantics across boundaries. Passing changed-file tests does not prove caller compatibility.

Use up to three read-only subagents only when available and independent passes add signal; otherwise work sequentially. Workers must not edit, mutate Git, or delegate. Do not claim delegation unless the call succeeds; on failure, continue sequentially. Cover:

- **Correctness and contract:** regressions, boundaries, errors, state, concurrency, security, compatibility, performance, and high-risk test gaps.
- **Standards and maintainability:** repository rules first; report smells only with concrete cost. Skip tool-owned formatting.
- **Simplicity:** find behavior-preserving deletion, inlining, native replacements, and speculative abstractions. Avoid broad redesigns and line-count churn.

Each candidate needs a changed-file location, trigger, observable impact, supporting call path or contract, and confidence. Verify it in the main thread against code, callers, tests, and primary documentation when version-sensitive. Run safe targeted checks when practical. Deduplicate and discard speculative or pre-existing issues.

## Report and stop

Order findings by severity, then confidence: P0 catastrophic release blocker; P1 serious pre-merge regression; P2 bounded functional defect or material maintainability risk; P3 low-impact concrete defect.

Prefix each finding `[P0]` through `[P3]`. Give it a precise title, changed file and line, trigger, impact, and smallest useful fix direction when clear. Report only issues the author would likely address. If none exist, say so. State scope, validation, and residual risks or unavailable evidence. Omit lane transcripts and inventories.

Stop after tracing every changed behavior through materially affected call paths and verifying or discarding all candidates. Name unavailable required evidence instead of guessing.
