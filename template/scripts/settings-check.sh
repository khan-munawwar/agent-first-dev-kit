#!/usr/bin/env bash
# settings-check.sh: reports the state of a project settings file.
# Part of agent-first-dev-kit. Read-only: it prints, it never changes anything.
#
# Every kit guide docs/guides/<TOPIC>.md has a project partner docs/<TOPIC>.md
# that fills the guide's slots (docs/guides/DOCS.md, "Guide pairs"). Two markers
# matter in the partner file:
#   <!-- SETUP(P1): question -->   a required slot with no default. Not set yet.
#                                  Ask the human before the task that needs it.
#   <!-- default -->               an optional slot still on the kit default.
#                                  Use it, say so once per session, invite the
#                                  human to set their own value.
#
# Usage: bash scripts/settings-check.sh TOPIC [TOPIC ...]      e.g. GIT
#   exit 0  every required (P1) slot is set
#   exit 1  at least one required (P1) slot is still open (listed)
#   exit 2  usage error or settings file missing

set -u
. "$(cd "$(dirname "$0")" && pwd)/kit-env.sh"

[ $# -ge 1 ] || { echo "usage: bash scripts/settings-check.sh TOPIC [TOPIC ...]" >&2; exit 2; }

status=0
for topic in "$@"; do
  file="docs/${topic}.md"
  path="$KIT_ROOT/$file"
  echo "== settings: $file"
  if [ ! -f "$path" ]; then
    echo "  missing. Copy it from the kit template (scripts/adopt.sh) or ask the human. Until then, the guide's defaults apply."
    status=2
    continue
  fi

  req=$(grep -nE 'SETUP\(P1\):' "$path" | sed -E 's/<!--[[:space:]]*SETUP\((P1)\):[[:space:]]*/\1  /; s/[[:space:]]*-->.*$//' || true)
  later=$(grep -cE 'SETUP\(P[23]\):' "$path" || true)
  defs=$(grep -nE '<!--[[:space:]]*default[[:space:]]*-->' "$path" | sed -E 's/<!--[[:space:]]*default[[:space:]]*-->//; s/[[:space:]]+$//' || true)

  if [ -n "$req" ]; then
    n=$(printf '%s\n' "$req" | wc -l | tr -d ' ')
    echo "  required missing: $n  (ask the human before the task that needs them; do not guess)"
    printf '%s\n' "$req" | sed -E "s|^([0-9]+):|  $file:\1  |"
    [ "$status" -eq 0 ] && status=1
  else
    echo "  required missing: 0"
  fi
  [ "${later:-0}" -gt 0 ] && echo "  needed later (P2/P3): $later"

  if [ -n "$defs" ]; then
    n=$(printf '%s\n' "$defs" | wc -l | tr -d ' ')
    echo "  defaults in use: $n  (kit defaults; say so once, invite the human to set their own)"
    printf '%s\n' "$defs" | sed -E "s|^([0-9]+):[[:space:]]*|  $file:\1  |"
  else
    echo "  defaults in use: 0"
  fi
done
exit "$status"
