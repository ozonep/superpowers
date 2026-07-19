---
name: domain-modeling
description: Use when domain terms are overloaded, business rules conflict, ownership boundaries are unclear, or work requires a ubiquitous language or bounded-context model.
---

# Domain Modeling

## Outcome

A precise model gives each concept an unambiguous meaning within its bounded context and separates business facts from unresolved architecture choices.

## Method

1. Extract actors, entities, value objects, relationships, lifecycle facts, cardinalities, and invariants.
2. Define each term unambiguously within its bounded context. When the same word has different legitimate meanings across contexts, qualify it by context instead of forcing one global definition; name misleading synonyms to avoid.
3. Stress-test the model with concrete scenarios, especially different timing, ownership, and many-to-many cases.
4. Compare user statements, documentation, and source behavior. Report contradictions instead of silently choosing one truth.
5. Identify the authoritative owner for each independently governed fact. For federated or derived facts, make every contributing owner and the authority or reconciliation rule explicit. Describe cross-context relationships semantically: what fact moves, from which owner, with what invariant.

Return the canonical language, ownership boundaries, invariants, contradictions, and open decisions. Keep glossary definitions free of implementation details.

## Architecture boundary

The domain model determines what concepts mean and who owns facts. It does not by itself choose HTTP versus events, a broker, database schema, framework, or consistency mechanism.

When an architecture choice is unresolved, list the missing decision drivers—such as latency, consistency, availability, failure recovery, ordering, and operational ownership—and leave the choice open. Do not recommend a mechanism merely because it is common or fits the model.

An ADR records a selected, hard-to-reverse trade-off and its reasons. An unmade choice is an open decision, not an ADR. Terms, invariants, bugs, and routine renames belong in the model or implementation work, not ADRs.

## Completion bar

Every important term is unambiguous within its context, cross-context homonyms are qualified, cardinalities and invariants are explicit, fact authority is explicit, contradictions are visible, and unresolved design choices remain honestly unresolved.
