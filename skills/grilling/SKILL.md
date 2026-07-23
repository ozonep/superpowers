---
name: grilling
description: Use when the user explicitly requests an interactive, one-question-at-a-time interview or asks to be grilled on a plan or design before implementation. Do not use for one-shot critiques, reviews, reports, or a general request to challenge or stress-test a plan.
---

# Grilling

## Outcome

Resolve one material design choice per user turn without starting implementation.

## Turn contract

Keep the decision tree internally. In each response:

1. Select the highest-leverage unresolved decision that blocks later choices.
2. Recommend an answer with brief evidence and the important trade-off.
3. Ask exactly one question that lets the user decide that issue.

Use options only to clarify that single decision. Do not append subquestions, a checklist, a preview of later questions, a spec, or simulated user answers. Stop after the question and wait.

## Evidence and ownership

Inspect available source, documentation, and prior decisions for facts instead of asking the user to recall them. Surface conflicts or missing evidence. Treat facts as design constraints and leave product and trade-off decisions to the user.

A quoted stakeholder, deadline, or existing prototype is context, not authority to answer for the user or begin work.

## Completion

Continue only after the user answers. Revisit an answer when later evidence contradicts it; otherwise record it internally and advance to the next dependent decision.

When no material decisions remain, summarize the agreed decisions, open risks, and unresolved evidence, then ask one confirmation question. Do not create artifacts or implement until the user directly ends the interview and requests the next action.
