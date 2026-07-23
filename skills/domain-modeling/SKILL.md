---
name: domain-modeling
description: Use when the user asks for domain modeling, a ubiquitous language, a glossary, bounded contexts, fact ownership, or business invariants, or when domain terms are overloaded, business rules conflict, or ownership boundaries are unclear.
---

# Domain Modeling

## Outcome

Produce a precise, evidence-grounded model of context-specific language, business rules, and fact ownership.

## Evidence and scope

- Honor the named business area and supplied artifacts. Inspect relevant documentation and source when available; do not invent domain facts.
- Distinguish observed facts, supported inferences, contradictions, and open decisions. Cite file and line or another precise source when artifacts provide evidence.
- Ask only when a missing answer blocks a materially different model. Otherwise record the uncertainty and continue.
- Model only distinctions that affect language, behavior, ownership, or cross-context communication.

## Method

1. Identify candidate bounded contexts and their responsibilities before defining terms.
2. Extract actors, entities, value objects, relationships, lifecycle facts, cardinalities, and invariants.
3. Define each term within its context. Qualify legitimate homonyms by context and name misleading synonyms to avoid.
4. Stress-test the model with concrete scenarios, especially timing, lifecycle transitions, ownership changes, and many-to-many cases.
5. Compare user statements, documentation, and source behavior. Preserve conflicting claims with their evidence instead of silently selecting one truth.
6. Identify the authoritative owner for each independently governed fact. For federated or derived facts, name every contributor and the authority or reconciliation rule. Describe cross-context relationships semantically: which fact moves, from which owner, and under which invariant.

When the domain model is the requested deliverable, return only relevant sections: bounded contexts, canonical language, relationships and cardinalities, lifecycle rules, invariants, fact ownership, contradictions, and open decisions. When modeling supports another active workflow, supply only the facts it needs and follow that workflow's output contract. Keep glossary definitions free of implementation details.

## Architecture boundary

Use the domain model to determine what concepts mean and who owns facts. Do not let it implicitly choose HTTP versus events, a broker, database schema, framework, or consistency mechanism.

For an unresolved architecture choice, list the missing decision drivers—such as latency, consistency, availability, failure recovery, ordering, and operational ownership—and leave the choice open. Do not recommend a mechanism merely because it is common or fits the model.

Reserve ADRs for selected, hard-to-reverse trade-offs and their reasons. Keep an unmade choice as an open decision; keep terms, invariants, bugs, and routine renames in the model or implementation work.

## Finish

Finish when every important term is unambiguous within its context, cross-context homonyms are qualified, cardinalities and invariants are explicit, fact authority is clear, contradictions remain visible, and unresolved design choices remain honestly unresolved. Stop decomposing concepts when further distinctions would not change a rule, owner, or integration fact.
