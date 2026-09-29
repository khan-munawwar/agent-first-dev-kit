# GIT: branches, commits and pull requests

<!-- Managed by agent-first-dev-kit v0.1.0. The project's own settings (who commits, message style, attribution, identity) live in the Git section of AGENTS.md. -->

## Branches

- The default branch is protected: changes arrive only through pull requests.
- Work on short-lived branches. Naming follows the Git section of `AGENTS.md`.
- One topic per branch. Delete branches after merge. Stale branches are pruned
  at each milestone.
- Production runs a known branch or tag (`OPERATIONS.md`), never a random
  feature branch.

## Commit flow (every commit, every tool)

1. `git status` and `git diff`. Know every changed file.
2. Stage only the files that belong to this change, by name. Never stage env
   files, secrets, backups, scratch files or build output.
3. Run the pre-commit review (`docs/agents/pre-commit-reviewer.md`).
4. `BLOCK`: fix, stage, review again. `PASS WITH NOTES`: fix or get a yes to
   commit anyway. `PASS`: continue.
5. Draft the message in the project style (`AGENTS.md` Git section).
6. Commit only if the project lets the agent commit and the user asked for it.
   Otherwise hand the message to the human.
7. In Claude Code, run `bash scripts/review-gate.sh mark` right before
   `git commit`. The guard hook blocks commits whose staged diff was not
   reviewed.

Rules:
- No `git commit -a`, no paths after `git commit`, no `--no-verify`.
- No force push. No push to the default branch.
- Commit from a clean, known state before any build that others will test.
- Do not leave work uncommitted across many sessions. If it must wait, name
  it in STATUS "Resume here".

## Commit messages

The style is a project choice, set in `AGENTS.md` with two real examples.
Whatever the style:
- One topic per commit.
- Say what changed, in the project's voice.
- Attribution (for example `Co-Authored-By` lines for an AI) follows the
  project setting exactly. If the setting is off, no trailers, no session
  links, nothing.

## Identity

Check `git config user.name` and `user.email` before the first commit in a
repo. Set them per repository (`git config` without `--global`) when the
project needs a different identity from the machine default. For public
repositories, consider the hosting service's private no-reply email address.

## Pull requests

- The description links the change folder and states how it was verified.
- The same review passes (`REVIEW.md`) run on the pull request.
- The human merges.
