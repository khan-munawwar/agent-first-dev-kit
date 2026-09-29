#!/usr/bin/env bash
# agent-check.sh: session-start check for AI coding agents and humans.
# Part of agent-first-dev-kit. Read-only: it prints, it never changes anything.
#
# Reports: kit version, project phase, missing files, open SETUP items,
# STATUS.md age, active changes, open issues, and git state.
# Usage: bash scripts/agent-check.sh [--all]   (--all lists every SETUP item)

set -u
SHOW_ALL=0
[ "${1:-}" = "--all" ] && SHOW_ALL=1

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

echo "== agent-check: $(basename "$ROOT")"

# ---- Kit version -----------------------------------------------------------
kit_ver=$(grep -m1 -oE 'agent-first-dev-kit v[0-9]+\.[0-9]+\.[0-9]+' AGENTS.md 2>/dev/null | sed 's/.* v//')
echo "kit version: ${kit_ver:-unknown}"
if [ -n "${AGENT_KIT_PATH:-}" ] && [ -f "$AGENT_KIT_PATH/VERSION" ]; then
  latest=$(tr -d '[:space:]' < "$AGENT_KIT_PATH/VERSION")
  if [ -n "$latest" ] && [ "$latest" != "${kit_ver:-}" ]; then
    echo "  kit update available: ${kit_ver:-unknown} -> $latest (read $AGENT_KIT_PATH/CHANGELOG.md, then follow docs/guides/DOCS.md 'Syncing with the kit')"
  fi
fi

# ---- Phase -----------------------------------------------------------------
phase_line=$(grep -m1 -E '^Phase:' AGENTS.md 2>/dev/null || true)
case "$phase_line" in
  *SETUP*|"") phase="NOT SET" ;;
  *) phase=$(echo "$phase_line" | sed -E 's/^Phase:[[:space:]]*//; s/[[:space:]]*$//') ;;
esac
echo "phase: $phase"

# ---- Required files --------------------------------------------------------
required="AGENTS.md REVIEW.md docs/README.md docs/SETUP.md docs/PROJECT.md docs/STATUS.md docs/ISSUES.md docs/ARCHITECTURE.md docs/CONVENTIONS.md docs/ENVIRONMENTS.md docs/UI.md docs/RESOURCES.md"
missing=""
for f in $required; do
  [ -f "$f" ] || missing="$missing $f"
done
if [ -n "$missing" ]; then
  echo "missing files:$missing"
fi

# ---- SETUP items -----------------------------------------------------------
# Placeholders look like: <!-- SETUP(P1): question -->
# P1 = needed before any code, P2 = before the first feature ships,
# P3 = before production. Guides and templates never carry SETUP markers.
setup_list=$(grep -rnoE 'SETUP\(P[123]\):[^>]*' \
  --include='*.md' AGENTS.md REVIEW.md docs 2>/dev/null \
  | grep -vE '^docs/(guides|changes/_template|adr/0000|meetings/_template|incidents/_template)' \
  | sed -E 's/-->.*$//; s/[[:space:]]*-+$//; s/[[:space:]]+$//' || true)
if [ -n "$setup_list" ]; then
  total=$(printf '%s\n' "$setup_list" | wc -l | tr -d ' ')
  p1=$(printf '%s\n' "$setup_list" | grep -c 'SETUP(P1)' || true)
  p2=$(printf '%s\n' "$setup_list" | grep -c 'SETUP(P2)' || true)
  p3=$(printf '%s\n' "$setup_list" | grep -c 'SETUP(P3)' || true)
  echo "setup items open: $total (P1: $p1, P2: $p2, P3: $p3). Follow docs/SETUP.md."
  limit=12
  [ "$SHOW_ALL" -eq 1 ] && limit=100000
  for pr in P1 P2 P3; do
    printf '%s\n' "$setup_list" | grep "SETUP($pr)" || true
  done | head -n "$limit" | sed -E 's/^([^:]+):([0-9]+):SETUP\((P[123])\):[[:space:]]*/  \3 \1:\2  /'
  if [ "$SHOW_ALL" -eq 0 ] && [ "$total" -gt "$limit" ]; then
    echo "  ... $((total - limit)) more (run with --all)"
  fi
else
  echo "setup items open: 0"
fi

# ---- STATUS.md age ---------------------------------------------------------
if [ -f docs/STATUS.md ]; then
  last=$(grep -m1 -oE 'Last updated:[[:space:]]*[0-9]{4}-[0-9]{2}-[0-9]{2}' docs/STATUS.md | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' || true)
  if [ -n "$last" ]; then
    then_s=$(date -j -f '%Y-%m-%d' "$last" +%s 2>/dev/null || date -d "$last" +%s 2>/dev/null || echo "")
    if [ -n "$then_s" ]; then
      days=$(( ( $(date +%s) - then_s ) / 86400 ))
      echo "STATUS.md last updated: $last ($days days ago)"
    else
      echo "STATUS.md last updated: $last"
    fi
  else
    echo "STATUS.md last updated: never"
  fi
fi

# ---- Active changes --------------------------------------------------------
if [ -d docs/changes ]; then
  active=""
  for d in docs/changes/*/; do
    case "$d" in *_template*) continue ;; esac
    [ -f "$d/intent.md" ] || continue
    st=$(grep -m1 -E '^status:' "$d/intent.md" | sed -E 's/^status:[[:space:]]*//')
    case "$st" in
      done|dropped|superseded) ;;
      *) active="$active $(basename "$d")(${st:-unknown})" ;;
    esac
  done
  echo "active changes:${active:- none}"
fi

# ---- Open issues -----------------------------------------------------------
if [ -f docs/ISSUES.md ]; then
  open_issues=$(awk '/^## Open/{f=1;next} /^## /{f=0} f && /^- ISS-/' docs/ISSUES.md | wc -l | tr -d ' ')
  echo "open issues: $open_issues"
fi

# ---- Git state -------------------------------------------------------------
if git rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git branch --show-current 2>/dev/null)
  changed=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  staged=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
  echo "git: branch ${branch:-detached}, $changed changed files ($staged staged)"
  echo "git identity: $(git config user.name 2>/dev/null) <$(git config user.email 2>/dev/null)>"
  case "$branch" in
    main|master|trunk|production)
      [ "$changed" -gt 0 ] && echo "  warning: uncommitted changes on the default branch. Create a branch before committing."
      ;;
  esac
else
  echo "git: not a repository"
fi

exit 0
