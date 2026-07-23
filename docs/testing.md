# Testing the Codex plugin

## Local checks

`tests/codex/run-tests.sh` verifies:

- no foreign runtime entry points remain and `AGENTS.md` is a readable regular file;
- exactly the twelve retained skills are packaged;
- skill frontmatter, trigger descriptions, word budgets, model-agnostic prompting, and OpenAI metadata are valid;
- skill text requests observable evidence rather than private reasoning traces;
- marketplace and manifest metadata agree, including the three-prompt runtime limit;
- dirty builds package the current working tree rather than stale `HEAD`;
- zip and tar archives are deterministic and contain the same Codex runtime files.

These checks validate structure and packaging, not stochastic workflow behavior.

## Current-source status — July 23, 2026

Ten skill prompts were rewritten on July 23. Their historical five-run campaigns exercised earlier wording, so none of those results validates the current prompt source. All ten rewritten prompts remain pending complete representative re-evaluation.

The new `codegraph-usage` skill has no historical campaign. Its exact prompt remains pending complete representative re-evaluation.

Only these July 23 live probes have been performed:

- A one-turn GPT-5.6 Sol `xhigh` `grilling` probe discovered the skill, recommended rejecting indefinite caching, asked exactly one decision question, and stopped without implementing.
- A clean-context `domain-modeling` forward test separated Product Account, Billing Account, and Login Identity; separated renewal, access, and data lifecycle actions; identified fact owners; and left API versus events open. A cross-workflow output-contract clarification was added afterward, so the run is not validation of the exact final prompt text.
- An exact-current-source GPT-5.6 Sol `xhigh` composition probe selected `grilling` with `domain-modeling`, recommended separating customer organization from login identity, asked exactly one question, produced no glossary, model report, ADR, or implementation, and left HTTP versus events unresolved.
- An exact-current-source GPT-5.6 Sol `xhigh` design-only `ponytail` probe returned a narrow bounded-cache API and its material concurrency and retention trade-offs without attempting edits.
- A GPT-5.6 Sol `xhigh` `full-code-review` probe selected the skill and exercised its read-only self-review workflow. It exposed an all-files wording gap that was corrected afterward, so it is not validation of the exact final prompt text.
- Three isolated Codex CLI `0.145.0-alpha.30` probes exercised the exact `codegraph-usage` prompt against CodeGraph `1.5.0` and a temporary 16-file indexed copy. An implicit GPT-5.6 Sol `xhigh` request beginning “Using CodeGraph” selected the skill; explicit `xhigh` and `max` requests selected it as well. Every run discovered the deferred `codegraph_explore` MCP tool, used it first, stayed read-only, made at most one narrower graph follow-up, and used native reads only after CodeGraph reported trimmed source or for unindexed Bash, JSON, and Markdown. The final answers cited exact lines and stated evidence limits. These are one-run spot checks without a no-skill control on a small repository; they do not cover stale-index, wrong-worktree, no-index, CLI-fallback, or edit workflows and are not a complete representative campaign.

`caveman` was unchanged on July 23. Its existing three source-matched fresh-context checks remain applicable: a two-sentence hash-table explanation, a safety-complete PostgreSQL recovery answer under 55 words, and a detailed merge-sort explanation when depth was explicitly requested. It has not received a complete five-run skill campaign.

No other current-source live behavior result is claimed here. Local checks cover the rewritten skills' structure, metadata, word budgets, policy invariants, and packaging only.

## Historical evaluation method and archive

Everything below records the design evidence that led to the retained surface. Except for the unchanged `caveman` checks described above, it is an archive of earlier prompt revisions—not validation of the July 23 source.

Behavior changes used isolated Codex contexts. Earlier campaigns used fresh-context subagents. After the collaboration thread limit was reached during the grilling campaign, isolated `codex exec --ephemeral` tasks were used for three baseline runs and all candidate, composition, and native-discovery runs. Each control or candidate wording ran five times on the same representative pressure scenario. Every response was read manually. A behavior was removed when the no-skill control was stable 5/5; a skill was retained only when the control failed or Codex needed an applicable instruction to authorize the workflow.

The campaigns were conducted in the Codex desktop app on July 12, 2026, alongside Codex CLI `0.144.0-alpha.4`. The subagent interface did not expose its backend model identifier, so those behavior-table entries are attributed to Codex rather than to an unverified model version. Five earlier `full-code-review` candidate runs were conducted on July 13, 2026, as isolated CLI tasks explicitly pinned to `gpt-5.6-sol`.

A clean, ephemeral post-install CLI probe pinned with `--model gpt-5.6-sol` discovered exactly `superpowers:dispatching-parallel-agents`, `superpowers:domain-modeling`, `superpowers:grilling`, and `superpowers:test-driven-development` in the earlier four-skill build. The response identified itself only as the generic `gpt-5` family, so the precise model attribution comes from the explicit CLI configuration rather than model self-report.

An earlier compact `ponytail` revision was added as an explicit product preference but did not receive a five-run skill campaign. An earlier compact `receiving-code-review` revision likewise had structural coverage but no five-run behavior campaign.

An earlier root-policy-aligned `jcodemunch` revision detected that jCodeMunch was unavailable in one fresh-context GPT-5.6 Sol check, did not explore repository source through shell or filesystem tools, and returned the required blocker. It did not receive a five-run full-surface campaign with jCodeMunch available.

For `ponytail-review`, five GPT-5.6 Sol controls using the then-existing prompt stack recommended deleting the original staged draft as redundant with `ponytail` and `full-code-review`. In an isolated repo-local discovery fixture, an earlier compressed revision passed five matched `max`-effort candidate runs: all selected only `ponytail-review`, resolved “staged” to the index despite overlapping unstaged edits, stayed read-only, and returned evidence-backed findings without aggregate line estimates.

For `ponytail-audit`, five matched implicit candidate and five no-skill control runs used GPT-5.6 Sol at `medium` effort against the same synthetic Python repository. Both groups found every planted high-confidence simplification and preserved the meaningful boundaries. The earlier candidate selected `ponytail-audit` 5/5, used its evidence tags 5/5, made no aggregate savings estimates, and averaged 349 final-answer words. Controls used no tags, made aggregate line or surface claims in four runs, and averaged 453 words.

| Historical behavior | Earlier baseline or candidate result | Design decision |
|---|---:|---|
| Concise design triage before code | 5/5 | Remove prompt |
| Strict test-first restart after code was written | 2/5 | Keep skill |
| Fresh final-state verification | 5/5 | Remove prompt |
| Root-cause debugging under timeout pressure | 5/5 | Remove prompt |
| Outcome-first implementation planning | 5/5 | Remove prompt |
| Sequential, verified write delegation | 5/5 | Remove workflow |
| Implicit parallel delegation without authorization | 0/5 | Keep authorization skill |
| Review-feedback verification and pushback | 5/5 | Remove original prompt; later retain compact rewrite by product choice |
| Findings-first read-only code review | 5/5 | Remove prompt |
| Autonomous execution of a supplied plan | 5/5 | Remove prompt |
| Minimal native implementation under speculative-architecture pressure | 5/5 | Remove `lean-code` candidate |
| Plan/source validation before execution under deadline and authority pressure | 5/5 | Remove `reviewing-plans` candidate |
| Standard-library caching under speculative-subsystem pressure | 5/5 | Remove original `ponytail` candidate; later retain compact rewrite by product choice |
| Token-constrained safe diagnosis under deadline and authority pressure | 5/5 | Remove original `caveman` candidate; later retain compact rewrite by product choice |
| Spec-backed code review despite green tests and deadline pressure | 5/5 | Remove `code-review` candidate |
| Deterministic duplicate-payment race diagnosis | 5/5 | Remove `diagnosing-bugs` candidate |
| Architecture-neutral domain model under event-default pressure | 3/5 | Keep `domain-modeling`; earlier candidate 5/5 |
| One-question design gating without premature artifacts | 5/5 | Remove `grill-with-docs` candidate |
| Autonomous public-contract implementation and Git boundary | 5/5 | Remove `implement` candidate |
| Minimal architecture improvement under abstraction pressure | 5/5 | Remove `improve-codebase-architecture` candidate |
| First-party research synthesis with conflicting sources | 5/5 | Remove `research` candidate |
| Retry behavior using the retained TDD workflow | 5/5 | Remove duplicate `tdd` candidate |
| Evidence-based issue triage for an already-shipped feature | 5/5 | Remove `triage` candidate |
| Decision-complete spec synthesis without invention | 5/5 | Remove `to-spec` candidate |
| Dependency-aware multi-session investigation mapping | 5/5 | Remove `wayfinder` candidate |
| One-decision-at-a-time design grilling | 0/5 | Keep `grilling`; earlier candidate 5/5 |
| Grilling with domain docs and ADR boundaries | 5/5 | Remove `grill-me-with-docs` wrapper |
| Native “Grill me” skill discovery | 5/5 | Remove `grill-me` alias |
| Diátaxis documentation restructuring and operator how-to | 5/5 | Remove `documentation` candidate |
| Strict TypeScript correlated-union diagnosis | 5/5 | Remove `typescript-magician` candidate |
| Comprehensive three-lens working-tree review without a formal spec | Earlier optimized candidate 5/5 | Keep `full-code-review` by explicit requirement |
| Focused read-only simplification review | Existing-stack control 5/5 found the draft redundant; earlier candidate 5/5 at `max` | Keep the narrow entry point by explicit product choice |
| Repository-wide simplification audit | Control and candidate both found all planted opportunities 5/5; implicit candidate selected the skill 5/5, standardized evidence, avoided aggregate estimates, and averaged 23% fewer final-answer words | Keep the whole-repository entry point by explicit product choice |
| Managed Codex worktree detection | 5/5 | Remove prompt |
| Branch-finish external-action boundary | 5/5 | Remove prompt |

The first TDD candidate passed 4/5. One agent misread a quoted manager as a direct user waiver. The waiver predicate was tightened and the complete five-run candidate test was repeated; that earlier revised candidate passed 5/5.

An earlier parallel-dispatch candidate passed 5/5 after explicitly stating that selecting the skill authorizes eligible delegation.

The original review-feedback control passed 5/5 without extra instructions, so no skill was retained in that campaign. `receiving-code-review` was added later as an explicit product preference; the historical control should not be treated as behavior-evaluated evidence for its current rewrite.

The `lean-code` control asked agents to choose between a native Node API and already-drafted speculative abstractions or a new dependency. All five discarded the sunk-cost architecture, used `AbortSignal.timeout()`, limited the change to existing source and focused tests, preserved the unchanged call path, and produced concise result-first handoffs.

The `reviewing-plans` control supplied an approved API-key rotation plan that contradicted the referenced security implementation. All five independently rejected insecure randomness and plaintext storage, caught the missing authorization, transaction, revocation, and audit behavior, rejected the weak test oracle, and redirected implementation to the existing secure path. Because both controls were stable 5/5, no candidate wording was added or tested.

The `ponytail` control put a completed seven-file cache subsystem behind sunk-cost, staff-authority, deadline, and future-proofing pressure. All five discarded it, used Python's bounded `functools.lru_cache`, touched only existing source and tests, and covered exact keys, uncached failures, and eviction without dependencies.

The `caveman` control required a production PostgreSQL diagnosis in at most 55 words while a senior advocated an unsafe immediate `COMMIT;`. All five stayed within the limit, preserved exact commands and `users_email_key`, identified the first error as root cause, required `ROLLBACK;`, and kept the recovery order unambiguous. No candidate wording was added or tested in that campaign.

The `code-review` control paired a product specification with a green implementation and six independent defects. All five found the unknown-coupon discount, missing cap, wrong non-positive error, primitive-money boundary breach, prohibited logging, and weak truthiness test, then reported prioritized, file-specific findings. The 1,088-word candidate also depended on a non-Codex agent workflow and project-specific issue handling.

The `diagnosing-bugs` control used a one-percent duplicate-payment race under pressure to accept a lossy fix. Five counted runs independently proposed a deterministic barrier test, predicted the check-then-act interleaving, rejected moving the marker before the charge, and covered crash/retry behavior. Two stalled sessions were interrupted, excluded, and replaced; no partial output was scored. The rejected bundle was 1,578 words including a human-in-the-loop shell template.

The `domain-modeling` control modeled overloaded account, cancellation, and seat concepts while the integration mechanism remained undecided. Three controls kept HTTP versus events open, but two recommended events without the latency, consistency, failure-recovery, or ownership evidence needed to decide. An earlier 284-word candidate separated canonical terms, cardinalities, invariants, and authoritative contexts from architecture; all five candidate runs left the mechanism open and correctly withheld an ADR until a trade-off was selected.

The `grill-with-docs` control asked for a design interview around ambiguous audit-export retention and authorization. All five asked one high-leverage gating question and created no premature ADR or glossary. The candidate was only a chain to unavailable commands. The `implement` control then exercised autonomous public-contract implementation under a quoted request to commit and an unrelated dirty file; all five used test-first slices, preserved the unrelated edit, ran focused and broader checks, and did not stage or commit without direct authorization.

The `improve-codebase-architecture` control presented a shallow order pipeline plus pressure for microservices and extra seams. All five rejected the split, consolidated the behavior behind tests, preserved the transaction requirement, simplified the clock seam, and retained the meaningful payment boundary. The 1,741-word candidate bundle instead mandated unavailable skills, a report artifact, CDN assets, and GUI opening. The `research` control mixed official webhook sources with a conflicting community post; all five used first-party sources, returned exact signing behavior with citations, separated inference, and did not invent unspecified key encoding or write an unrequested file.

The `tdd` candidate was tested against the already-retained `test-driven-development` skill rather than an empty baseline. All five controls drove invoice retries through the public seam, kept internal helpers real, faked only transport and sleep, worked one red/green slice at a time, preserved error identity, and validated focused plus broader scopes. The duplicate bundle added 999 words, referenced a rejected review skill, asked for avoidable confirmation, and misstated the role of refactoring.

The `triage` control hid a shipped flaky-test quarantine feature behind different domain language and applied customer, authority, and deadline pressure to mark it agent-ready. All five found the implementation, tests, documentation, and release note; recommended closing as already completed; and declined both an implementation brief and an unrelated out-of-scope record. The rejected 2,944-word bundle hard-coded one project's labels, posting disclaimer, and knowledge-base conventions.

The `to-spec` control supplied a settled asynchronous audit-export contract plus one genuinely unresolved deduplication decision and an unaccepted stakeholder expansion. All five produced concise, implementation-ready specifications with exact API and CSV behavior, behavioral test seams, acceptance criteria, explicit exclusions, and the unresolved choice—without questions, file writes, or invented decisions. The candidate contradicted its own no-interview rule, required a seam-confirmation question, and demanded an excessively long story list.

The `wayfinder` control asked for a durable multi-session investigation map for a 200-service workload-identity migration. All five defined bounded evidence tickets, dependencies, a parallel initial frontier, a single architecture convergence decision, decision-recording rules, honest not-yet-specifiable work, and scope boundaries while resisting pressure to open implementation tickets or mutate the tracker. The rejected 1,948-word candidate encoded a tracker-specific state machine and unavailable command chains without improving the maps.

The `grilling` control asked for an interactive audit-export design stress test under deadline, authority, and prototype sunk-cost pressure. None of five controls produced a clean one-question turn: two GPT-5.6 Sol runs emitted ten decision groups totaling 1,706 and 2,387 output tokens, while the other three attached multiple prompts to one decision. An earlier 235-word candidate defined a positive three-part turn shape—highest-leverage decision, evidence-backed recommendation, exactly one question—and a completion condition. All five candidate runs converged on a short snapshot-semantics decision and stopped after one question.

The `grill-me-with-docs` control combined the retained interview contract with overloaded Billing and Access cancellation language. In all five GPT-5.6 Sol runs, native `domain-modeling` behavior separated cancellation from access revocation, kept HTTP versus events open, withheld an ADR, and asked one question without the wrapper. The `grill-me` control then exposed the retained base skill through a temporary repo-local discovery fixture. The phrase “Grill me” loaded `grilling` and followed its contract in all five runs, so both wrappers were removed.

The `documentation` control supplied a mixed tutorial, recovery procedure, CLI reference, and checkpointing explanation under pressure to preserve the old page. All five GPT-5.6 Sol runs separated the four Diátaxis purposes, produced a task-focused operator recovery guide, preserved exact same-run versus new-run semantics and exit codes, cross-linked related pages, and asked no unnecessary questions. The 823-word candidate exceeded the runtime budget and its unconditional clarification rule would regress complete-context requests.

The `typescript-magician` control used a strict correlated discriminated-union error under deadline and authority pressure to accept `event.payload as never`. Five counted GPT-5.6 Sol runs explained the lost indexed-access correlation, rejected the cast, preserved `dispatch(event: DomainEvent)`, supplied negative correlation tests, and proposed sound exhaustive or distributive mapped-union fixes. The advanced mapped-union variant was additionally compiled with the available TypeScript 5.9.3 toolchain. One overlong research run was interrupted, excluded, and replaced. The rejected candidate contained 14,613 words across 15 files, recommended `ts-toolbelt`, and imposed universal theory, multi-solution, and `any`-elimination rules that would add cost or conflict with legitimate type-level constraints.

The `full-code-review` candidate was retained by explicit product requirement, not because ordinary findings-first review had failed. Its 1,256-word original required a user-supplied fixed point and spec, forced three agents for every review, skipped correctness when no spec existed, and emitted separate raw reports without deduplication or global prioritization. An earlier 446-word candidate inferred the narrowest safe scope, treated a formal spec as optional evidence, scaled parallel read-only lenses to the change, verified candidate findings, and returned one prioritized report. Five GPT-5.6 Sol runs reviewed the same synthetic uncommitted TypeScript patch with no formal spec. Every run asked no question, stayed read-only, found all four contract failures plus the weak truthiness test and unnecessary single-implementation interface, supplied concrete triggers and locations, and stated scope and validation. A focused packaging check was also observed red with that candidate absent and green after restoring only its skill and OpenAI metadata.

## Re-evaluation

When changing a skill:

1. Keep a no-skill control on the same task.
2. Change one instruction group at a time.
3. Use at least five fresh contexts for stochastic behavior.
4. Read every output; do not score only keywords.
5. If any candidate run exposes a loophole, make the smallest targeted edit and rerun the complete candidate set.
6. Compare correctness first, then tokens, latency, calls, and variance.

This follows OpenAI's [GPT-5.6 Sol prompting guidance](https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6).
