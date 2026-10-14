# GIT: project settings

Rules and reasons live in `guides/GIT.md` (kit-managed). This file fills that
guide's slots and is owned by the project. Two kinds of HTML comment mark
the state of a slot:

- A SETUP comment with priority P1 is a required slot with no default. The
  agent asks for it before the first commit and never guesses.
- A comment holding only the word "default" marks a value still on the kit
  default. The agent uses it and says so once per session. Delete that
  comment to confirm the value, or replace the value with your own.

`bash scripts/settings-check.sh GIT` lists both.

## Identity and permissions

- **Git name and email for this repository:** <!-- SETUP(P1): The exact user.name and user.email to set with `git config` (no --global) in this repository. Never take them from the machine default or from the AI account. -->
- **Who commits:** the human. The agent stages, runs the pre-commit review and drafts the message. <!-- default -->
- **AI attribution:** off. No `Co-Authored-By`, no "Generated with", no session links. <!-- default -->
- **Who pushes and merges:** the human. The agent may push a feature branch only on a go-ahead and never a default branch. <!-- default -->

## Branches

- **Default branch:** `main`, protected. Changes arrive by pull request. <!-- default -->
- **Branch naming:** `<ticket>-short-name` when a ticket exists, otherwise `<type>/short-name` with type one of fix, feat, chore, docs. <!-- default -->

## Commit messages

- **Tracker and ticket key pattern:** <!-- SETUP(P1): Name the tracker (ClickUp, Jira, GitHub issues, ...) and the key pattern, for example `PRJ-NNN`, or write "none". With a pattern set, the key opens the subject when a ticket exists, and the last body line is always `Ticket: KEY` or `Ticket: none`. -->
- **Form:** short form when the diff explains itself, long form otherwise (`guides/GIT.md`, "Commit messages"). <!-- default -->
- **Long form labels:** Why, What, Verified, Touches, Ticket. Optional: Not covered, Follow-up. <!-- default -->
- **Project additions:** none. <!-- default -->

### Examples

Until two real commits from this repository are listed here, the agent uses
the examples in `guides/GIT.md`. <!-- default -->

<!-- SETUP(P2): Replace this comment with one short-form and one long-form commit message from this repository's history, verbatim, once they exist. -->

## Overrides

None. An override names the kit rule it replaces and the reason, for example:
"Overrides `guides/GIT.md` 'no type prefixes': the release tool parses `feat:`."
