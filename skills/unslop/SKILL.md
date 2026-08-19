---
name: unslop
description: Use when the user asks to rewrite or review prose for generic AI-sounding language, canned structure, hype, or chatbot mannerisms while preserving its meaning and intended voice. Do not use for ordinary writing requests, code, or quoted text that the user did not ask to rewrite.
---

# Unslop

## Outcome

Produce specific, natural prose that fits its author, audience, and purpose without changing what the source can support. Do not promise that text will evade AI detection.

## Authority and evidence

- Treat the source's facts, stance, uncertainty, citations, required terminology, format, and audience as fixed unless the user asks to change them.
- Do not invent facts, sources, measurements, opinions, anecdotes, or first-person experience to create personality.
- Preserve quotations verbatim unless the user explicitly asks to edit them. Preserve legal, compliance, and accessibility language whose wording is functional.
- For a review-only request, cite representative phrases and explain the problem; do not silently rewrite the whole artifact. For a rewrite request, return the revised prose unless the user asks for commentary.

## Edit

1. Identify actual problems in context. Prioritize generic openings and conclusions, vague attribution, unsupported hype, repeated claims, canned contrasts, forced symmetry, chatbot preambles, abstract nouns where a concrete fact is available, and formatting that fragments the argument.
2. Replace a weak passage with the clearest supported statement. Name an actor, source, mechanism, example, or number only when the source provides it. Remove an unsupported claim or flag the evidence gap instead of making it sound authoritative.
3. Cut repetition and filler. Combine or split sentences according to the argument, not a fixed rhythm. Use contractions, first person, informality, or deliberate roughness only when they fit the existing voice.
4. Keep useful technical terms. Prefer plain wording when meaning stays precise, but do not enforce a word blacklist or ban punctuation mechanically; conspicuous avoidance can sound as artificial as overuse.
5. Read the revision as continuous prose. Fix abrupt transitions, monotonous syntax, accidental tone changes, and list structures that obscure rather than clarify.

## Finish

Compare the revision with the source. Every factual claim, caveat, attribution, and commitment must still be present or intentionally removed at the user's request. Stop when the remaining choices are matters of taste or further editing would erase the author's voice. If preserving meaning conflicts with the requested tone, report the conflict rather than guessing.
