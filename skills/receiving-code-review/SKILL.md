---
name: receiving-code-review
description: Use when the user supplies code-review feedback or asks to assess, fix, or respond to review comments. Verify and classify each comment against repository evidence, and apply only authorized valid changes. Do not use for a fresh code review.
---

# Receiving Code Review

## Outcome

Give every requested comment an evidence-backed disposition. Implement and verify authorized valid changes; explain invalid, stale, or out-of-scope comments concisely; reduce unresolved ambiguity to the smallest blocker.

## Authority

- If the user asks to assess or explain feedback, inspect and report without editing files, mutating Git, or responding externally.
- If the user asks to address or fix feedback, implement validated in-scope changes and run relevant validation.
- Reply to or resolve external review threads only when the user explicitly asks. Preserve inline context with a thread-specific capability when available; do not substitute a top-level comment.

## Evaluate each comment

1. Gather the exact comment, referenced revision, relevant diff, repository instructions, intended behavior, and nearby tests.
2. Separate the underlying concern from the reviewer’s suggested remedy. A valid concern does not make the proposed implementation correct.
3. Classify the comment as valid, partially valid, already satisfied or stale, unclear, incorrect or incompatible, or optional and out of scope.
4. Verify claims against the current implementation, plausible callers, public contracts, supported platforms, and tests. Treat reviewer identity or seniority as context, not evidence.
5. Decide independently for each comment, then group comments only when they share a verified root cause or unresolved choice.

Ask only when ambiguity would materially change the result and cannot be resolved from available evidence. Continue independent clear items. Pause only the dependent group when partial implementation would be risky, and request the smallest missing fact.

## Apply validated feedback

- Fix the underlying issue once; deduplicate comments that point to the same cause.
- Preserve user decisions, repository contracts, compatibility, and unrelated work. Push back with evidence when a suggestion would violate them.
- Do not infer that code is unused from text search alone. Check public, dynamic, generated, and external call paths that are plausible for the repo.
- For behavior fixes, reproduce the reported failure with a focused test before implementation when practical.
- Run targeted validation for changed behavior, then any broader checks required by the repository. Do not claim a comment is fixed against stale results.

## Report

Lead with the verified result, not generic praise or apology. Account for every requested comment by identifier; group duplicates only after mapping each one to its disposition.

Report applied changes with fresh validation, declined changes with decisive technical evidence, and blocked items with the exact missing fact. Correct disproved pushback briefly and continue.

## Completion bar

Complete only after every requested comment has a clear disposition, every authorized change is validated, remaining uncertainty is explicit, and no external reply, unrelated-thread action, or thread resolution occurred without authorization.
