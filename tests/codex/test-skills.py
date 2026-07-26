#!/usr/bin/env python3
import json
from pathlib import Path
import re


class StrictYamlError(ValueError):
    """Raised when metadata falls outside this repository's YAML subset."""


def _parse_scalar(raw, line_number):
    if not raw:
        raise StrictYamlError(f"line {line_number}: missing scalar value")

    if raw.startswith('"'):
        try:
            value = json.loads(raw)
        except json.JSONDecodeError as error:
            raise StrictYamlError(
                f"line {line_number}: invalid double-quoted string"
            ) from error
        if not isinstance(value, str) or "\n" in value or "\r" in value:
            raise StrictYamlError(
                f"line {line_number}: quoted values must be one-line strings"
            )
        return value

    if raw in {"true", "false"}:
        return raw == "true"

    if raw.lower() in {"null", "~"}:
        raise StrictYamlError(f"line {line_number}: null values are not supported")
    if re.fullmatch(
        r"(?:0|[1-9][0-9_]*)(?:\.[0-9_]+)?(?:[eE][+-]?[0-9]+)?", raw
    ):
        raise StrictYamlError(
            f"line {line_number}: numeric scalars are outside the strict subset"
        )
    if raw[0] in "-?:,[]{}#&*!|>'\"%@`":
        raise StrictYamlError(
            f"line {line_number}: quote scalars beginning with YAML indicators"
        )
    if re.search(r":(?:\s|$)|\s#", raw):
        raise StrictYamlError(
            f"line {line_number}: quote ambiguous plain scalars"
        )
    return raw


def _mapping_entry(content, line_number):
    match = re.fullmatch(r"([A-Za-z_][A-Za-z0-9_-]*):(?: (.*))?", content)
    if not match:
        raise StrictYamlError(f"line {line_number}: invalid mapping entry")
    return match.group(1), match.group(2)


def _yaml_tokens(text):
    tokens = []
    for line_number, line in enumerate(text.splitlines(), 1):
        if not line:
            continue
        if not line.strip():
            raise StrictYamlError(f"line {line_number}: whitespace-only line")
        if "\t" in line:
            raise StrictYamlError(f"line {line_number}: tabs are not supported")
        if line.rstrip() != line:
            raise StrictYamlError(f"line {line_number}: trailing whitespace")

        content = line.lstrip(" ")
        indent = len(line) - len(content)
        if indent % 2:
            raise StrictYamlError(
                f"line {line_number}: indentation must use two-space steps"
            )
        if content.startswith("#"):
            raise StrictYamlError(
                f"line {line_number}: comments are outside the strict subset"
            )
        tokens.append((line_number, indent, content))

    if not tokens:
        raise StrictYamlError("empty YAML document")
    return tokens


def _parse_mapping(tokens, index, indent):
    result = {}
    while index < len(tokens):
        line_number, current_indent, content = tokens[index]
        if current_indent < indent:
            break
        if current_indent > indent:
            raise StrictYamlError(f"line {line_number}: unexpected indentation")
        if content.startswith("-"):
            raise StrictYamlError(
                f"line {line_number}: cannot mix mappings and sequences"
            )

        key, raw = _mapping_entry(content, line_number)
        if key in result:
            raise StrictYamlError(f"line {line_number}: duplicate key {key!r}")
        index += 1

        if raw is None:
            if index >= len(tokens) or tokens[index][1] != indent + 2:
                raise StrictYamlError(
                    f"line {line_number}: nested value must be indented two spaces"
                )
            value, index = _parse_block(tokens, index, indent + 2)
        else:
            value = _parse_scalar(raw, line_number)
        result[key] = value
    return result, index


def _parse_sequence(tokens, index, indent):
    result = []
    while index < len(tokens):
        line_number, current_indent, content = tokens[index]
        if current_indent < indent:
            break
        if current_indent > indent:
            raise StrictYamlError(f"line {line_number}: unexpected indentation")
        if not content.startswith("- "):
            raise StrictYamlError(
                f"line {line_number}: cannot mix sequences and mappings"
            )

        payload = content[2:]
        entry_match = re.fullmatch(
            r"([A-Za-z_][A-Za-z0-9_-]*):(?: (.*))?", payload
        )
        index += 1
        if entry_match:
            key, raw = entry_match.groups()
            if raw is None:
                if index >= len(tokens) or tokens[index][1] != indent + 2:
                    raise StrictYamlError(
                        f"line {line_number}: missing nested sequence-item value"
                    )
                value, index = _parse_block(tokens, index, indent + 2)
            else:
                value = _parse_scalar(raw, line_number)
            item = {key: value}

            if index < len(tokens) and tokens[index][1] == indent + 2:
                continuation, index = _parse_mapping(tokens, index, indent + 2)
                duplicate = item.keys() & continuation.keys()
                if duplicate:
                    repeated = sorted(duplicate)[0]
                    raise StrictYamlError(
                        f"line {line_number}: duplicate key {repeated!r}"
                    )
                item.update(continuation)
            result.append(item)
        else:
            result.append(_parse_scalar(payload, line_number))
            if index < len(tokens) and tokens[index][1] > indent:
                raise StrictYamlError(
                    f"line {tokens[index][0]}: scalar list item cannot be nested"
                )
    return result, index


def _parse_block(tokens, index, indent):
    line_number, current_indent, content = tokens[index]
    if current_indent != indent:
        raise StrictYamlError(f"line {line_number}: unexpected indentation")
    if content.startswith("- "):
        return _parse_sequence(tokens, index, indent)
    return _parse_mapping(tokens, index, indent)


def parse_strict_yaml(text):
    """Parse the intentionally small YAML subset used by Codex skill metadata."""

    tokens = _yaml_tokens(text)
    if tokens[0][1] != 0:
        raise StrictYamlError("the document must begin at indentation zero")
    value, index = _parse_block(tokens, 0, 0)
    if index != len(tokens):
        raise StrictYamlError(f"line {tokens[index][0]}: unparsed content")
    return value


MODEL_ID_PATTERN = re.compile(
    r"(?<![a-z0-9])"
    r"(?:gpt-(?:4o|\d+(?:\.\d+)?)(?:-[a-z0-9]+)*"
    r"|o(?:1|3|4)(?:-[a-z0-9]+)*)"
    r"(?![a-z0-9])",
    re.IGNORECASE,
)

PRIVATE_REASONING_REQUEST_PATTERNS = (
    re.compile(
        r"\b(?:show|reveal|provide|output|expose|display|share|report|write|give|"
        r"return|print|include|demand|request|ask\s+for)\b"
        r"[^.;!?\n]{0,100}\b"
        r"(?:chain[- ]of[- ]thought|(?:private|hidden|internal)\s+"
        r"(?:reasoning|thought\s+process))\b",
        re.IGNORECASE,
    ),
    re.compile(r"\b(?:think|reason)\s+step[- ]by[- ]step\b", re.IGNORECASE),
    re.compile(
        r"\b(?:chain[- ]of[- ]thought|(?:private|hidden|internal)\s+"
        r"(?:reasoning|thought\s+process))\b"
        r"[^.;!?\n]{0,60}\b"
        r"(?:must\s+be|should\s+be|has\s+to\s+be)"
        r"\s+(?:shown|revealed|provided|reported|included|written|output)\b",
        re.IGNORECASE,
    ),
    re.compile(
        r"\b(?:chain[- ]of[- ]thought|(?:private|hidden|internal)\s+"
        r"(?:reasoning|thought\s+process))\b"
        r"(?:(?!\b(?:not|never)\b)[^.;!?\n]){0,40}"
        r"\b(?:is\s+)?"
        r"(?:required|mandatory)\b",
        re.IGNORECASE,
    ),
)

NEGATED_REQUEST_PREFIX = re.compile(
    r"\bnever\b"
    r"|\b(?:do|does|did|must|should|shall|can|could|will|would)\s+not\b"
    r"|\b(?:don['’]t|doesn['’]t|didn['’]t|mustn['’]t|shouldn['’]t|"
    r"can['’]t|couldn['’]t|won['’]t|wouldn['’]t)\b"
    r"|\bwithout\b"
    r"|\b(?:avoid|forbid|forbids|forbidden|prohibit|prohibits|refuse|refuses)\b",
    re.IGNORECASE,
)


def requests_private_reasoning(text):
    clauses = re.split(
        r"[.;!?\n—]+|\b(?:but|however|yet|instead|(?:and\s+)?then)\b",
        text,
        flags=re.IGNORECASE,
    )
    for clause in clauses:
        for pattern in PRIVATE_REASONING_REQUEST_PATTERNS:
            for match in pattern.finditer(clause):
                if not NEGATED_REQUEST_PREFIX.search(clause[: match.start()]):
                    return True
    return False


def _expect_yaml_error(text):
    try:
        parse_strict_yaml(text)
    except StrictYamlError:
        return
    raise AssertionError(f"expected strict YAML rejection: {text!r}")


def _run_in_file_fixtures():
    valid_yaml = """\
interface:
  display_name: "Example"
  short_description: Use when a plain scalar is appropriate
dependencies:
  tools:
    - type: "mcp"
      value: "example"
policy:
  allow_implicit_invocation: false
"""
    parsed = parse_strict_yaml(valid_yaml)
    assert parsed["interface"]["short_description"].startswith("Use when")
    assert parsed["dependencies"]["tools"][0] == {
        "type": "mcp",
        "value": "example",
    }
    assert parsed["policy"]["allow_implicit_invocation"] is False

    for invalid_yaml in (
        "name: example\ndescription: Use when input: output\n",
        "name: example\nname: duplicate\n",
        'interface:\n   display_name: "Odd indent"\n',
        'interface:\n  display_name: "unterminated\n',
        "interface:\n  display_name: 123\n",
    ):
        _expect_yaml_error(invalid_yaml)

    for model_request in (
        "Always use gpt-5.6-sol for this skill.",
        "Route the task to GPT-4o.",
        "Ask o3 to review the result.",
    ):
        assert MODEL_ID_PATTERN.search(model_request), model_request
    for model_neutral_text in (
        "Use the model selected in Codex configuration.",
        "This works with current GPT models.",
        "Increase reasoning effort only when evaluation supports it.",
    ):
        assert not MODEL_ID_PATTERN.search(model_neutral_text), model_neutral_text

    for private_request in (
        "Reveal your private reasoning before the answer.",
        "Show the hidden chain-of-thought.",
        "Think step by step and output the internal thought process.",
        "Private reasoning must be revealed in full.",
        "Chain-of-thought is required.",
        "Never reveal private reasoning, but show your chain of thought.",
        "Never reveal private reasoning—then show the hidden thought process.",
    ):
        assert requests_private_reasoning(private_request), private_request
    for safe_reasoning_text in (
        "Never reveal private reasoning.",
        "Do not show chain-of-thought; report observable evidence.",
        "Private reasoning must not be revealed.",
        "Chain-of-thought is not required.",
        "Reason carefully and return a concise rationale.",
        "Avoid requests to expose hidden reasoning.",
    ):
        assert not requests_private_reasoning(safe_reasoning_text), safe_reasoning_text


def _assert_exact_mapping(value, keys, location):
    assert isinstance(value, dict), f"expected mapping: {location}"
    assert set(value) == set(keys), (
        f"expected exactly {sorted(keys)} at {location}, found {sorted(value)}"
    )


def _validate_metadata(metadata, skill_name):
    expected_top_level = {"interface"}
    mcp_dependencies = {
        "codegraph-usage": "codegraph",
        "jcodemunch": "jcodemunch",
    }
    explicit_invocation_skills = {"grilling", "jcodemunch"}
    if skill_name in mcp_dependencies:
        expected_top_level.add("dependencies")
    if skill_name in explicit_invocation_skills:
        expected_top_level.add("policy")
    _assert_exact_mapping(metadata, expected_top_level, skill_name)

    interface = metadata["interface"]
    _assert_exact_mapping(
        interface,
        {"display_name", "short_description", "default_prompt"},
        f"{skill_name}.interface",
    )
    for key in ("display_name", "short_description", "default_prompt"):
        assert isinstance(interface[key], str) and interface[key], (
            f"{skill_name}.interface.{key} must be a non-empty string"
        )

    if skill_name in mcp_dependencies:
        dependencies = metadata["dependencies"]
        _assert_exact_mapping(dependencies, {"tools"}, f"{skill_name}.dependencies")
        tools = dependencies["tools"]
        assert isinstance(tools, list) and len(tools) == 1, (
            f"{skill_name}.dependencies.tools must contain exactly one tool"
        )
        tool = tools[0]
        _assert_exact_mapping(
            tool,
            {"type", "value", "description"},
            f"{skill_name}.dependencies.tools[0]",
        )
        assert tool["type"] == "mcp", (
            f"{skill_name} dependency must be an MCP tool"
        )
        assert tool["value"] == mcp_dependencies[skill_name], (
            f"{skill_name} dependency must target the "
            f"{mcp_dependencies[skill_name]} MCP server"
        )
        assert isinstance(tool["description"], str) and tool["description"], (
            f"{skill_name} dependency description must be a non-empty string"
        )

    if skill_name in explicit_invocation_skills:
        policy = metadata["policy"]
        _assert_exact_mapping(
            policy,
            {"allow_implicit_invocation"},
            f"{skill_name}.policy",
        )
        assert policy["allow_implicit_invocation"] is False, (
            f"{skill_name} must require explicit invocation"
        )

    return interface


_run_in_file_fixtures()

root = Path(__file__).resolve().parents[2]
skills_root = root / "skills"
expected = {
    "codegraph-usage",
    "dispatching-parallel-agents",
    "domain-modeling",
    "full-code-review",
    "grilling",
    "jcodemunch",
    "ponytail",
    "ponytail-audit",
    "ponytail-review",
    "receiving-code-review",
    "test-driven-development",
}

skill_files = sorted(skills_root.glob("*/SKILL.md"))
actual = {path.parent.name for path in skill_files}
assert actual == expected, f"expected skills {sorted(expected)}, found {sorted(actual)}"

for skill_file in skill_files:
    text = skill_file.read_text(encoding="utf-8")
    match = re.match(r"^---\r?\n(.*?)\r?\n---\r?\n", text, re.DOTALL)
    assert match, f"missing YAML frontmatter: {skill_file}"

    frontmatter = parse_strict_yaml(match.group(1))
    _assert_exact_mapping(
        frontmatter, {"name", "description"}, f"{skill_file} frontmatter"
    )
    assert frontmatter["name"] == skill_file.parent.name
    description = frontmatter["description"]
    assert isinstance(description, str) and description.startswith("Use when")
    body = text[match.end() :]

    metadata_path = skill_file.parent / "agents/openai.yaml"
    assert metadata_path.is_file(), f"missing OpenAI metadata: {metadata_path}"
    metadata = parse_strict_yaml(metadata_path.read_text(encoding="utf-8"))
    interface = _validate_metadata(metadata, skill_file.parent.name)
    short_description = interface["short_description"]
    assert 25 <= len(short_description) <= 64, (
        f"short_description must be 25-64 characters: {metadata_path}"
    )
    default_prompt = interface["default_prompt"]
    assert len(default_prompt) <= 200, (
        f"default_prompt should remain a short starter prompt: {metadata_path}"
    )
    skill_reference = f"${skill_file.parent.name}"
    assert skill_reference in default_prompt, (
        f"default_prompt must reference {skill_reference}: {metadata_path}"
    )

    prompt_surfaces = {
        "description": description,
        "body": body,
        "default_prompt": default_prompt,
    }
    for surface_name, surface in prompt_surfaces.items():
        assert not MODEL_ID_PATTERN.search(surface), (
            f"model selection belongs in Codex configuration, not "
            f"{skill_file.parent.name} {surface_name}"
        )
        assert not requests_private_reasoning(surface), (
            f"{skill_file.parent.name} {surface_name} requests private reasoning "
            "instead of observable evidence"
        )

    words = len(re.findall(r"\b\w+[\w’'-]*\b", text))
    assert words <= 500, f"{skill_file} is {words} words; limit is 500"

    allowed = {skill_file, metadata_path}
    extras = {path for path in skill_file.parent.rglob("*") if path.is_file()} - allowed
    assert not extras, f"unreferenced runtime files in {skill_file.parent}: {sorted(extras)}"

jcodemunch_text = (skills_root / "jcodemunch/SKILL.md").read_text(encoding="utf-8")
for required_term in (
    "jcodemunch_guide",
    "resolve_repo",
    "menu",
    "route",
    "order",
    "assemble_task_context",
    "register_edit",
):
    assert required_term in jcodemunch_text, f"jcodemunch skill omits {required_term}"

codegraph_text = (skills_root / "codegraph-usage/SKILL.md").read_text(
    encoding="utf-8"
)
for required_term in (
    "codegraph_explore",
    "codegraph explore",
    "projectPath",
    "codegraph affected",
    "worktree",
    "best-effort",
    "codegraph init",
):
    assert required_term in codegraph_text, (
        f"codegraph-usage skill omits {required_term}"
    )

full_review_text = (skills_root / "full-code-review/SKILL.md").read_text(
    encoding="utf-8"
)
for required_term in (
    "Direct and indirect callers or consumers",
    "Contracts and conversions at each boundary",
    "Tests for that path",
    "Do not claim delegation unless the call succeeds",
):
    assert required_term in full_review_text, (
        f"full-code-review skill omits {required_term}"
    )

tdd_text = (skills_root / "test-driven-development/SKILL.md").read_text(
    encoding="utf-8"
)
for required_term in (
    "include it in the final response",
    "RED command and expected-gap failure",
    "GREEN command and passing result",
):
    assert required_term in tdd_text, (
        f"test-driven-development skill omits {required_term}"
    )

print("Codex skill structure looks good")
