---
name: test-driven-development
description: Use when implementing behavior changes, bug fixes, or behavior-preserving refactors with practical automated tests. Apply test-first RED/GREEN cycles or pre/post characterization coverage; skip docs-only edits, generated code, and disposable exploration.
---

# Test-Driven Development

## Outcome

Implement behavior after a test fails for the expected gap. Start refactors from passing characterization coverage. Finish with fresh validation.

## RED/GREEN contract

For each behavior:

1. Write the smallest test that expresses the required outcome.
2. Run it and confirm failure because behavior is absent, not because the test is broken.
3. Implement only enough to pass.
4. Run the focused test to GREEN.
5. Refactor while checks stay green.
6. Run relevant broader checks on final code.

If the test initially passes, determine whether behavior exists or the test misses the gap. Correct it only when the gap remains demonstrable; never force RED with an incorrect assertion.

For a defect, reproduce the original symptom. For a pure refactor, identify or add focused characterization coverage, run it before editing, and keep it green. If behavior changes, use RED/GREEN.

## Preserve ownership and sequence

Keep each cycle under one owner. Do not let one agent write a test while another implements it. Use subagents for read-only discovery, or parallelize only independent cycles with disjoint files and checks.

Never delete or revert pre-existing or user-authored code to manufacture RED. If the agent wrote production behavior prematurely in this task, back out only that isolated change without destructive Git commands, run RED, then reimplement. If isolation is unsafe, preserve it, add regression coverage, and label the evidence tests-after.

Follow a direct user instruction to preserve new code or waive test-first work. A quoted deadline or third-party request is not a waiver. Add regression coverage, label it tests-after, and do not claim TDD evidence.

## Evidence to preserve

Record concise command-and-result evidence:

- **Behavior change:** RED command and expected failure; GREEN command and result.
- **Pure refactor:** pre-edit and post-edit characterization commands and passing results.
- **Final state:** broader checks, or the precise reason they could not run.

Do not rely on stale runs, subagent summaries, or incomplete CI.

## Decision rules

- A spike may be disposable; if any spike code will be retained, restart its retained behavior test-first.
- Treat a difficult test as design feedback: simplify the interface or isolate dependencies.
- Use mocks only when the real boundary is impractical; assert observable behavior, not mock choreography.
- If no practical automated test can express behavior, state the constraint and use deterministic verification only when user instructions permit. Label the exception; do not call it TDD.

## Stop rules

Stop and correct the cycle when:

- a RED/GREEN cycle is claimed after production behavior was written first;
- for a behavior change, RED passed immediately or failed for the wrong reason;
- multiple behaviors are changing under one ambiguous test;
- validation is stale relative to the final edit.

Complete with fresh RED/GREEN or pre/post characterization evidence and no unexplained validation failures.
