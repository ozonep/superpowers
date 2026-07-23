---
name: ponytail-audit
description: Use when the user requests a read-only, repository-wide audit specifically for overengineering, unnecessary complexity, removable code or dependencies, or behavior-preserving simplification. Do not use for change-set reviews, comprehensive correctness, security, or performance audits, or requests to apply fixes.
---

# Ponytail Audit

Audit the current repository for verified, behavior-preserving simplifications without editing files or Git state.

## Establish scope

Honor any path or exclusion the user gives. Otherwise audit the whole current worktree, including relevant untracked source. Inspect applicable repository instructions, architecture and user-facing documentation, source, tests, manifests, dependency and lock files, build configuration, and supported platforms.

Map the major components and dependency surfaces before investigating likely hotspots. Exclude generated or build output and third-party vendored internals; account for their inclusion when it is itself a candidate cost. State any inaccessible, skipped, or sampled area.

## Finding bar

Report only verified opportunities tagged as:

- `delete`: remove code, a dependency, configuration, or flexibility with no required consumer;
- `reuse`: replace a local implementation with an existing repository capability;
- `stdlib` or `native`: use a standard-library or platform capability that covers the required semantics and supported environments;
- `yagni`: collapse a speculative abstraction, option, or extension point after disproving meaningful variation;
- `shrink`: remove duplication or delegating indirection without obscuring a real boundary.

Before reporting a candidate, trace callers and references across source, tests, configuration, build tooling, public APIs, and plausible dynamic, generated, or external use. Check dependency declarations and locks plus the exact replacement's semantics and platform support. One implementation, one caller, text-search absence, or fewer files or lines is not sufficient evidence.

Preserve correctness, security controls, validation, accessibility, data integrity, compatibility, required observability, relevant tests, meaningful architectural boundaries, and material performance. Discard speculative claims.

## Report

Lead with findings ordered by confidence and expected maintenance value. Use:

`path:line [tag] Remove or replace <thing> with <smallest alternative>. Evidence: <why behavior is preserved>.`

Name the concrete current cost and exact replacement. Do not invent aggregate line or dependency savings. If there are no findings, say `No verified repository-wide simplification findings.` Do not imply the repository is otherwise correct or production-ready.

Then state the audited scope, validation performed, and residual uncertainty. Note any material correctness or security risk separately and recommend the appropriate focused review.

Complete after covering every major in-scope component and dependency surface and verifying each reported finding. Stop searching an area once its implementation, consumers, contract, and replacement semantics are established; do not repeat equivalent scans. Do not call a sampled audit exhaustive.
