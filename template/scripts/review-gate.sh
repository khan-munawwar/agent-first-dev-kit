#!/usr/bin/env bash
# review-gate.sh: ties a commit to a finished pre-commit review.
# Part of agent-first-dev-kit.
#
# The fingerprint is a hash of the staged diff. After the pre-commit review
# passes, "mark" records the fingerprint. "check" passes only if the staged
# diff is exactly what was reviewed. Anything staged after the review changes
# the fingerprint, so the review must run again.
#
# Markers live inside .git/, so they are never committed.
#
# Usage:
#   bash scripts/review-gate.sh hash    print the fingerprint of the staged diff
#   bash scripts/review-gate.sh mark    record that the staged diff was reviewed
#   bash scripts/review-gate.sh check   exit 0 if reviewed, exit 1 if not

set -u
git rev-parse --git-dir >/dev/null 2>&1 || { echo "review-gate: not a git repository" >&2; exit 1; }

dir="$(git rev-parse --git-dir)/agent-review"

fingerprint() {
  git diff --cached --binary | git hash-object --stdin
}

has_staged() {
  ! git diff --cached --quiet
}

case "${1:-}" in
  hash)
    fingerprint
    ;;
  mark)
    has_staged || { echo "review-gate: nothing staged" >&2; exit 1; }
    mkdir -p "$dir"
    fp=$(fingerprint)
    date -u +%Y-%m-%dT%H:%M:%SZ > "$dir/$fp"
    echo "review-gate: marked $fp"
    ;;
  check)
    has_staged || { echo "review-gate: nothing staged" >&2; exit 1; }
    fp=$(fingerprint)
    if [ -f "$dir/$fp" ]; then
      echo "review-gate: staged changes were reviewed ($fp)"
      exit 0
    fi
    echo "review-gate: staged changes have not passed the pre-commit review. Run it first (docs/agents/pre-commit-reviewer.md)." >&2
    exit 1
    ;;
  *)
    echo "usage: bash scripts/review-gate.sh hash|mark|check" >&2
    exit 2
    ;;
esac
