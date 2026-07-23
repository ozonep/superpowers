---
name: ponytail-audit
description: Use when the user requests a read-only, repository-wide audit specifically for overengineering, unnecessary complexity, removable code or dependencies, or behavior-preserving simplification. Do not use for a PR or diff review, a comprehensive correctness, security, or performance audit, or a request to apply fixes.
---

# Ponytail Audit

## Outcome

Audit the current repository for verified, behavior-preserving simplifications without editing files or Git state.

## Establish scope

Honor any path or exclusion the user gives. Otherwise audit the whole current worktree, including relevant untracked source. Inspect applicable repository instructions, architecture and user-facing documentation, source, tests, manifests, dependency and lock files, build configuration, and supported platforms.

Map major components, public boundaries, and dependency surfaces before investigating hotspots. Exclude generated output, build output, and vendored internals; still assess whether including them is itself an avoidable cost. State every inaccessible, skipped, or sampled area.

## Finding bar

Report only verified opportunities:

- `delete`: Remove code, a dependency, configuration, or flexibility with no required consumer.
- `reuse`: Replace a local implementation with an existing repository capability.
- `stdlib` or `native`: Use a standard-library or platform capability covering the required semantics and supported environments.
- `yagni`: Collapse a speculative abstraction, option, or extension point after checking for meaningful variation.
- `shrink`: Remove duplication or delegating indirection without obscuring a real boundary.

Before reporting a candidate:

1. Identify the exact current cost and smallest concrete replacement.
2. Trace callers and references across source, tests, configuration, build tooling, public APIs, and plausible dynamic, generated, or external use.
3. Check declarations and lock data for dependencies, plus the replacement's exact semantics and supported platforms.
4. Verify preservation of correctness, security controls, validation, accessibility, data integrity, compatibility, required observability, relevant tests, meaningful boundaries, and material performance.

Treat one implementation, one caller, text-search absence, or a lower line count as a lead, not proof. Discard claims that depend on unsupported assumptions.

## Report

Lead with findings ordered by confidence and expected maintenance value. Use:

`path:line [tag] Remove or replace <thing> with <smallest alternative>. Evidence: <why behavior is preserved>.`

Name the concrete current cost and exact replacement. Do not invent aggregate line or dependency savings. If there are no findings, say `No verified repository-wide simplification findings.` Do not imply the repository is otherwise correct or production-ready.

Then state the audited scope, validation performed, and residual uncertainty. Note any material correctness or security risk separately and recommend the appropriate focused review.

Complete after covering every major in-scope component and dependency surface and verifying each reported finding. Stop searching an area once its responsibilities, consumers, contract, and replacement semantics are established. Do not repeat equivalent searches under synonymous hypotheses, and do not call a sampled audit exhaustive.
