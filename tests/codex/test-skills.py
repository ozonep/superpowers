#!/usr/bin/env python3
from pathlib import Path
import re

root = Path(__file__).resolve().parents[2]
skills_root = root / "skills"
expected = {
    "caveman",
    "dispatching-parallel-agents",
    "domain-modeling",
    "full-code-review",
    "grilling",
    "ponytail",
    "receiving-code-review",
    "test-driven-development",
}

skill_files = sorted(skills_root.glob("*/SKILL.md"))
actual = {path.parent.name for path in skill_files}
assert actual == expected, f"expected skills {sorted(expected)}, found {sorted(actual)}"

for skill_file in skill_files:
    text = skill_file.read_text(encoding="utf-8")
    match = re.match(r"^---\n(.*?)\n---\n", text, re.DOTALL)
    assert match, f"missing YAML frontmatter: {skill_file}"

    frontmatter = match.group(1)
    name_match = re.search(r"^name:\s*(.+)$", frontmatter, re.MULTILINE)
    description_match = re.search(r"^description:\s*(.+)$", frontmatter, re.MULTILINE)
    assert name_match and description_match, f"missing name/description: {skill_file}"
    assert name_match.group(1).strip('"\'') == skill_file.parent.name
    assert description_match.group(1).strip('"\'').startswith("Use when")

    words = len(re.findall(r"\b\w+[\w’'-]*\b", text))
    assert words <= 500, f"{skill_file} is {words} words; limit is 500"

    metadata = skill_file.parent / "agents/openai.yaml"
    assert metadata.is_file(), f"missing OpenAI metadata: {metadata}"
    metadata_text = metadata.read_text(encoding="utf-8")
    assert "display_name:" in metadata_text and "short_description:" in metadata_text

    allowed = {skill_file, metadata}
    extras = {path for path in skill_file.parent.rglob("*") if path.is_file()} - allowed
    assert not extras, f"unreferenced runtime files in {skill_file.parent}: {sorted(extras)}"

print("Codex skill structure looks good")
