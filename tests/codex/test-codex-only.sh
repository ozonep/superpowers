#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

forbidden=(
  .claude-plugin
  .cursor-plugin
  .kimi-plugin
  .opencode
  .pi
  hooks
  CLAUDE.md
  GEMINI.md
  gemini-extension.json
  package.json
  scripts/bump-version.sh
  scripts/lint-shell.sh
  scripts/sync-to-codex-plugin.sh
  tests/antigravity
  tests/brainstorm-server
  tests/claude-code
  tests/codex-plugin-sync
  tests/explicit-skill-requests
  tests/hooks
  tests/kimi
  tests/opencode
  tests/pi
  tests/shell-lint
)

failures=0

if [[ ! -f "$REPO_ROOT/AGENTS.md" || -L "$REPO_ROOT/AGENTS.md" ]]; then
  echo "[FAIL] AGENTS.md must be a readable Codex-native repository guide"
  failures=$((failures + 1))
fi

for path in "${forbidden[@]}"; do
  if [[ -e "$REPO_ROOT/$path" ]]; then
    echo "[FAIL] non-Codex path remains: $path"
    failures=$((failures + 1))
  fi
done

if rg -n -i 'Claude Code|Gemini|OpenCode|Kimi Code|Antigravity|Cursor Agent|Factory Droid|Copilot CLI|\bPi package\b' \
  "$REPO_ROOT/README.md" "$REPO_ROOT/.codex-plugin/plugin.json" "$REPO_ROOT/skills"; then
  echo "[FAIL] runtime documentation still names another harness"
  failures=$((failures + 1))
fi

if [[ "$failures" -ne 0 ]]; then
  echo "$failures Codex-only structure check(s) failed"
  exit 1
fi

echo "Codex-only structure looks good"
