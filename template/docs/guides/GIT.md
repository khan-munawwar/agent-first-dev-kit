# GIT: branches, commits and pull requests

<!-- Managed by agent-first-dev-kit v0.3.0. Project settings (identity, who commits, ticket pattern, examples, overrides) live in docs/GIT.md. -->

## Project settings

This guide holds the rules. The values that make them concrete for one
project live in `docs/GIT.md`, which the kit never replaces (`DOCS.md`,
"Guide pairs"). Slots:

| Slot | Required | Kit default |
|---|---|---|
| Git name and email for this repository | yes | none: never guess |
| Tracker and ticket key pattern | yes | none: "none" is a valid answer |
| Who commits | no | human |
| AI attribution | no | off |
| Who pushes and merges | no | human |
| Default branch and protection | no | `main`, protected |
| Branch naming | no | `<ticket>-short-name`, else `<type>/short-name` |
| Form, labels, project additions | no | this guide's "Commit messages" |
| Two real examples | later (P2) | the examples in this guide |

When a setting is missing:
- **Required slot still open** (a SETUP comment): stop before the task that
  needs it and ask the human, at most five questions at a time. Never guess.
  In Claude Code the guard hook blocks `git commit` while a P1 slot is open.
- **Slot on the kit default** (a "default" comment): use the default, and say
  once per session: "Using the kit default for <slot> (docs/GIT.md). Tell me
  your preference and I will record it." Do not stop.

`bash scripts/settings-check.sh GIT` prints both lists and is the first step
of every commit flow.

## Branches

- The default branch is protected: changes arrive only through pull requests.
- Work on short-lived branches. Naming follows `docs/GIT.md`.
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
5. Draft the message per "Commit messages" below with the values in
   `docs/GIT.md`.
6. Commit only if the project lets the agent commit and the user asked for it.
   Otherwise hand the message to the human.
7. In Claude Code, run `bash scripts/review-gate.sh mark` right before
   `git commit`. The guard hook blocks commits whose staged diff was not
   reviewed.

Rules:
- In the workspace layout the code repository is a sub-folder of the kit root
  (`.agent-kit`, `scripts/kit-env.sh`). The kit's scripts already run git
  there. When you run git yourself, run it in that folder (`git -C <repo>` or
  `cd` first), never at the kit root.
- No `git commit -a`, no paths after `git commit`, no `--no-verify`.
- No force push. No push to the default branch.
- Commit from a clean, known state before any build that others will test.
- Do not leave work uncommitted across many sessions. If it must wait, name
  it in STATUS "Resume here".

## Commit messages

The structure is a kit rule. The ticket pattern, labels and examples are
project values in `docs/GIT.md`.

**Subject.** Imperative mood, under 72 characters, no trailing period. When a
ticket exists, its key opens the subject. No type prefixes (`feat:`, `fix:`)
unless `docs/GIT.md` overrides this. One topic per commit.

**Two forms.** Use the short form when a reader of the diff needs no
explanation. Use the long form whenever the change touches behaviour,
security, data, infrastructure, or when a reader would ask "why".

**Short form:** the subject, a blank line, then the `Ticket:` line.

```
PRJ-44 Invalidate the My Tasks cache on create and delete too

Ticket: PRJ-44
```

**Long form:** the subject, then a body with these labels in this order.
Each label starts a paragraph. Skip a label only when it has nothing to say.

- `Why:` the problem or need, in one or two sentences.
- `What:` what the change does and does not cover.
- `Verified:` what was run and its result. "Not run" is a valid, honest value.
- `Touches:` the areas changed and whether tests were added.
- `Ticket:` the key, or `none`. Always the last line.

Optional labels: `Not covered:`, `Follow-up:`.

```
PRJ-41 Clear the client audit advisories that blocked the build

Why: new upstream advisories made the prebuild gate fail every client
build, locally and in CI.

What: npm audit fix bumps nine transitive packages in the lockfile. Two
advisories have no usable fix and are allowlisted with a written reason;
both are build-time only. The gate script now resolves dependency chains.

Verified: gate passes on the fixed tree, fails when an allowlist entry is
removed, client image builds with the gate running inside Docker.

Touches: client lockfile, gate script, allowlist. Tests: none added.
Ticket: PRJ-41
```

**Attribution.** Follows the `docs/GIT.md` setting exactly. When off, no
trailers, no "Generated with", no session links, nothing.

**Why labels.** They keep a long message scannable and stop it drifting into
a summary of the diff. A body that only restates the diff is the wrong form.

## Identity

The identity for this repository is a required slot in `docs/GIT.md`. Before
the first commit, compare it with `git config user.name` and `user.email` in
the repository and fix any mismatch with `git config` (no `--global`). Never
take an identity from the machine default or from the AI tool's account. For
public repositories, consider the hosting service's private no-reply address.

## Pull requests

- The description links the change folder and states how it was verified.
- The same review passes (`REVIEW.md`) run on the pull request.
- The human merges.
