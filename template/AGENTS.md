# AGENTS.md

<!-- agent-first-dev-kit v0.1.0 -->
Entry point for every AI coding agent (Claude Code, Codex, Cursor, Gemini CLI,
Copilot and others). Keep this file under one page. Detail lives in `docs/`.

## Session start (every session)

1. Run `bash scripts/agent-check.sh`. It reports missing context, stale status
   and git state. It changes nothing.
2. If it lists `SETUP` items, work through `docs/SETUP.md` first. If the user
   asks for something urgent, do that, and name the missing items in one line.
3. Read `docs/STATUS.md`. Then read only what the task needs, using the
   "Read when" column in `docs/README.md`.
4. Say in one line what you will do before you do it.

## Project

<!-- SETUP(P1): What is this product, who uses it, what problem does it solve? 2 to 4 sentences. Full detail goes in docs/PROJECT.md. -->

Phase: <!-- SETUP(P1): prototype | pre-launch | production. Rules in docs/guides tighten by phase. -->

## Stack and commands

<!-- SETUP(P1): Languages, frameworks, database, hosting. One line each. -->

```
<!-- SETUP(P1): Exact commands for install, run, test, lint, typecheck, build. One per line with a short comment. Note any toolchain that is missing locally and the workaround. -->
```

## Hard rules

1. **Questions get answers, not actions.** Change files only when asked. A
   go-ahead covers that task only.
2. **Scope.** Build only what the current change's `spec.md` covers. Ideas go
   to `docs/STATUS.md` under "Ideas".
3. **Decisions stick.** Never undo an accepted ADR in `docs/adr/`. Propose a
   new one that supersedes it.
4. **Tests are ground truth.** Never weaken, skip or delete a test to make it
   pass. "Done" needs runtime evidence, not only lint (`docs/guides/TESTING.md`).
5. **Claims need receipts.** Say how you know: tested, documented, or assumed
   (`docs/guides/DEBUGGING.md`).
6. **Review before commit.** Every commit passes the pre-commit review
   (`docs/agents/pre-commit-reviewer.md`). Blocking findings stop the commit.
7. **Human-only actions** are listed in `docs/guides/AUTONOMY.md`: production
   deploys, database writes outside local, secrets, CI gates, sending
   anything to real users. Prepare them; do not run them.
8. **Nothing leaves the project without a yes.** Code, logs, data, errors and
   secrets never go to a third-party service (web search, external APIs,
   hosted tools) without an explicit yes for that case.
9. **UI** uses existing components and design tokens (`docs/UI.md`).
10. **Mistake twice, it becomes a rule** in "Critical invariants" below or in
    the right doc.
11. **Every session that changed something ends by updating `docs/STATUS.md`.**

<!-- SETUP(P2): Project-specific hard rules, at most 5. One line each, with the reason in brackets. Delete this comment if there are none. -->

## Critical invariants

Rules promoted from real incidents. One line each, linking to the incident or
doc with the detail. The pre-commit reviewer checks every one.

<!-- SETUP(P2): Start empty. Add a line when a bug repeats or an incident happens. Example shape: "Never X, because Y broke (docs/incidents/2026-01-01-y.md)." -->

## Git

<!-- SETUP(P1): Who commits (agent or human)? Commit message style with 2 real examples. AI attribution on or off? Branch naming. Is the default branch protected? Git name and email for this repo. Generic process: docs/guides/GIT.md. -->

## Where things are

| Need | File |
|---|---|
| Index of all docs, with "read when" | `docs/README.md` |
| Missing context and how to fill it | `docs/SETUP.md` |
| Current work, next steps, blockers | `docs/STATUS.md` |
| Goals, users, principles, non-goals | `docs/PROJECT.md` |
| Known bugs and sharp edges | `docs/ISSUES.md` |
| Code layout and main flows | `docs/ARCHITECTURE.md` |
| Project coding rules | `docs/CONVENTIONS.md` |
| Environments, test accounts, config | `docs/ENVIRONMENTS.md` |
| Deploy, logs, server facts, ledgers | `docs/OPERATIONS.md` |
| Design tokens, components, reference screens | `docs/UI.md` |
| References and external systems | `docs/RESOURCES.md` |
| Domain words | `docs/GLOSSARY.md` |
| One folder per change: intent, spec, plan | `docs/changes/` |
| Decisions | `docs/adr/` |
| Meetings, incidents | `docs/meetings/`, `docs/incidents/` |
| How we work (kit guides) | `docs/guides/` |
| Agent roles | `docs/agents/` |
| Review policy | `REVIEW.md` |

<!-- SETUP(P2): Private material kept outside the repo (contracts, pricing, recordings)? Give the path and the rule "read when X, never copy into the repo", or write "none". -->
