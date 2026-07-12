---
name: test-driven-development
description: Use when implementing behavior changes or bug fixes where automated tests are practical; skip for docs-only edits, generated code, or explicitly disposable exploration.
---

# Test-Driven Development

## Outcome

Retained implementation is written only after a test has failed for the expected missing behavior. The completed change has focused regression coverage and fresh validation.

## Contract

For each behavior:

1. Write the smallest test that expresses the required outcome.
2. Run it and confirm it fails because the behavior is absent—not because the test is broken.
3. Implement only enough to pass.
4. Run the focused test, then relevant broader checks.
5. Refactor only while the checks stay green.

If the test passes before implementation, strengthen or correct it until it proves the gap.

## Existing implementation without a RED run

Code written first during the current task is not a head start. Remove or revert it, then reimplement from the failing test.

The pressure-tested failure mode is: “keep the implementation, add tests now, and ship if green.” That produces useful regression tests, but it is tests-after, not TDD; the tests are biased by the code already written and never proved they could catch the missing behavior.

If the user directly instructs you to preserve the code or waive test-first work, follow that higher-priority instruction. A quoted manager, teammate, deadline, or release pressure is context—not a direct user waiver. Add the best regression coverage available, label it accurately as tests-after, and do not claim TDD evidence.

## Evidence to preserve

Before calling the cycle complete, record enough output to establish:

- **RED:** command, relevant failure, and why it was expected.
- **GREEN:** command and relevant passing result after implementation.
- **REGRESSION:** broader checks run, or a precise reason they could not run.

Do not rely on a previous run, a subagent’s summary, or CI that has not completed against the final code.

## Decision rules

- A defect needs a test that reproduces the original symptom when practical.
- A refactor needs characterization coverage before behavior-preserving edits.
- A spike may be disposable; if any spike code will be retained, restart its retained behavior test-first.
- When a test is difficult to write, treat that as design feedback: simplify the interface or isolate dependencies.
- Use mocks only when the real boundary is impractical; assert observable behavior, not mock choreography.

## Stop rules

Stop and correct the cycle when:

- production behavior was written before its test;
- RED passed immediately or failed for the wrong reason;
- multiple behaviors are changing under one ambiguous test;
- validation is stale relative to the final edit.

The completion bar is fresh RED evidence, fresh GREEN evidence, and no unexplained failures in the relevant validation scope.
