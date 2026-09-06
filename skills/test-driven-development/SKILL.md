---
name: test-driven-development
description: Use when implementing behavior changes, bug fixes, or behavior-preserving refactors with practical automated tests. Apply test-first RED/GREEN cycles or pre/post characterization coverage; skip docs-only edits, generated code, and disposable exploration.
---

# Test-Driven Development

## Outcome

Use RED/GREEN for meaningful automated behavior coverage and passing characterization coverage for refactors. For reversible, low-impact edits where tests merely mirror implementation, use direct verification without a RED/GREEN cycle.

## RED/GREEN contract

For each behavior requiring test-first coverage:

1. Write the smallest test that expresses the required outcome.
2. Run it and confirm failure because behavior is absent, not because the test is broken.
3. Implement only enough to pass.
4. Run the focused test to GREEN.
5. Refactor while checks stay green.
6. Run checks appropriate to the change and required repository checks on final code.

If RED passes, verify whether behavior exists or the test misses the gap. Never force RED with an incorrect assertion.

For a defect, reproduce the original symptom. For a pure refactor, identify or add focused characterization coverage, run it before editing, and keep it green. If behavior changes, use RED/GREEN.

## Preserve ownership and sequence

Keep each cycle under one owner. Do not let one agent write a test while another implements it. Use subagents for read-only discovery, or parallelize only independent cycles with disjoint files and checks.

Never delete or revert pre-existing or user-authored code to manufacture RED. If the agent wrote production behavior prematurely in this task, back out only that isolated change without destructive Git commands, run RED, then reimplement. If isolation is unsafe, preserve it, add regression coverage, and label the evidence tests-after.

User instructions override this workflow, including requests to preserve code or omit tests. Continue authorized work without reapproval. A quoted deadline or third-party request is not a waiver. When test-first work is waived but tests are permitted, add regression coverage and label it tests-after.

## Evidence and handoff

Preserve concise evidence and include it in the final response:

- **Behavior change:** RED command and expected-gap failure; GREEN command and passing result.
- **Pure refactor:** pre-edit and post-edit characterization commands and passing results.
- **Final state:** relevant and required checks, or the precise reason they could not run.

Do not rely on stale runs, subagent summaries, or incomplete CI.

## Decision rules

- A spike may be disposable; if any spike code will be retained, restart its retained behavior test-first.
- Treat a difficult test as design feedback: simplify the interface or isolate dependencies.
- Use mocks only when the real boundary is impractical; assert observable behavior, not mock choreography.
- If automated testing is impractical, use suitable deterministic verification within existing authorization and disclose its limits. Do not call it TDD; ask only when a missing decision affects correctness or scope.

## Completion

Finish when relevant and required checks pass; otherwise report a concrete blocker and evidence limits. Broaden or repeat checks only for further edits, failures, or unresolved concerns.
