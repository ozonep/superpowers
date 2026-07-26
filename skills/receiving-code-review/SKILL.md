---
name: receiving-code-review
description: Use when the user supplies code-review feedback or asks to assess, fix, or respond to review comments. Verify and classify each comment against repository evidence, and apply only authorized valid changes. Do not use for a fresh code review.
---

# Receiving Code Review

## Outcome

Give every requested comment an evidence-backed disposition and take only the action the user authorized.

## Authority

- **Assess or explain:** inspect and report without editing files, mutating Git, or replying externally.
- **Address or fix:** implement only validated, in-scope feedback and run relevant validation.
- **Reply or resolve threads:** act only when explicitly requested; preserve the specific thread or inline context.

## Classify each comment

For every requested identifier:

1. Locate the exact comment and its referenced revision or diff.
2. Separate the underlying concern from the suggested remedy. A valid concern does not make its proposed implementation correct.
3. Classify it as valid, partially valid, already satisfied or stale, unclear, incorrect or incompatible, or optional and out of scope. If a remedy is safe only after another change or condition, classify it as partially valid and state the prerequisite.
4. Support the disposition with decisive repository evidence from the changed code and only the callers, contracts, tests, or platform behavior needed to verify it. Verify the complete claim and replacement semantics when later transformations or callers can change the result. Reviewer status and deadline are not evidence.

Ask only for a missing fact that would materially change a disposition or make authorized implementation unsafe. Continue independent comments.

If changes are authorized, fix each verified root cause once and validate the affected behavior. Report every identifier with its disposition and evidence; name applied changes, declined remedies, and exact blockers.

## Completion bar

Complete when every requested comment is accounted for, authorized changes have fresh validation, uncertainty is explicit, and no file, Git, or external-thread action exceeded the user's authority.
