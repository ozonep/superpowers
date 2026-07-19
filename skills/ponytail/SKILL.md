---
name: ponytail
description: Use when implementing, fixing, refactoring, or designing code to choose the smallest correct solution by reusing existing code, preferring standard-library or native features, avoiding speculative abstractions and dependencies, and minimizing the diff. Also use when the user invokes `$ponytail`, requests lazy, YAGNI, or minimal implementation, or complains about overengineering. Do not use for read-only review requests or non-coding work.
---

# Ponytail

## Outcome

Deliver the requested behavior with the smallest maintainable change that satisfies explicit requirements and repository conventions. 
Simplicity never outranks correctness, security, accessibility, data integrity, or compatibility.

## Decision ladder

After understanding the affected flow, stop at the first option that meets the outcome:

1. Omit only speculative work outside the explicit request.
2. Reuse an existing implementation, helper, type, or repository pattern.
3. Use the standard library or a native platform feature.
4. Use an already-installed dependency without wrapping it in a new abstraction.
5. Write the minimum direct code needed.

Do not add a dependency for a few clear lines. Do not optimize line count at the expense of readability, edge cases, or a stable public contract.

## Constraints

- Do not add unrequested interfaces, factories, configuration, extension points, or scaffolding for hypothetical future needs.
- Prefer behavior-preserving deletion, inlining, and consolidation over new layers. Choose boring, local code over clever indirection.
- For a bug, prefer one root-cause fix at the shared boundary over repeated caller patches. Inspect the affected flow before choosing that boundary.
- Preserve seams that handle real variation, including platform boundaries, test seams, and hardware calibration. One current consumer does not make a proven boundary speculative.
- Follow an explicit user choice of architecture or dependency after stating a material concern once. Do not silently replace the requested outcome with a smaller one.

Never simplify away trust-boundary validation, error handling that prevents data loss, security controls, accessibility, required observability, or relevant tests. 
Use the repository's existing test approach; do not add a production self-check merely to avoid a real test.

## Handoff

Ponytail governs the implementation, not the prose. Lead with the result and validation. 
Mention omitted generalization only when material, and state the condition that would justify adding it.

## Completion bar

The requested behavior works, the diff contains no speculative machinery, and the most relevant available validation passes or its gap is reported.
