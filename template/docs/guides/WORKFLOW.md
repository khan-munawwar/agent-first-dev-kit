# WORKFLOW: sessions, changes and done

<!-- Managed by agent-first-dev-kit v0.1.0. Do not edit in a project; change the kit and sync. -->

## Session start

1. `bash scripts/agent-check.sh`. Handle P1 setup items first (`docs/SETUP.md`).
2. Read `docs/STATUS.md`, "Resume here" first.
3. Identify the one task for this session. If it is not in STATUS and not the
   user's request, ask.
4. Read only the docs the task needs (`docs/README.md`, "Read when").
5. Say in one line what you will do. If the message was a question, answer it
   and wait.

## The life of a change

Based on Anthropic's AI-native SDLC playbook. Each step writes a file, and the
next step starts by reading it.

| Step | Output | Who approves |
|---|---|---|
| Capture | `changes/NNNN-name/intent.md` | Requester |
| Specify | `spec.md` | Requester or product owner |
| Plan | `plan.md` (in plan mode, no code yet) | Developer |
| Build | Code and tests on a branch | Tests and self-checks |
| Review | Pre-commit review, then pull request review (`REVIEW.md`) | Reviewer, then code owner |
| Ship | Deploy (`guides/CI-CD.md`) | Human |
| Learn | Outcome in `spec.md`; issue, incident or invariant if something went wrong | Developer |

Small fixes skip the folder: a STATUS line and a clear commit are enough.

## During work

- Work on a branch. Never on the default branch.
- Stay inside the task. Do not search or edit unrelated folders. Ideas go to
  STATUS under "Ideas".
- **Ask before changing a working feature** that the task did not name.
- Write tests with the code, not after.
- Hit a lasting decision? Write an ADR and ask before continuing.
- Found a bug you will not fix now? Add it to `ISSUES.md`.
- Before touching state outside git (env files, generated folders, servers),
  write a checkpoint in `OPERATIONS.md`.
- A manual step failed twice for a reason that is not the product? Ask the
  human instead of trying again.

## Session end

1. Tests pass, or STATUS says exactly what fails and why.
2. Update `STATUS.md`: "Resume here", in progress, next, blocked.
3. Update the change folder, and any doc the work made stale.
4. Uncommitted work is either committed (through the review) or named in
   "Resume here" with the branch.
5. Lesson learned? Decide: project doc or kit (`guides/DOCS.md`).
6. Recap in a few lines: what changed, what was verified and how, what is next.

## Definition of done

- [ ] Every acceptance criterion passes, with evidence (`guides/TESTING.md`).
- [ ] Every entry point and consumer in the spec was checked.
- [ ] No existing behaviour was lost without a yes.
- [ ] UI matches the reference screen and uses tokens and shared components.
- [ ] Pre-commit review passed.
- [ ] STATUS, the change folder, and affected docs are updated.
- [ ] Human steps are written down, with their state.
