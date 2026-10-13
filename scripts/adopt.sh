#!/usr/bin/env bash
# adopt.sh: copy the kit template into a project without overwriting anything.
# Part of agent-first-dev-kit.
#
# Usage: bash scripts/adopt.sh /path/to/project [--repo <subfolder>] [--dry-run]
#
# - Files that do not exist in the project are copied.
# - Files that already exist are skipped and listed. Nothing is overwritten.
# - Optional files (optional/) are not copied. docs/SETUP.md says when to add them.
# - --repo <subfolder> selects the workspace layout: the kit lives in
#   /path/to/project and the code repository in /path/to/project/<subfolder>.
#   It writes a .agent-kit file. Without --repo the layout is in-repo: the kit
#   lives at the git root of the code repository (README, "Two layouts").

set -eu

KIT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE="$KIT/template"
TARGET=""
REPO=""
DRY=0

usage() {
  echo "usage: bash scripts/adopt.sh /path/to/project [--repo <subfolder>] [--dry-run]" >&2
  exit 2
}

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY=1 ;;
    --repo)
      [ $# -ge 2 ] || usage
      REPO="${2%/}"; shift ;;
    --repo=*) REPO="${1#--repo=}"; REPO="${REPO%/}" ;;
    -*) usage ;;
    *) [ -z "$TARGET" ] || usage; TARGET="$1" ;;
  esac
  shift
done

if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
  usage
fi
TARGET="$(cd "$TARGET" && pwd)"
case "$REPO" in
  */*|.|..) echo "adopt.sh: --repo must be a single sub-folder name, for example: app" >&2; exit 2 ;;
esac

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

# Workspace layout: record the repo sub-folder.
if [ -n "$REPO" ]; then
  if [ -e "$TARGET/.agent-kit" ]; then
    skipped=$((skipped + 1))
    skipped_list="$skipped_list\n  .agent-kit"
  elif [ "$DRY" -eq 1 ]; then
    echo "would write: .agent-kit (layout=workspace, repo=$REPO)"
    copied=$((copied + 1))
  else
    printf 'layout=workspace\nrepo=%s\n' "$REPO" > "$TARGET/.agent-kit"
    copied=$((copied + 1))
  fi
fi

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
  if [ -n "$REPO" ]; then
    echo "  layout: workspace. Kit in $TARGET, code repository in $TARGET/$REPO/"
    echo "  1. Clone or move the code repository into $TARGET/$REPO/"
    echo "  2. If $TARGET is itself a git repository, add to its .gitignore:  $REPO/"
    echo "     and  .claude/settings.local.json"
    echo "  3. Start agent sessions in $TARGET (not in $REPO/). The session runs"
    echo "     scripts/agent-check.sh and walks you through docs/SETUP.md."
    echo "  4. Optional: export AGENT_KIT_PATH=$KIT  so agent-check.sh can report kit updates."
  else
    echo "  layout: in-repo. Kit and code share the git root $TARGET"
    echo "  1. Add to the project's .gitignore:  .claude/settings.local.json"
    echo "  2. Start an agent session in the project. It runs scripts/agent-check.sh"
    echo "     and walks you through docs/SETUP.md."
    echo "  3. Optional: export AGENT_KIT_PATH=$KIT  so agent-check.sh can report kit updates."
  fi
fi
