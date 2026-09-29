---
name: commit
description: Verify and commit changes in this repository. Use when the user says "commit", "verify and commit", "review and commit", or "check my changes". Runs the pre-commit review first and commits only when nothing blocks.
---

# Commit with a pre-commit review

Follow the commit flow in `docs/guides/GIT.md` ("Commit flow"). In Claude Code
the steps map to tools like this:

1. Run `git status` and `git diff`. Stage only the files that belong to this
   change, by name. If a file's purpose is unclear, ask.
2. Launch the `pre-commit-reviewer` subagent. Tell it which change this is
   (the `docs/changes/` folder or a one-line summary of the request).
3. Show the verdict and the findings to the user.
   - `BLOCK`: stop. Offer fixes. Do not commit.
   - `PASS WITH NOTES`: list the notes. Commit only if the user said to
     commit anyway, or after the notes are fixed and reviewed again.
   - `PASS`: continue.
4. Draft the commit message using the Git section of `AGENTS.md`.
5. If the user's request was "commit" or "verify and commit", that is the
   go-ahead once the verdict is not `BLOCK`. Otherwise show the message and ask.
6. Run `bash scripts/review-gate.sh mark`, then `git commit -m "<message>"`.
   No `-a`, no paths, no `--no-verify`.
7. Report the commit hash and message. Do not push unless asked.
