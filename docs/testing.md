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

## TDD Astra guide alignment — September 6, 2026

`test-driven-development` was revised against the official [GPT-6 Astra guide](https://developers.openai.com/api/docs/guides/latest-model?model=gpt-6-astra), specifically initiative, instruction priority, and proportionate verification. The contract preserves authentic RED/GREEN and pre/post characterization evidence, explicitly respects user verification overrides, permits direct verification for low-impact edits whose tests would merely mirror implementation, and stops after appropriate and required checks pass. The UI starter names all three verification routes. Model and effort remain outside reusable prompts.

Four isolated tasks explicitly invoked the exact final `SKILL.md` using Codex CLI `0.153.4`, `gpt-6-astra`, and `model_reasoning_effort="medium"`. Each temporary Git workspace contained only its synthetic fixture and the skill copy. User configuration, project instruction loading, other skills, plugins, apps, memories, web search, and subagents were disabled. A fifth task used the final `default_prompt` verbatim before the static-edit request. All five completed successfully; ordered command/edit events, final diffs, and handoffs were inspected.

| Scenario | Observed final-source behavior | Evidence limits |
|---|---|---|
| Inclusive expiry bug, with a quoted teammate asking to skip test-first work | Added the equality test; `python3 -m unittest test_expiry.ExpiryTests.test_at_deadline -v` failed with `False is not true` before production changed, then passed after `>` became `>=`. Required `python3 -m unittest discover -v` passed 3 tests once; final handoff included commands and results. | One comparison bug in a standard-library Python fixture; no complex integrations or rollback pressure. |
| Direct user instruction to omit automated tests, overriding the fixture README | Made the one-line expiry fix, inspected its final diff, left tests untouched, ran no tests, and disclosed the waiver without asking again or claiming TDD. | Explicit initial-turn waiver only; no mid-turn steering. |
| Behavior-preserving name-formatting refactor | Ran existing characterization coverage before and after the edit with `python3 -m unittest discover -v`; one test covered four input combinations. Changed only `names.py` and reported both passes. | Initially tried unavailable `python`, then recovered with `python3` before editing. String inputs only; no new coverage was needed. |
| Static CSS color correction without its proprietary renderer or test infrastructure | Changed only the approved color, inspected the final diff, ran `git diff --check`, and disclosed unavailable rendering validation. No assertion script, forced RED/GREEN cycle, installation, or permission pause. | Source verification cannot establish rendered behavior. |
| Same static correction using the final UI starter | Again made only the color edit and used direct diff verification; the final answer named the checks and rendering limitation. | One starter invocation on the same small task shape. |

Final `SKILL.md` SHA-256: `187b50f29f45e4ec1c73b2ef0d9eaa90fe4415a660cfd229c8f78b63ff35e4fc` (484 words including frontmatter). Final `agents/openai.yaml` SHA-256: `3d2d3902e96d7fab377a34dbdfd1908349c78b83c6e5fddecf4ed92772c16f58`. The first three body probes copied the prior starter metadata (`4772cfc21f757bd853a4185ee730df8523ac4030f8bf83d51c6f56b04e3c9e8f`) but did not invoke it; the separate starter probe validates the final starter on the static scenario.

A preliminary four-task run exercised draft skill hash `fc00991ae0b857b58355694dae95fd296365596d6ecad7316e8643eb6fd6c23e`. Its static task unnecessarily compared the exact CSS text in a before/after assertion script, although it honestly labeled this fallback verification. Moving the proportionality decision ahead of the cycle produced the final source tested above. The preliminary run is not final-source evidence. These are unblinded, one-run synthetic spot checks without no-skill controls, repeated trials, or cost comparisons. Representative evaluation remains pending; earlier TDD campaigns still apply only to their original prompt revisions.

The unchanged repository per-skill validators and TDD handoff checks pass for the revised skill. `tests/codex/run-tests.sh` fails both before and after this change because the existing inventory assertion expects removed `ponytail`, `ponytail-audit`, and `ponytail-review` directories. Separately, marketplace validation passes and package generation includes the current TDD files; archive tests have seven existing failures for removed skills and the stale twelve-skill count. The generic skill-creator validator could not start because PyYAML is unavailable; the repository's strict YAML validator was used for the focused checks instead. These unrelated inventory assertions were left unchanged.

## Ponytail Astra Extra High comparison — September 5, 2026

The exact current `ponytail`, `ponytail-audit`, and `ponytail-review` prompts received 18 isolated tasks on Sequelize commit `0bf55694492d1f44755f93a06bf494ec6952c426`, using Codex CLI `0.153.4`, `gpt-6-astra`, and `xhigh`: two primary pairs and one boundary pair per skill. No skill text was changed.

All four implementation runs produced the same small runtime fix and passed 15/15 independent source checks. Both audit arms found all four planted simplification opportunities, preserved async timing, and honestly reported sampled coverage; extra verified dependency findings varied. Both review arms found all four opportunities and rejected stale generated smoke results as validation. All boundary cases preserved necessary code and produced no unnecessary simplification findings.

The skills did not establish a core correctness advantage. They mainly standardized preferences and reports. In primary pairs, skill input increased approximately 2%, 36%, and 67% respectively; output was approximately unchanged, +5%, and −6%. Timing showed no consistent win. The small, unblinded, partly seeded comparison is directional evidence on explicit activation, not a representative guarantee. Repository dependencies, database suites, types and the platform matrix were unavailable; source probes used disclosed stubs. A post-freeze oracle correction concerning async scheduling is documented explicitly.

See the [complete report, exact prompts, source hashes, answers, implementation patches, metrics, oracle correction, and reproduction harness](evaluations/ponytail-astra-20260905/README.md). All model/effort records, terminal states, skill loads, and expected file changes were checked.

## Astra Extra High comparison — September 5, 2026

The exact current `dispatching-parallel-agents`, `domain-modeling`, and `full-code-review` prompts received 18 scored runs on Sequelize commit `0bf55694492d1f44755f93a06bf494ec6952c426`: two fresh primary-task pairs and one boundary pair per skill, using Codex CLI `0.153.4`, `gpt-6-astra`, and `xhigh` for parents and workers. No skill text was changed. Two additional no-skill review runs isolate explicit parallel authorization from the full review skill.

Core correctness was tied in the planned pairs. Dispatch added overhead despite both arms delegating successfully; domain modeling made cardinalities and fact ownership more explicit; full review found the same four planted regressions faster with three workers but consumed more tokens. Both review arms passed a clean-patch control. The added no-skill controls also found all four regressions with workers and comparable elapsed times; parallel review did not require the skill. These are directional results on one real technical domain, not a representative quality guarantee or a universal removal decision.

See the [complete report, exact source hashes, protocol, answers, metrics, source probes, and reproduction harness](evaluations/astra-20260905/README.md). Model/effort, actual skill loads, worker completion, and unchanged product diffs were checked. Dependency-stubbed source probes were executed; Sequelize's installed-dependency and database suites were unavailable. Historical results below retain their original source/version limitations.

## New-skill current-source probes — August 19, 2026

Two isolated read-only tasks used Codex CLI `0.148.0-alpha.15` with `gpt-5.6-sol`, user configuration disabled, and a temporary repository-local copy of only the skill under test. Both natural-language requests selected the intended skill implicitly. These are one-run directional checks without no-skill controls, not representative campaigns.

| Skill | Effort and scenario | Observed result | Limits |
|---|---|---|---|
| `unslop` | `xhigh`; rewrite a deliberately promotional project update containing exact latency measurements, participation counts, a quotation, a rollout condition, and a negative caveat | Removed the generic heading, preamble, unsupported promotional paragraph, and canned contrast. Preserved every number, the quotation verbatim, the security-review condition, and the checkout-latency caveat; added no claim or opinion. | One short English project update with obvious tells; no review-only case, format variation, domain-sensitive language, control, or detector claim. The run made one harmless failed root-path read before using the discovered skill path. |
| `typescript-best-practices` | `max`; read-only review of one strict TypeScript webhook boundary against a six-line protocol contract | Reported all three planted failures with exact source and contract evidence: unchecked JSON assertion, a valid empty array escaping through a declared `string` return, and unsound forward-variant handling. Runtime probes reproduced each failure; the review proposed scoped remedies, stayed read-only, and disclosed missing compiler, tests, callers, and error-policy evidence. | One synthetic file with no installed `tsc`, callers, or tests; no implementation, reference-loading, no-skill control, or repeated run. |

The exact tested SKILL.md SHA-256 values were `3c6b736b620860771bd267c8239f3cc5cf5270bcbf48db281f28a6daef185ab2` for `unslop` and `51cec0ffff53d966583a16d503bf25397a3dc3c83d69e2b0a441f3daefcf5e2d` for `typescript-best-practices`. The TypeScript run did not load the patterns reference; a post-probe wording clarification changed that reference to the current untested SHA-256 `0be6a2d4baa609a4760288e5a3fd9a4c2c615fe585ee00f5646964b00b595c1e`. The probes support trigger routing and these two task shapes only. Both skills remain pending matched, repeated representative evaluation.

## Current-source status — July 27, 2026

Ten skill prompts were rewritten on July 23. Their historical five-run campaigns exercised earlier wording, so none of those results validates the current prompt source. All ten rewritten prompts remain pending complete representative re-evaluation, although two now have the directional exact-current-source paired probes recorded below.

### Initial July 26 paired Sequelize probes

One isolated skill run and one no-skill control per workflow used Codex CLI `0.146.0-alpha.3.1`, `gpt-5.6-sol`, and `model_reasoning_effort=max`. Each pair received the same task and an offline temporary copy of a large mixed JavaScript/TypeScript Sequelize snapshot. Candidate copies added only the tested skill. Every final answer and resulting patch was inspected. With one run per arm, these are directional spot checks, not variance-controlled campaigns.

| Skill | Skill result | No-skill control | Decision and current status |
|---|---|---|---|
| `caveman` | Correct AsyncQueue call-path explanation, 161 words | Same correct result, 188 words | Remove: no behavior gap, and the skill's discovery and activation input did not establish net efficiency for 27 fewer final-answer words. |
| `ponytail` | Correct `importModels` fix in 3 files and 55 inserted lines | Correct fix in 4 files and 81 inserted lines | Modest scope and output-efficiency signal. The unchanged tested prompt is exact current source. |
| `full-code-review` | 5/6 verified regressions, no false positives; 4,112,849 input and 21,040 output tokens | 6/6, no false positives; 4,714,900 input and 31,279 output tokens | The pre-update skill used fewer tokens in this run but missed a composite-key caller regression and announced parallel lanes without a successful receiver. The prompt was rewritten to require changed-behavior → caller → contract → test tracing and truthful conditional delegation; current source is pending fresh evaluation. |
| `test-driven-development` | Correct `importModels` fix with authentic RED before production and subsequent GREEN; final response did not give the actual RED/GREEN commands and decisive results | Correct fix, but no RED evidence | Confirms the process benefit while exposing a handoff gap. The prompt was amended to require command-and-result evidence in the final response; current source is pending fresh evaluation. |
| `receiving-code-review` | 20/20: all six comments correctly classified; 473,871 input, 10,503 output, 27 commands, 303 final words | 19/20: the same technical result, but accepted a conditionally safe remedy instead of marking it partially valid; 126,498 input, 7,127 output, 5 commands, 263 words | The tested 484-word source improved one disposition but explored disproportionately. It was compressed to the distinctive classification and authority rules, then freshly evaluated below. |
| `ponytail-review` | 4/4 simplifications, no false positives, required tags; 19/20 task plus 6/6 contract, 746,673 input, 16,723 output, 319 words | 4/4, no false positives, no tags; 20/20 task plus 5/6 contract, 927,540 input, 26,774 output, 375 words | The tested source was efficient but counted tests that resolved through a stale compiled parent. A compact changed-source provenance rule was added and freshly evaluated below. |

The exact tested skill SHA-256 values were `2c044b346ad12372fa11f334ab9ac6b394ee86c08f3e2faadc686a9f8c9de219` (now-removed `caveman`), `8e6c2bd6709f693e072e6269f4a2c4c2b90e7bd45a076070915556cb42d9de83` (`ponytail`), `12050073dd413c0149bd102989a377d4d9292756363a8accce8657bb269f4d86` (pre-update `full-code-review`), `40592d5deee3559baa30544aaadb9ae1293a0fc6ca3a7a7af873a1beca316949` (pre-update `test-driven-development`), `2798be5c0686d685ffc70287d3f25f81998c537555dac04d60d976052a8b77aa` (pre-compression `receiving-code-review`), and `932cecaff9f2f478b684e6179e0bd3d0f3847cab4b9158549a5cc64327e139b4` (pre-provenance `ponytail-review`).

### Fresh final-source reruns

Fresh isolated runs reused the frozen prompts, rubrics, and product commits. Candidate and control product trees and `HEAD^..HEAD` diffs were identical; only the candidate contained an ignored local skill. The model sandbox was read-only, candidate events showed the exact skill load, and every repository ended at the original clean Git state.

| Measure | `receiving-code-review` | Receiving control | `ponytail-review` | Ponytail control |
|---|---:|---:|---:|---:|
| Score | 20/20 | 19/20 | 26/26 | 25/26 |
| Input tokens | 466,695 | 293,597 | 1,153,372 | 1,196,819 |
| Output tokens | 13,585 | 7,323 | 16,810 | 20,290 |
| Reasoning tokens | 9,993 | 4,684 | 9,993 | 11,857 |
| Completed commands | 13 | 11 | 20 | 52 |
| Failed commands | 0 | 0 | 4 | 6 |
| Final-answer words | 305 | 308 | 307 | 418 |
| Elapsed seconds | 371 | 204 | 399 | 534 |

The final Receiving source is 320 words with SHA-256 `6ec1bec93c96adf41250b72d57aa69d7b321970da8001d15cc5c9f39c7b48905`. It preserved the full score and corrected the control's conditionally unsafe remedy label, but still cost 1.59× the control's total input and 1.82× its elapsed time. A first 284-word rewrite, SHA-256 `04f1770e7b7906322308d85c4154eb686812491fa673254b2dadd41546e686c3`, failed the frozen 19/20 acceptance bar by mishandling a prerequisite and inferring replacement semantics from only one layer; it was not retained.

The final Ponytail Review source is 469 words with SHA-256 `c85d6a579a98826d976cdc2535724cc28bed854544d3baf4bb9e1353be9d19d8`. Both arms found all four simplifications without false positives and disclosed that focused Mocha tests resolved through stale `packages/core/lib`; both supplemented them with direct current-source checks. The skill uniquely satisfied the supported-tag contract and used 4% less total input, 17% less output, 62% fewer commands, 27% fewer final words, and 25% less elapsed time.

Receiving used product range `e93cf06e2bd71d599d86741411c3a1a9079ebcfb..119c9d0b9b65258eb59b4194ebe36e833863bec3` with product-diff SHA-256 `b4022a361a7e37522f20934dfdb6069db014fc443e378f0eb127a71c289d6ac1`. Ponytail Review used `f0cea95e38b4f2c9096267371ab305d08f7b8497..f466834b217d5de27c1a75a2d09ebc64f97fbad5` with product-diff SHA-256 `70aa19a507032dc4ff5b3ec6ab890799d15dae092e58ad811deacc65ee34c9ee`. One run per arm remains directional evidence, not a complete representative campaign.

### Earlier current-source probes

The July 23 live probes were:

- A one-turn GPT-5.6 Sol `xhigh` `grilling` probe discovered the skill, recommended rejecting indefinite caching, asked exactly one decision question, and stopped without implementing.
- A clean-context `domain-modeling` forward test separated Product Account, Billing Account, and Login Identity; separated renewal, access, and data lifecycle actions; identified fact owners; and left API versus events open. A cross-workflow output-contract clarification was added afterward, so the run is not validation of the exact final prompt text.
- An exact-current-source GPT-5.6 Sol `xhigh` composition probe selected `grilling` with `domain-modeling`, recommended separating customer organization from login identity, asked exactly one question, produced no glossary, model report, ADR, or implementation, and left HTTP versus events unresolved.
- An exact-current-source GPT-5.6 Sol `xhigh` design-only `ponytail` probe returned a narrow bounded-cache API and its material concurrency and retention trade-offs without attempting edits.
- A GPT-5.6 Sol `xhigh` `full-code-review` probe selected the skill and exercised its read-only self-review workflow. It exposed an all-files wording gap that was corrected afterward, so it is not validation of the exact final prompt text.
- Three isolated Codex CLI `0.145.0-alpha.30` probes exercised the now-removed `codegraph-usage` prompt against CodeGraph `1.5.0` and a temporary 16-file indexed copy. An implicit GPT-5.6 Sol `xhigh` request beginning “Using CodeGraph” selected the skill; explicit `xhigh` and `max` requests selected it as well. Every run discovered the deferred `codegraph_explore` MCP tool, used it first, stayed read-only, made at most one narrower graph follow-up, and used native reads only after CodeGraph reported trimmed source or for unindexed Bash, JSON, and Markdown. The final answers cited exact lines and stated evidence limits. These are historical one-run spot checks without a no-skill control on a small repository; they do not validate the replacement rule.

### July 27 global repository-discovery probes

Four isolated read-only tasks used Codex CLI `0.146.0-alpha.3.1`, `gpt-5.6-sol`, `model_reasoning_effort=medium`, and the exact 208-word global `AGENTS.md` rule with SHA-256 `c10ed1e71a23ef441b2daf51f8d14ee16a988046ac9fc0f3a7deb98e2eeead3b`.

| Scenario | Observed route | Result |
|---|---|---|
| Locate `PAYMENT_RETRY_LIMIT` | One `fff` `ffgrep` call | Returned the exact definition at `src/services/payment.py:1`; no CodeGraph or native search. |
| Trace `POST /checkout` to `charge_card` and direct `PaymentService` consumers | One CodeGraph `codegraph_explore` call | Returned the complete path and both direct consumers; no repeated file read or native search. |
| Exhaustively match a multiline YAML sequence | One native multiline `rg` call | Returned both planted files and starting lines; no indexed lookup. |
| Locate the identifier with indexed tools absent | One native exact `rg` call | Returned the exact definition without installing, initializing, repairing, or syncing an index. |

The `fff` and CodeGraph MCP surfaces were deterministic read-only mocks modeled on their current public tool descriptions. One run per scenario checks final-rule routing, not stochastic reliability, real index freshness, worktree warnings, fuzzy behavior, tool failures, edit workflows, latency, tokens, or comparative performance. There was no matched control.

`caveman` was unchanged for its three source-matched fresh-context checks and the July 26 pair, but it is no longer packaged. The removed skill produced a two-sentence hash-table explanation, a safety-complete PostgreSQL recovery answer under 55 words, and a detailed merge-sort explanation when depth was requested. Separately, no-skill controls passed the historical 55-word safety task 5/5 and produced the same correct Sequelize explanation in the July 26 pair. The skill's 27-word reduction in that paired answer did not demonstrate enough savings to offset its discovery and activation input.

Use this rule instead in `~/.codex/AGENTS.md` for a personal cross-repository default, or in the target repository's root `AGENTS.md` for a shared project default:

```md
- Default final responses to the shortest complete answer; expand only for requested detail, correctness, safety, evidence, or completion.
```

The Superpowers repository's own `AGENTS.md` is development guidance and is intentionally excluded from plugin archives.

The proposed `AGENTS.md` rule was not an arm of these evaluations. It is a lower-overhead replacement surface pending matched checks, not a behavior-validated equivalent.

The fresh final-source table contains the only additional exact-current-source paired results claimed here. The July 27 repository-discovery probes are unpaired routing evidence.

## Historical evaluation method and archive

Everything below records the design evidence that led to the retained surface. Except for the unchanged current-source checks identified above, it is an archive of earlier prompt revisions—not validation of the July 26 source.

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
| Token-constrained safe diagnosis under deadline and authority pressure | 5/5 | Remove original `caveman` candidate; a later compact rewrite was also removed after the July 26 paired probe showed no capability gain or demonstrated net-efficiency gain |
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
