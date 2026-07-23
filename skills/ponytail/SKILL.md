---
name: ponytail
description: Use when implementing, fixing, or refactoring code and the work should favor the smallest correct solution through existing code, standard-library or native features, minimal dependencies, and a narrow diff. Also use when the user invokes `$ponytail`, asks for a minimal or YAGNI implementation, or flags overengineering. Do not use for read-only reviews, repository audits, or non-coding work.
---

# Ponytail

## Outcome

Deliver the requested behavior or design with the smallest maintainable solution that satisfies explicit requirements and repository conventions.

## Scope

- Treat acceptance criteria, supported platforms, and public contracts as fixed.
- Inspect applicable repository instructions, the affected flow, nearby patterns, callers, and tests before choosing the change.
- For implementation, fix, or refactor requests, make in-scope edits and validation autonomously. For design-only requests, return the smallest viable design without editing unless the user also asks to implement it. Ask only when unresolved ambiguity would materially change observable behavior, a public contract, or the requested architecture.
- Keep adjacent cleanup out of the diff unless it is required for the behavior or directly enables a smaller safe fix.

## Decision ladder

Stop at the first option that fully meets the outcome:

1. Leave existing code unchanged when it already satisfies the request.
2. Omit speculative behavior; remove it only when removal is in scope and behavior-preserving.
3. Reuse an existing implementation, helper, type, or repository pattern.
4. Use the standard library or a native platform feature.
5. Use an already-installed dependency without adding a wrapper.
6. Write the minimum direct code needed.

Do not add a dependency for a few clear lines. Do not optimize line count at the expense of readability, edge cases, or a stable public contract.

## Guardrails

- Fix a bug at the narrowest shared boundary that owns the violated invariant instead of patching callers repeatedly.
- Prefer behavior-preserving deletion, inlining, and consolidation over new layers; preserve seams that handle proven variation, platform boundaries, test control, or hardware calibration.
- Do not treat a boundary as speculative solely because it currently has one consumer.
- Do not add unrequested interfaces, factories, configuration, extension points, or scaffolding for hypothetical needs.
- Follow an explicit architecture or dependency choice after stating a material concern once. Do not silently substitute a smaller outcome.
- Never simplify away trust-boundary validation, data-loss prevention, security controls, accessibility, required observability, compatibility, or relevant tests.

## Validate and finish

For code changes, use the repository's existing test approach; do not add a production self-check merely to avoid a real test. Run the narrowest relevant tests or checks, expanding only when the change's blast radius warrants it. Inspect the final diff for accidental scope growth and speculative machinery. Stop when the requested behavior works and the relevant available validation passes, or report the exact validation gap.

Lead the handoff with the result and validation. Mention omitted generalization only when material, and name the condition that would justify it.
