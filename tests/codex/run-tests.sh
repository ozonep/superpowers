#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

bash "$SCRIPT_DIR/test-codex-only.sh"
python3 "$SCRIPT_DIR/test-skills.py"
bash "$SCRIPT_DIR/test-marketplace-manifest.sh"
bash "$SCRIPT_DIR/test-package-codex-plugin.sh"
