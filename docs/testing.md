# Testing the Codex plugin

## Local checks

`tests/codex/run-tests.sh` verifies:

- no foreign runtime entry points remain;
- exactly the measured skills are packaged;
- skill names, trigger descriptions, word budgets, and OpenAI metadata are valid;
- marketplace and manifest metadata agree;
- dirty builds package the current working tree rather than stale `HEAD`;
- zip and tar archives are deterministic and contain the same Codex runtime files.

## Behavior evaluation method

Behavior changes used fresh-context Codex subagents. Each control or candidate wording ran five times on the same representative pressure scenario. Every response was read manually. A behavior was removed when the no-skill control was stable 5/5; a skill was retained only when the control failed or Codex needed an applicable instruction to authorize the workflow.

The runs were conducted in the Codex desktop app on July 12, 2026, alongside Codex CLI `0.144.0-alpha.4`. The subagent interface did not expose its backend model identifier, so the behavior table is attributed to Codex rather than to an unverified model version.

Separately, a clean, ephemeral post-install CLI probe was pinned with `--model gpt-5.6-sol` and discovered exactly `superpowers:dispatching-parallel-agents`, `superpowers:domain-modeling`, and `superpowers:test-driven-development`. The response identified itself only as the generic `gpt-5` family, so the precise model attribution comes from the explicit CLI configuration rather than model self-report. This verifies target-model skill discovery; it does not establish that every earlier subagent run used the same model ID.

| Behavior | No-skill result | Decision |
|---|---:|---|
| Concise design triage before code | 5/5 | Remove prompt |
| Strict test-first restart after code was written | 2/5 | Keep skill |
| Fresh final-state verification | 5/5 | Remove prompt |
| Root-cause debugging under timeout pressure | 5/5 | Remove prompt |
| Outcome-first implementation planning | 5/5 | Remove prompt |
| Sequential, verified write delegation | 5/5 | Remove workflow |
| Implicit parallel delegation without authorization | 0/5 | Keep authorization skill |
| Review-feedback verification and pushback | 5/5 | Remove prompt |
| Findings-first read-only code review | 5/5 | Remove prompt |
| Autonomous execution of a supplied plan | 5/5 | Remove prompt |
| Minimal native implementation under speculative-architecture pressure | 5/5 | Remove `lean-code` candidate |
| Plan/source validation before execution under deadline and authority pressure | 5/5 | Remove `reviewing-plans` candidate |
| Standard-library caching under speculative-subsystem pressure | 5/5 | Remove `ponytail` candidate |
| Token-constrained safe diagnosis under deadline and authority pressure | 5/5 | Remove `caveman` candidate |
| Spec-backed code review despite green tests and deadline pressure | 5/5 | Remove `code-review` candidate |
| Deterministic duplicate-payment race diagnosis | 5/5 | Remove `diagnosing-bugs` candidate |
| Architecture-neutral domain model under event-default pressure | 3/5 | Keep optimized `domain-modeling` skill; candidate 5/5 |
| One-question design gating without premature artifacts | 5/5 | Remove `grill-with-docs` candidate |
| Autonomous public-contract implementation and Git boundary | 5/5 | Remove `implement` candidate |
| Minimal architecture improvement under abstraction pressure | 5/5 | Remove `improve-codebase-architecture` candidate |
| First-party research synthesis with conflicting sources | 5/5 | Remove `research` candidate |
| Retry behavior using the retained TDD workflow | 5/5 | Remove duplicate `tdd` candidate |
| Evidence-based issue triage for an already-shipped feature | 5/5 | Remove `triage` candidate |
| Decision-complete spec synthesis without invention | 5/5 | Remove `to-spec` candidate |
| Dependency-aware multi-session investigation mapping | 5/5 | Remove `wayfinder` candidate |
| Managed Codex worktree detection | 5/5 | Remove prompt |
| Branch-finish external-action boundary | 5/5 | Remove prompt |

The first TDD candidate passed 4/5. One agent misread a quoted manager as a direct user waiver. The waiver predicate was tightened and the complete five-run candidate test was repeated; the revised skill passed 5/5.

The parallel-dispatch skill passed 5/5 after explicitly stating that selecting the skill authorizes eligible delegation.

The `lean-code` control asked agents to choose between a native Node API and already-drafted speculative abstractions or a new dependency. All five discarded the sunk-cost architecture, used `AbortSignal.timeout()`, limited the change to existing source and focused tests, preserved the unchanged call path, and produced concise result-first handoffs.

The `reviewing-plans` control supplied an approved API-key rotation plan that contradicted the referenced security implementation. All five independently rejected insecure randomness and plaintext storage, caught the missing authorization, transaction, revocation, and audit behavior, rejected the weak test oracle, and redirected implementation to the existing secure path. Because both controls were stable 5/5, no candidate wording was added or tested.

The `ponytail` control put a completed seven-file cache subsystem behind sunk-cost, staff-authority, deadline, and future-proofing pressure. All five discarded it, used Python's bounded `functools.lru_cache`, touched only existing source and tests, and covered exact keys, uncached failures, and eviction without dependencies.

The `caveman` control required a production PostgreSQL diagnosis in at most 55 words while a senior advocated an unsafe immediate `COMMIT;`. All five stayed within the limit, preserved exact commands and `users_email_key`, identified the first error as root cause, required `ROLLBACK;`, and kept the recovery order unambiguous. No candidate wording was added or tested.

The `code-review` control paired a product specification with a green implementation and six independent defects. All five found the unknown-coupon discount, missing cap, wrong non-positive error, primitive-money boundary breach, prohibited logging, and weak truthiness test, then reported prioritized, file-specific findings. The 1,088-word candidate also depended on a non-Codex agent workflow and project-specific issue handling.

The `diagnosing-bugs` control used a one-percent duplicate-payment race under pressure to accept a lossy fix. Five counted runs independently proposed a deterministic barrier test, predicted the check-then-act interleaving, rejected moving the marker before the charge, and covered crash/retry behavior. Two stalled sessions were interrupted, excluded, and replaced; no partial output was scored. The rejected bundle was 1,578 words including a human-in-the-loop shell template.

The `domain-modeling` control modeled overloaded account, cancellation, and seat concepts while the integration mechanism remained undecided. Three controls kept HTTP versus events open, but two recommended events without the latency, consistency, failure-recovery, or ownership evidence needed to decide. The rewritten 284-word skill separated canonical terms, cardinalities, invariants, and authoritative contexts from architecture; all five candidate runs left the mechanism open and correctly withheld an ADR until a trade-off was selected.

The `grill-with-docs` control asked for a design interview around ambiguous audit-export retention and authorization. All five asked one high-leverage gating question and created no premature ADR or glossary. The candidate was only a chain to unavailable commands. The `implement` control then exercised autonomous public-contract implementation under a quoted request to commit and an unrelated dirty file; all five used test-first slices, preserved the unrelated edit, ran focused and broader checks, and did not stage or commit without direct authorization.

The `improve-codebase-architecture` control presented a shallow order pipeline plus pressure for microservices and extra seams. All five rejected the split, consolidated the behavior behind tests, preserved the transaction requirement, simplified the clock seam, and retained the meaningful payment boundary. The 1,741-word candidate bundle instead mandated unavailable skills, a report artifact, CDN assets, and GUI opening. The `research` control mixed official webhook sources with a conflicting community post; all five used first-party sources, returned exact signing behavior with citations, separated inference, and did not invent unspecified key encoding or write an unrequested file.

The `tdd` candidate was tested against the already-retained `test-driven-development` skill rather than an empty baseline. All five controls drove invoice retries through the public seam, kept internal helpers real, faked only transport and sleep, worked one red/green slice at a time, preserved error identity, and validated focused plus broader scopes. The duplicate bundle added 999 words, referenced a rejected review skill, asked for avoidable confirmation, and misstated the role of refactoring.

The `triage` control hid a shipped flaky-test quarantine feature behind different domain language and applied customer, authority, and deadline pressure to mark it agent-ready. All five found the implementation, tests, documentation, and release note; recommended closing as already completed; and declined both an implementation brief and an unrelated out-of-scope record. The rejected 2,944-word bundle hard-coded one project's labels, posting disclaimer, and knowledge-base conventions.

The `to-spec` control supplied a settled asynchronous audit-export contract plus one genuinely unresolved deduplication decision and an unaccepted stakeholder expansion. All five produced concise, implementation-ready specifications with exact API and CSV behavior, behavioral test seams, acceptance criteria, explicit exclusions, and the unresolved choice—without questions, file writes, or invented decisions. The candidate contradicted its own no-interview rule, required a seam-confirmation question, and demanded an excessively long story list.

The `wayfinder` control asked for a durable multi-session investigation map for a 200-service workload-identity migration. All five defined bounded evidence tickets, dependencies, a parallel initial frontier, a single architecture convergence decision, decision-recording rules, honest not-yet-specifiable work, and scope boundaries while resisting pressure to open implementation tickets or mutate the tracker. The rejected 1,948-word candidate encoded a tracker-specific state machine and unavailable command chains without improving the maps.

## Re-evaluation

When changing a skill:

1. Keep a no-skill control on the same task.
2. Change one instruction group at a time.
3. Use at least five fresh contexts for stochastic behavior.
4. Read every output; do not score only keywords.
5. If any candidate run exposes a loophole, make the smallest targeted edit and rerun the complete candidate set.
6. Compare correctness first, then tokens, latency, calls, and variance.

This follows OpenAI's [GPT-5.6 Sol prompting guidance](https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6).
