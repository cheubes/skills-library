#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="${1:-}"

if [[ -z "$SKILL_DIR" ]]; then
  echo "Usage: $0 <skill-directory>" >&2
  echo "Example: $0 cover-letter-vpe" >&2
  exit 1
fi

SKILL_DIR="${SKILL_DIR%/}"

if [[ ! -d "$SKILL_DIR" ]]; then
  echo "Error: directory '$SKILL_DIR' not found" >&2
  exit 1
fi

if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
  echo "Error: '$SKILL_DIR/SKILL.md' not found" >&2
  exit 1
fi

SKILL_NAME=$(basename "$SKILL_DIR")
if ! mkdir -p bin; then
  echo "Error: cannot create 'bin/' directory" >&2
  exit 1
fi
OUTPUT="$(pwd)/bin/${SKILL_NAME}.zip"

rm -f "$OUTPUT"
(
  cd "$SKILL_DIR"
  zip -r "$OUTPUT" . >/dev/null
)

echo "Packaged: bin/${SKILL_NAME}.zip"
