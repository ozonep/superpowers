---
name: ponytail-review
description: Use when the user requests a read-only review of a PR, diff, commit, branch, or working tree specifically for overengineering, unnecessary complexity, or behavior-preserving simplification. Do not use for a repository-wide audit, a comprehensive review, or a request to apply fixes.
---

# Ponytail Review

## Outcome

Review the requested change for verified, behavior-preserving simplifications without editing files or Git state.

## Scope

Honor any target or base the user gives. Otherwise infer the narrowest safe scope: staged means the cached diff; uncommitted means staged and unstaged changes plus relevant untracked files; a branch or PR uses its merge-base; a commit or range uses exactly that revision set.

Inspect applicable repository instructions, the task or specification, the complete scoped diff, surrounding implementation, callers, tests, and dependency configuration. Use read-only checks.
For each newly added implementation, search the repository and declared or locked dependencies for an existing equivalent before accepting custom logic.
Ask only when unresolved ambiguity would materially change the scope or preservation claim.

## Finding bar

Report only verified opportunities:

- `delete`: Remove unused or speculative behavior with no required consumer.
- `reuse`, `stdlib`, or `native`: Replace code or a dependency with an existing capability covering the required semantics and platforms.
- `inline` or `shrink`: Remove indirection or duplication without obscuring a meaningful boundary.

Tie every finding to a changed line or to complexity introduced or made materially worse by the change. Before reporting it, trace plausible public, dynamic, generated, and external use; verify the replacement's semantics and platform support; and check relevant tests and contracts.

Treat one implementation, one caller, text-search absence, or a lower line count as a lead, not proof. Preserve correctness, security, validation, accessibility, data integrity, compatibility, required observability, relevant tests, meaningful boundaries, and material performance. Discard speculative claims.

Keep findings limited to complexity. Note any material correctness or security risk separately and recommend a comprehensive review.

## Report

Lead with findings ordered by confidence and expected maintenance value. Use:

`path:line [tag] Remove or replace <thing> with <smallest alternative>. Evidence: <why behavior is preserved>.`

Name the concrete cost, smallest replacement, and preservation evidence. Omit style preferences, formatting nits, and aggregate line-saving estimates.
If there are no findings, say `No verified simplification findings.` Do not imply the change is otherwise correct or ready to ship.

Then state the reviewed scope, validation performed, and residual uncertainty.
Stop investigating a candidate once its implementation, consumers, contract, and replacement semantics are established; do not repeat equivalent searches. Complete after examining every plausible material simplification in scope and confirming that no files or Git state changed.
