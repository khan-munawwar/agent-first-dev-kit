# SETUP: onboarding the agent to this project

This file tells the agent how to fill in missing project context. It is kit
text and rarely changes. The checklist itself lives in the project files as
`<!-- SETUP(P#): question -->` comments. `scripts/agent-check.sh` lists them.

## Priorities

| Priority | Needed before |
|---|---|
| P1 | Any code is written |
| P2 | The first change ships |
| P3 | The project reaches production |

## How to run setup

1. Run `bash scripts/agent-check.sh --all` to list every open item.
2. **Find before you ask.** Read the repo first: README, package and build
   files, CI config, existing docs, git log, folder layout. Propose an answer
   from what you found and ask the human to confirm it. Ask only what the
   repo cannot tell you.
3. Work in priority order: all P1, then P2, then P3.
4. Ask **at most 5 questions at a time**, the most important first. Group
   questions by file.
5. Write an answer only after the human confirms it. Then delete that SETUP
   comment. If an item does not apply, write one line saying so and why, and
   delete the comment.
6. Never write secrets, passwords, personal data or private commercial details
   into any doc. Write where they live instead.
7. Run the check again. Setup is done when it reports 0 open P1 items. P2 and
   P3 can be filled when they become relevant.

## Adopting the kit in an existing project

Existing projects usually have docs in many places. Do not delete or move
anything without a yes.

1. List every existing doc: root-level `*.md`, `docs/`, wiki exports, tool
   files (`CLAUDE.md`, `GEMINI.md`, `.cursorrules`), and the agent's own memory
   notes for this project.
2. For each one, propose a destination: merge into a kit file, move to
   `changes/`, `adr/`, `meetings/` or `incidents/`, mark as Background, or
   archive. Show the mapping as a table and wait for a yes.
3. Rules found in tool files or agent memory move into `AGENTS.md` or the
   right doc. Tool files then only point to `AGENTS.md`.
4. Decisions buried in plans become ADRs.
5. Where two docs disagree, ask which is true. Keep one source of truth.

## What setup covers

The SETUP comments ask about these areas. The agent also checks that nothing
here is missing for this kind of project.

| Area | Goes in |
|---|---|
| Product, users, goals, non-goals, principles, stakeholders | `PROJECT.md` |
| Phase (prototype, pre-launch, production) | `AGENTS.md` |
| Stack, commands, missing toolchains | `AGENTS.md` |
| Who commits, message style, attribution, branches, git identity | `AGENTS.md` Git section |
| What the agent may do alone, per environment | `guides/AUTONOMY.md` defaults, overrides in `AGENTS.md` |
| Code layout, main flows | `ARCHITECTURE.md` |
| Coding rules, database rules, one method per concern | `CONVENTIONS.md` |
| Environments, how to switch and confirm, test accounts, real side effects | `ENVIRONMENTS.md` |
| Deploy order, logs, server facts, settings outside the repo, ledgers | `OPERATIONS.md` |
| Tokens, components, reference screens, UI pitfalls | `UI.md` |
| References, vendors, APIs, their docs and how often they change | `RESOURCES.md` |
| Where secrets live, what third parties may receive | `OPERATIONS.md`, `guides/SECURITY.md` |
| Review thresholds and project checks | `REVIEW.md` |
| Private material outside the repo | `AGENTS.md` |
| Production hosts to block for the agent | `.claude/hooks/prod-hosts.txt` |

## Optional kit files

Copy these from the kit's `optional/` folder when they fit the project:

| File | Copy when |
|---|---|
| `guides/MOBILE-RELEASE.md` | The project ships a mobile app |
| `docs/API-MAP.md` | The app calls several backends or is migrating between them |
| `docs/COMMS-LEDGER.md` | You depend on a vendor or client for answers or fixes |
| `docs/handoffs/_template.md` | A hard problem is paused and must survive a fresh session |
