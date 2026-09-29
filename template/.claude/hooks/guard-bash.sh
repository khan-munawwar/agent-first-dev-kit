#!/usr/bin/env bash
# guard-bash.sh: Claude Code PreToolUse hook for the Bash tool.
# Part of agent-first-dev-kit. Turns the costliest rules into hard blocks.
#
# Exit 2 blocks the command and shows the message to the agent.
# Rules enforced:
#   1. No --no-verify (skipping git hooks).
#   2. No force push.
#   3. No push to the default branch (main, master, trunk, production).
#   4. No "git commit -a" or "git commit <paths>": stage explicitly first.
#   5. No commit unless the staged diff passed the pre-commit review
#      (scripts/review-gate.sh check).
#   6. No command that mentions a production host listed in
#      .claude/hooks/prod-hosts.txt (one pattern per line, # for comments).
#
# Humans are not affected: this runs only for the agent's Bash tool.

set -u
input=$(cat)

cmd=""
if command -v jq >/dev/null 2>&1; then
  cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)
elif command -v python3 >/dev/null 2>&1; then
  cmd=$(printf '%s' "$input" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null)
else
  cmd="$input"
fi
[ -z "$cmd" ] && exit 0

ROOT="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"

block() {
  echo "BLOCKED by .claude/hooks/guard-bash.sh: $1" >&2
  exit 2
}

# 1. Skipping git hooks
if printf '%s' "$cmd" | grep -qE -- '--no-verify'; then
  block "--no-verify skips the project's checks. Fix the failing check instead, or ask the human."
fi

# 2 and 3. Pushes
if printf '%s' "$cmd" | grep -qE '(^|[;&|[:space:]])git[[:space:]]+push'; then
  if printf '%s' "$cmd" | grep -qE -- '(--force|--force-with-lease|[[:space:]]-f([[:space:]]|$))'; then
    block "force push is not allowed for the agent. Ask the human."
  fi
  if printf '%s' "$cmd" | grep -qE 'git[[:space:]]+push.*[[:space:]:](main|master|trunk|production)([[:space:]]|$)'; then
    block "pushing to the default branch is a human step. Push a feature branch and open a pull request."
  fi
  current=$(git -C "$ROOT" branch --show-current 2>/dev/null)
  case "$current" in
    main|master|trunk|production)
      if ! printf '%s' "$cmd" | grep -qE 'git[[:space:]]+push[[:space:]]+[^[:space:]-]+[[:space:]]+[^[:space:]]+'; then
        block "you are on '$current'. Pushing it is a human step. Create a feature branch first."
      fi
      ;;
  esac
fi

# 4 and 5. Commits
if printf '%s' "$cmd" | grep -qE '(^|[;&|[:space:]])git[[:space:]]+commit'; then
  if printf '%s' "$cmd" | grep -qE 'git[[:space:]]+commit[^;&|]*[[:space:]](-a|--all|-[a-zA-Z]*a[a-zA-Z]*)([[:space:]]|$)'; then
    block "do not use 'git commit -a'. Stage the files that belong to this change, run the pre-commit review, then commit."
  fi
  if printf '%s' "$cmd" | grep -qE 'git[[:space:]]+commit[^;&|]*[[:space:]]--[[:space:]]'; then
    block "do not pass paths to 'git commit'. Stage explicitly, review, then commit."
  fi
  if [ -f "$ROOT/scripts/review-gate.sh" ]; then
    if ! (cd "$ROOT" && bash scripts/review-gate.sh check >/dev/null 2>&1); then
      block "the staged changes have not passed the pre-commit review. Run the pre-commit-reviewer (docs/agents/pre-commit-reviewer.md), fix blocking findings, then run 'bash scripts/review-gate.sh mark'. If you staged more files after the review, review again."
    fi
  fi
fi

# 6. Production hosts
hosts_file="$ROOT/.claude/hooks/prod-hosts.txt"
if [ -f "$hosts_file" ]; then
  while IFS= read -r pattern || [ -n "$pattern" ]; do
    case "$pattern" in ''|\#*) continue ;; esac
    if printf '%s' "$cmd" | grep -qF -- "$pattern"; then
      block "this command touches a production host ($pattern). Production actions are human steps (docs/guides/CI-CD.md). Prepare the command and ask the human to run it."
    fi
  done < "$hosts_file"
fi

exit 0
