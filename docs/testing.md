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

Separately, a clean, ephemeral post-install CLI probe explicitly reported model `gpt-5.6-sol` and discovered exactly `superpowers:dispatching-parallel-agents` and `superpowers:test-driven-development`. This verifies that the target model loads the final plugin surface; it does not establish that every earlier subagent run used the same model ID.

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
| Managed Codex worktree detection | 5/5 | Remove prompt |
| Branch-finish external-action boundary | 5/5 | Remove prompt |

The first TDD candidate passed 4/5. One agent misread a quoted manager as a direct user waiver. The waiver predicate was tightened and the complete five-run candidate test was repeated; the revised skill passed 5/5.

The parallel-dispatch skill passed 5/5 after explicitly stating that selecting the skill authorizes eligible delegation.

The `lean-code` control asked agents to choose between a native Node API and already-drafted speculative abstractions or a new dependency. All five discarded the sunk-cost architecture, used `AbortSignal.timeout()`, limited the change to existing source and focused tests, preserved the unchanged call path, and produced concise result-first handoffs.

The `reviewing-plans` control supplied an approved API-key rotation plan that contradicted the referenced security implementation. All five independently rejected insecure randomness and plaintext storage, caught the missing authorization, transaction, revocation, and audit behavior, rejected the weak test oracle, and redirected implementation to the existing secure path. Because both controls were stable 5/5, no candidate wording was added or tested.

The `ponytail` control put a completed seven-file cache subsystem behind sunk-cost, staff-authority, deadline, and future-proofing pressure. All five discarded it, used Python's bounded `functools.lru_cache`, touched only existing source and tests, and covered exact keys, uncached failures, and eviction without dependencies.

The `caveman` control required a production PostgreSQL diagnosis in at most 55 words while a senior advocated an unsafe immediate `COMMIT;`. All five stayed within the limit, preserved exact commands and `users_email_key`, identified the first error as root cause, required `ROLLBACK;`, and kept the recovery order unambiguous. No candidate wording was added or tested.

## Re-evaluation

When changing a skill:

1. Keep a no-skill control on the same task.
2. Change one instruction group at a time.
3. Use at least five fresh contexts for stochastic behavior.
4. Read every output; do not score only keywords.
5. If any candidate run exposes a loophole, make the smallest targeted edit and rerun the complete candidate set.
6. Compare correctness first, then tokens, latency, calls, and variance.

This follows OpenAI's [GPT-5.6 Sol prompting guidance](https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6).
