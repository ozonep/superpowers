---
name: typescript-best-practices
description: Use when writing, reviewing, or refactoring TypeScript and type modeling, narrowing, unsafe input, or compiler guarantees materially affect correctness. Do not use for JavaScript-only work, generated code, formatting-only edits, or work governed by a more specific repository rule.
---

# TypeScript best practices

## Outcome

Make meaningful invalid states difficult to represent and boundary failures explicit while preserving readability, runtime behavior, public contracts, and repository conventions.

## Scope and authority

- Inspect applicable instructions, `tsconfig`, TypeScript version, lint rules, schemas, nearby patterns, callers, and tests before changing types.
- For reviews, report evidence and consequences without editing. For implementation requests, make the smallest in-scope change and validate it.
- Do not upgrade TypeScript, enable project-wide flags, add a validator, change a public API, or start a broad cleanup unless authorized or required.

## Decision rules

1. Treat untrusted or untyped input as `unknown`. Validate it once at the owning boundary with the project's existing parser or schema, then pass a typed value inward. Contain unavoidable `any` at the smallest interop surface.
2. Use discriminated unions for closed variants when optional-field bags permit contradictory states. Preserve open or extensible data models when consumers must accept future variants.
3. Strengthen a type only when it removes a partial operation, unsafe assertion, or duplicated invariant check. Use tuples, readonly data, or branded/opaque types with a checked constructor when they encode a domain fact; an alias alone does not validate runtime data.
4. Prefer inference and control-flow narrowing. Use `satisfies` to check conformance without replacing the inferred type. Treat `as T` and `!` as evidence obligations: keep them local and use them only when a runtime fact is guaranteed but TypeScript cannot express it. Do not confuse `as const` with an unchecked conversion.
5. Make closed-union handling exhaustive with a `never` assignment or `assertNever`. Do not add a default that hides new variants.
6. Derive types from a canonical schema or implementation when they share ownership. Define an explicit domain or public type when decoupling is intentional; do not chain `Pick` and `Omit` merely to avoid naming a type.
7. Prefer total APIs. If empty, missing, or failure is valid, represent it in the return type. If it is invalid by contract, enforce that fact at the owner instead of scattering throws or non-null assertions.

Read [TypeScript patterns](references/patterns.md) only when an example would help apply one of these decisions.

## Evidence and stop condition

Trace the value from source through affected uses and state the enforced invariant. Run the repository's typecheck and smallest relevant tests; typechecking does not replace runtime boundary or behavior tests. Stop when the behavior is typed without unsupported assertions, relevant checks pass, and more type machinery would encode no real invariant. Report compiler-version, validation, or test gaps precisely.
