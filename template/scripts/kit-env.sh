#!/usr/bin/env bash
# kit-env.sh: finds the kit root and the code repository.
# Part of agent-first-dev-kit. Source it from other scripts; do not run it.
#
# Two layouts (README, "Two layouts"):
#   in-repo     The kit root is the git root. No config file. The default.
#   workspace   The kit root wraps the code repository in a sub-folder.
#               Set by a .agent-kit file at the kit root:
#                 layout=workspace
#                 repo=app
#
# Exports:
#   KIT_ROOT    folder holding AGENTS.md, docs/, scripts/, .claude/
#   REPO_ROOT   folder where git commands run
#   KIT_LAYOUT  in-repo | workspace
#   KIT_REPO    repo sub-folder relative to KIT_ROOT (workspace only, else empty)

kit_trim() {
  local s="$1"
  s="${s#"${s%%[![:space:]]*}"}"
  s="${s%"${s##*[![:space:]]}"}"
  printf '%s' "$s"
}

kit_find_root() {
  local start="${CLAUDE_PROJECT_DIR:-$PWD}" d
  # Pass 1: a folder with .agent-kit wins (workspace layout).
  d="$start"
  while [ "$d" != "/" ] && [ -n "$d" ]; do
    [ -f "$d/.agent-kit" ] && { echo "$d"; return 0; }
    d="$(dirname "$d")"
  done
  # Pass 2: a folder with the kit's entry file and session check (in-repo).
  d="$start"
  while [ "$d" != "/" ] && [ -n "$d" ]; do
    [ -f "$d/AGENTS.md" ] && [ -f "$d/scripts/agent-check.sh" ] && { echo "$d"; return 0; }
    d="$(dirname "$d")"
  done
  # Fallback: git root, then the current folder.
  git rev-parse --show-toplevel 2>/dev/null || pwd
}

KIT_ROOT="$(kit_find_root)"
KIT_LAYOUT="in-repo"
KIT_REPO=""

if [ -f "$KIT_ROOT/.agent-kit" ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    line="${line%%#*}"
    case "$line" in *=*) ;; *) continue ;; esac
    key="$(kit_trim "${line%%=*}")"
    val="$(kit_trim "${line#*=}")"
    case "$key" in
      layout) KIT_LAYOUT="$val" ;;
      repo)   KIT_REPO="${val%/}" ;;
    esac
  done < "$KIT_ROOT/.agent-kit"
fi

if [ "$KIT_LAYOUT" = "workspace" ] && [ -n "$KIT_REPO" ]; then
  REPO_ROOT="$KIT_ROOT/$KIT_REPO"
else
  KIT_LAYOUT="in-repo"
  KIT_REPO=""
  REPO_ROOT="$KIT_ROOT"
fi

export KIT_ROOT REPO_ROOT KIT_LAYOUT KIT_REPO
