#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPT_UNDER_TEST="$REPO_ROOT/scripts/package-codex-plugin.sh"

FAILURES=0
TEST_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_ROOT"' EXIT

pass() { echo "  [PASS] $1"; }
fail() { echo "  [FAIL] $1"; FAILURES=$((FAILURES + 1)); }

assert_equals() {
  local actual="$1" expected="$2" description="$3"
  if [[ "$actual" == "$expected" ]]; then
    pass "$description"
  else
    fail "$description"
    echo "    expected: $expected"
    echo "    actual:   $actual"
  fi
}

assert_contains() {
  local haystack="$1" needle="$2" description="$3"
  if printf '%s' "$haystack" | grep -Fq -- "$needle"; then
    pass "$description"
  else
    fail "$description"
    echo "    expected to find: $needle"
  fi
}

assert_not_matches() {
  local haystack="$1" pattern="$2" description="$3"
  if printf '%s' "$haystack" | grep -Eq -- "$pattern"; then
    fail "$description"
    echo "    did not expect to match: $pattern"
  else
    pass "$description"
  fi
}

list_archive() {
  case "$1" in
    *.tar.gz|*.tgz) tar -tzf "$1" ;;
    *) unzip -Z1 "$1" ;;
  esac
}

echo "Codex package archive tests"

archive="$TEST_ROOT/superpowers.zip"
tar_archive="$TEST_ROOT/superpowers.tar.gz"

if output="$($SCRIPT_UNDER_TEST --allow-dirty --output "$archive" 2>&1)"; then
  pass "packages the current working tree without an external metadata source"
else
  fail "packages the current working tree without an external metadata source"
  printf '%s\n' "$output" | sed 's/^/      /'
fi

archive_paths="$(list_archive "$archive" | sed 's#/$##' | LC_ALL=C sort)"
unexpected_pattern='(^superpowers/|^\.agents/|^hooks/|package\.json$|^\.git|^scripts/|^tests/|^docs/|^evals/|^\.claude|^\.cursor|^\.kimi|^\.opencode|^\.pi|^AGENTS\.md$|^CLAUDE\.md$|^GEMINI\.md$|^RELEASE-NOTES\.md$)'

assert_not_matches "$archive_paths" "$unexpected_pattern" "archive contains only Codex runtime files"
assert_contains "$archive_paths" ".codex-plugin/plugin.json" "archive includes the Codex manifest"
assert_contains "$archive_paths" "skills/test-driven-development/SKILL.md" "archive includes runtime skills"
assert_contains "$archive_paths" "skills/test-driven-development/agents/openai.yaml" "archive includes tracked OpenAI skill metadata"
assert_contains "$archive_paths" "skills/domain-modeling/SKILL.md" "archive includes the retained domain-modeling skill"
assert_contains "$archive_paths" "skills/domain-modeling/agents/openai.yaml" "archive includes domain-modeling OpenAI metadata"
assert_contains "$archive_paths" "skills/grilling/SKILL.md" "archive includes the retained grilling skill"
assert_contains "$archive_paths" "skills/grilling/agents/openai.yaml" "archive includes grilling OpenAI metadata"
assert_contains "$archive_paths" "skills/full-code-review/SKILL.md" "archive includes the retained full-code-review skill"
assert_contains "$archive_paths" "skills/full-code-review/agents/openai.yaml" "archive includes full-code-review OpenAI metadata"
assert_contains "$archive_paths" "skills/jcodemunch/SKILL.md" "archive includes the jCodeMunch skill"
assert_contains "$archive_paths" "skills/jcodemunch/agents/openai.yaml" "archive includes jCodeMunch OpenAI metadata"
assert_contains "$archive_paths" "skills/ponytail-review/SKILL.md" "archive includes the focused ponytail-review skill"
assert_contains "$archive_paths" "skills/ponytail-review/agents/openai.yaml" "archive includes ponytail-review OpenAI metadata"
assert_contains "$archive_paths" "skills/ponytail-audit/SKILL.md" "archive includes the repository-wide ponytail-audit skill"
assert_contains "$archive_paths" "skills/ponytail-audit/agents/openai.yaml" "archive includes ponytail-audit OpenAI metadata"
assert_contains "$archive_paths" "skills/typescript-best-practices/SKILL.md" "archive includes the TypeScript skill"
assert_contains "$archive_paths" "skills/typescript-best-practices/agents/openai.yaml" "archive includes TypeScript OpenAI metadata"
assert_contains "$archive_paths" "skills/typescript-best-practices/references/patterns.md" "archive includes linked TypeScript patterns"
assert_contains "$archive_paths" "skills/unslop/SKILL.md" "archive includes the prose-revision skill"
assert_contains "$archive_paths" "skills/unslop/agents/openai.yaml" "archive includes prose-revision OpenAI metadata"
assert_contains "$archive_paths" "assets/app-icon.png" "archive includes plugin assets"

skill_count="$(printf '%s\n' "$archive_paths" | sed -n 's#^skills/\([^/]*\)/SKILL\.md$#\1#p' | wc -l | tr -d ' ')"
metadata_count="$(printf '%s\n' "$archive_paths" | sed -n 's#^skills/\([^/]*\)/agents/openai\.yaml$#\1#p' | wc -l | tr -d ' ')"
assert_equals "$metadata_count" "$skill_count" "every packaged skill has OpenAI metadata"
assert_equals "$skill_count" "12" "archive contains exactly the twelve retained skills"

zip_times="$(python3 - "$archive" <<'PY'
import sys
import zipfile

with zipfile.ZipFile(sys.argv[1]) as archive:
    print("\n".join(sorted({str(info.date_time) for info in archive.infolist()})))
PY
)"
assert_equals "$zip_times" "(1980, 1, 1, 0, 0, 0)" "zip timestamps are deterministic"

if tar_output="$($SCRIPT_UNDER_TEST --allow-dirty --format tar.gz --output "$tar_archive" 2>&1)"; then
  pass "writes an explicit tar.gz archive"
else
  fail "writes an explicit tar.gz archive"
  printf '%s\n' "$tar_output" | sed 's/^/      /'
fi

tar_paths="$(list_archive "$tar_archive" | sed 's#/$##' | LC_ALL=C sort)"
assert_equals "$tar_paths" "$archive_paths" "zip and tar.gz contain the same paths"

dirty_repo="$TEST_ROOT/dirty-repo"
mkdir -p "$dirty_repo"
(
  cd "$REPO_ROOT"
  tar -cf - .codex-plugin CODE_OF_CONDUCT.md LICENSE README.md assets skills scripts
) | tar -xf - -C "$dirty_repo"
git -C "$dirty_repo" init -q
git -C "$dirty_repo" add .
git -C "$dirty_repo" -c user.name=Codex -c user.email=codex@example.invalid commit -qm baseline
printf '\nworking-tree marker\n' >>"$dirty_repo/README.md"

set +e
dirty_output="$(cd "$dirty_repo" && scripts/package-codex-plugin.sh --output "$TEST_ROOT/rejected.zip" 2>&1)"
dirty_status=$?
set -e
if [[ "$dirty_status" -ne 0 ]]; then
  pass "rejects a dirty working tree by default"
else
  fail "rejects a dirty working tree by default"
fi
assert_contains "$dirty_output" "Working tree has uncommitted changes:" "dirty rejection explains the blocker"

if dirty_allowed_output="$(cd "$dirty_repo" && scripts/package-codex-plugin.sh --allow-dirty --output "$TEST_ROOT/dirty.zip" 2>&1)"; then
  pass "allows packaging an intentionally dirty development tree"
else
  fail "allows packaging an intentionally dirty development tree"
  printf '%s\n' "$dirty_allowed_output" | sed 's/^/      /'
fi

dirty_readme="$(unzip -p "$TEST_ROOT/dirty.zip" README.md)"
assert_contains "$dirty_readme" "working-tree marker" "dirty packaging uses current files instead of stale HEAD"

if [[ "$FAILURES" -eq 0 ]]; then
  echo "All Codex package archive tests passed"
else
  echo "$FAILURES Codex package archive test(s) failed"
  exit 1
fi
