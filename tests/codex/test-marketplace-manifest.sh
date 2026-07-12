#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

python3 - "$REPO_ROOT" <<'PY'
import json
import sys
from pathlib import Path

root = Path(sys.argv[1])
marketplace = json.loads((root / ".agents/plugins/marketplace.json").read_text())
manifest = json.loads((root / ".codex-plugin/plugin.json").read_text())

assert marketplace["name"] == "superpowers-dev"
assert marketplace["interface"]["displayName"] == "Superpowers for Codex"

plugins = [entry for entry in marketplace["plugins"] if entry.get("name") == "superpowers"]
assert len(plugins) == 1
plugin = plugins[0]
assert plugin["source"] == {"source": "local", "path": "./"}
assert plugin["policy"] == {"installation": "AVAILABLE", "authentication": "ON_INSTALL"}
assert plugin["category"] == "Developer Tools"

assert manifest["name"] == plugin["name"]
assert manifest["skills"] == "./skills/"
assert len(manifest["interface"]["defaultPrompt"]) <= 3, "Codex supports at most three starter prompts"
assert "hooks" not in manifest
assert not any((root / "hooks").glob("*")), "Codex-only plugin must not ship foreign harness hooks"

print("Codex marketplace and manifest look good")
PY
