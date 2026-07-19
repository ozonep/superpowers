---
name: receiving-code-review
description: Use when the user supplies code-review feedback or asks to assess, address, or respond to review comments. Verify suggestions against repository evidence, apply only authorized valid changes, and give evidence-backed pushback or blockers for the rest. Do not use for a fresh code review.
---

# Receiving Code Review

## Outcome

Every in-scope comment gets an evidence-backed disposition. 
Authorized valid changes are implemented and verified; invalid, stale, or out-of-scope comments get a concise reason; unresolved ambiguity becomes the smallest blocker.

## Authority

- If the user asks to assess or explain feedback, inspect and report without editing files, mutating Git, or responding externally.
- If the user asks to address or fix feedback, implement validated in-scope changes and run relevant validation.
- Reply to or resolve external review threads only when the user explicitly asks. Preserve inline context with a thread-specific capability when available; do not substitute a top-level comment.

## Evaluate each comment

1. Gather the exact comment, referenced revision, relevant diff, repository instructions, intended behavior, and nearby tests.
2. Classify it as valid, already satisfied or stale, unclear, incorrect or incompatible, or optional and out of scope.
3. Verify claims against the implementation, callers, public contracts, supported platforms, and tests. Reviewer identity or seniority is not evidence.
4. Decide independently for each comment unless multiple comments depend on the same unresolved choice or root cause.

Ask only when ambiguity would materially change the result and cannot be resolved from available evidence. Continue independent clear items. 
Pause only the dependent group when partial implementation would be risky, and request the smallest missing fact.

## Apply validated feedback

- Fix the underlying issue once; deduplicate comments that point to the same cause.
- Preserve user decisions, repository contracts, compatibility, and unrelated work. Push back with evidence when a suggestion would violate them.
- Do not infer that code is unused from text search alone. Check public, dynamic, generated, and external call paths that are plausible for the repo.
- Run targeted validation for changed behavior, then any broader checks required by the repository. Do not claim a comment is fixed against stale results.

## Report

Lead with the verified result, not generic praise or apology. For each non-obvious item, state its disposition and decisive evidence. 
Report applied changes with validation, declined changes with technical reasoning, and blocked items with the missing fact. 
Correct disproved pushback briefly and continue.

## Completion bar

Every requested comment has a clear disposition, every authorized change is validated, remaining uncertainty is explicit, and no external reply or thread resolution occurred without authorization.
