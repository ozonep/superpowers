---
name: ponytail-review
description: Use when the user requests a read-only review of a PR, diff, commit, branch, or working tree limited to overengineering, unnecessary complexity, or behavior-preserving simplification. Do not use for comprehensive reviews or requests to apply fixes.
---

# Ponytail Review

Review the requested change for unnecessary complexity without editing files or Git state.

## Scope

Preserve any target or base the user gives. 
Otherwise infer the narrowest safe scope: staged means the cached diff; uncommitted means staged and unstaged changes plus relevant untracked files; a branch or PR uses its merge-base; a commit or range uses exactly that revision set.

Inspect applicable repository instructions, task or specification, surrounding implementation, callers, tests, and dependency configuration. Use read-only checks. 
For each newly added implementation, search the repository and declared or locked dependencies for an existing equivalent before accepting custom logic.
Ask only when unresolved ambiguity would materially change the scope or preservation claim.

## Finding bar

Report only verified opportunities to:

- `delete` unused or speculative behavior with no required consumer;
- `reuse`, `stdlib`, or `native` replace code or a dependency with an existing capability covering the required semantics and platforms;
- `inline` or `shrink` remove indirection or duplication without obscuring a meaningful boundary.

One implementation, one current caller, text-search absence, or fewer lines is not sufficient. Check plausible public, dynamic, generated, and external use.
Preserve correctness, security, validation, accessibility, data integrity, compatibility, required observability and tests, and material performance.
Discard speculative claims.

Keep findings limited to complexity. Note any material correctness or security risk separately and recommend a comprehensive review.

## Report

Lead with findings ordered by confidence and expected maintenance value. Use:

`path:line [tag] Remove or replace <thing> with <smallest alternative>. Evidence: <why behavior is preserved>.`

Name the concrete cost, smallest replacement, and preservation evidence. Omit style preferences, formatting nits, and aggregate line-saving estimates. 
If there are no findings, say `No verified simplification findings.` Do not imply the change is otherwise correct or ready to ship.

Then state the reviewed scope, validation performed, and residual uncertainty.
Complete when every plausible material simplification in scope has been examined and no files or Git state were changed.
