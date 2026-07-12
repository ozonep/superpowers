#!/usr/bin/env bash
# Build a deterministic, rootless archive of the current Codex plugin tree.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

OUTPUT=""
FORMAT=""
ALLOW_DIRTY=0
KEEP_STAGE=0

usage() {
  cat <<'EOF'
Usage: scripts/package-codex-plugin.sh [options]

Options:
  --output PATH    Archive path. Defaults to ../_tmp/sup-codex-packaging/.
  --format FORMAT  zip or tar.gz. Inferred from --output when possible.
  --allow-dirty    Package the current working tree even when it is dirty.
  --keep-stage     Keep and print the temporary staging directory.
  -h, --help       Show this help.

The archive contains only .codex-plugin/, assets/, skills/, README.md,
LICENSE, and CODE_OF_CONDUCT.md. Each skill must track agents/openai.yaml.
EOF
}

die() { echo "ERROR: $*" >&2; exit 1; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output) [[ $# -ge 2 ]] || die "--output requires a path"; OUTPUT="$2"; shift 2 ;;
    --format)
      [[ $# -ge 2 ]] || die "--format requires a value"
      [[ "$2" == "zip" || "$2" == "tar.gz" || "$2" == "tgz" ]] || die "--format must be zip or tar.gz"
      FORMAT="$2"; [[ "$FORMAT" == "tgz" ]] && FORMAT="tar.gz"; shift 2
      ;;
    --allow-dirty) ALLOW_DIRTY=1; shift ;;
    --keep-stage) KEEP_STAGE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "unknown argument: $1" ;;
  esac
done

infer_format() {
  case "$1" in
    *.tar.gz|*.tgz) echo tar.gz ;;
    *.zip) echo zip ;;
    *) return 1 ;;
  esac
}

if [[ -z "$FORMAT" ]]; then
  FORMAT="$(infer_format "$OUTPUT" || true)"
  [[ -n "$FORMAT" ]] || FORMAT="zip"
elif output_format="$(infer_format "$OUTPUT" || true)" && [[ "$output_format" != "$FORMAT" ]]; then
  die "--output extension does not match --format $FORMAT: $OUTPUT"
fi

for command in git python3 tar gzip shasum; do
  command -v "$command" >/dev/null || die "$command not found in PATH"
done
if [[ "$FORMAT" == "zip" ]]; then
  command -v zip >/dev/null || die "zip not found in PATH"
  command -v unzip >/dev/null || die "unzip not found in PATH"
fi

[[ -d "$REPO_ROOT/.git" ]] || die "repo root is not a git checkout: $REPO_ROOT"

if [[ "$ALLOW_DIRTY" -ne 1 ]]; then
  dirty_status="$(git -C "$REPO_ROOT" status --porcelain --untracked-files=all)"
  if [[ -n "$dirty_status" ]]; then
    echo "Working tree has uncommitted changes:" >&2
    printf '%s\n' "$dirty_status" | sed 's/^/  /' >&2
    die "commit or stash changes first, or pass --allow-dirty"
  fi
fi

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/superpowers-codex-package.XXXXXX")"
STAGE="$WORK_DIR/payload"
ARCHIVE_LIST="$WORK_DIR/archive-list"

cleanup() {
  if [[ "$KEEP_STAGE" -eq 1 ]]; then
    echo "Keeping staging directory: $WORK_DIR" >&2
  else
    rm -rf "$WORK_DIR"
  fi
}
trap cleanup EXIT
mkdir -p "$STAGE"

skill_paths=()
while IFS= read -r skill_file; do
  skill_paths+=("skills/$(basename "$(dirname "$skill_file")")")
done < <(find "$REPO_ROOT/skills" -mindepth 2 -maxdepth 2 -name SKILL.md -type f -print | sort)
[[ "${#skill_paths[@]}" -gt 0 ]] || die "no skills found"

(
  cd "$REPO_ROOT"
  tar --exclude='.DS_Store' -cf - \
    .codex-plugin CODE_OF_CONDUCT.md LICENSE README.md assets "${skill_paths[@]}"
) | tar -xf - -C "$STAGE"

VERSION="$(python3 - "$STAGE/.codex-plugin/plugin.json" <<'PY'
import json
import sys

print(json.load(open(sys.argv[1], encoding="utf-8")).get("version", ""))
PY
)"
[[ -n "$VERSION" ]] || die "could not read version from .codex-plugin/plugin.json"

missing_metadata=0
skill_count=0
while IFS= read -r skill_dir; do
  skill_count=$((skill_count + 1))
  if [[ ! -f "$skill_dir/SKILL.md" || ! -f "$skill_dir/agents/openai.yaml" ]]; then
    echo "Missing SKILL.md or agents/openai.yaml: ${skill_dir##*/}" >&2
    missing_metadata=1
  fi
done < <(find "$STAGE/skills" -mindepth 1 -maxdepth 1 -type d -print | sort)
[[ "$missing_metadata" -eq 0 ]] || die "every skill must track OpenAI metadata"

if [[ -z "$OUTPUT" ]]; then
  suffix="zip"; [[ "$FORMAT" == "tar.gz" ]] && suffix="tar.gz"
  OUTPUT="$REPO_ROOT/../_tmp/sup-codex-packaging/superpowers-$VERSION.$suffix"
fi
mkdir -p "$(dirname "$OUTPUT")"
OUTPUT="$(cd "$(dirname "$OUTPUT")" && pwd)/$(basename "$OUTPUT")"

(
  cd "$STAGE"
  {
    find . -mindepth 1 -type d | sed 's#^\./##' | LC_ALL=C sort
    find . -mindepth 1 -type f | sed 's#^\./##' | LC_ALL=C sort
  } >"$ARCHIVE_LIST"
)

case "$FORMAT" in
  zip)
    TZ=UTC find "$STAGE" -exec touch -t 198001010000 {} +
    (cd "$STAGE" && rm -f "$OUTPUT" && TZ=UTC COPYFILE_DISABLE=1 zip -X -q - -@ <"$ARCHIVE_LIST" >"$OUTPUT")
    archive_paths="$(unzip -Z1 "$OUTPUT" | sed 's#/$##')"
    ;;
  tar.gz)
    TZ=UTC find "$STAGE" -exec touch -t 197001010000 {} +
    (cd "$STAGE" && rm -f "$OUTPUT" && COPYFILE_DISABLE=1 tar -cf - --no-recursion --format ustar --uid 0 --gid 0 --uname '' --gname '' -T "$ARCHIVE_LIST" | gzip -9n >"$OUTPUT")
    archive_paths="$(tar -tzf "$OUTPUT" | sed 's#/$##')"
    ;;
esac

unexpected_paths="$(printf '%s\n' "$archive_paths" | grep -E '(^superpowers/|(^|/)\.DS_Store$|^\.agents/|^hooks/|package\.json$|^\.git|^scripts/|^tests/|^docs/|^evals/|^\.claude|^\.cursor|^\.kimi|^\.opencode|^\.pi|^AGENTS\.md$|^CLAUDE\.md$|^GEMINI\.md$|^RELEASE-NOTES\.md$)' || true)"
if [[ -n "$unexpected_paths" ]]; then
  printf '%s\n' "$unexpected_paths" | sed 's/^/  /' >&2
  die "archive contains source-only paths"
fi

echo "Archive: $OUTPUT"
echo "Format:  $FORMAT"
echo "Version: $VERSION"
echo "Entries: $(printf '%s\n' "$archive_paths" | wc -l | tr -d ' ')"
echo "Skills:  $skill_count"
echo "SHA-256: $(shasum -a 256 "$OUTPUT" | awk '{print $1}')"
