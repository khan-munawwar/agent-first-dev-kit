#!/usr/bin/env bash
# adopt.sh: copy the kit template into a project without overwriting anything.
# Part of agent-first-dev-kit.
#
# Usage: bash scripts/adopt.sh /path/to/project [--dry-run]
#
# - Files that do not exist in the project are copied.
# - Files that already exist are skipped and listed. Nothing is overwritten.
# - Optional files (optional/) are not copied. docs/SETUP.md says when to add them.

set -eu

KIT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE="$KIT/template"
TARGET="${1:-}"
DRY=0
[ "${2:-}" = "--dry-run" ] && DRY=1

if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
  echo "usage: bash scripts/adopt.sh /path/to/project [--dry-run]" >&2
  exit 2
fi
TARGET="$(cd "$TARGET" && pwd)"

copied=0
skipped=0
skipped_list=""

while IFS= read -r -d '' src; do
  rel="${src#"$TEMPLATE"/}"
  dest="$TARGET/$rel"
  if [ -e "$dest" ]; then
    skipped=$((skipped + 1))
    skipped_list="$skipped_list\n  $rel"
    continue
  fi
  if [ "$DRY" -eq 1 ]; then
    echo "would copy: $rel"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    case "$rel" in *.sh) chmod +x "$dest" ;; esac
  fi
  copied=$((copied + 1))
done < <(find "$TEMPLATE" -type f -print0)

verb="copied"
[ "$DRY" -eq 1 ] && verb="would copy"
echo "agent-first-dev-kit: $verb $copied files into $TARGET"
if [ "$skipped" -gt 0 ]; then
  echo "skipped $skipped existing files (merge these by hand or with the agent):"
  printf '%b\n' "$skipped_list"
fi

if [ "$DRY" -eq 0 ]; then
  echo
  echo "Next:"
  echo "  1. Add to the project's .gitignore:  .claude/settings.local.json"
  echo "  2. Start an agent session in the project. It runs scripts/agent-check.sh"
  echo "     and walks you through docs/SETUP.md."
  echo "  3. Optional: export AGENT_KIT_PATH=$KIT  so agent-check.sh can report kit updates."
fi
