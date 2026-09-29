# Docs index

Every doc is reachable from here in one hop. The "Tier" and "Read when"
columns tell an agent what to load. Nothing outside the "Always" tier is read
by default. How the system works: `guides/DOCS.md`.

Tiers: **Always** = every session. **On demand** = when the task touches it.
**Background** = only when asked, or to trace where a decision came from.

## Project docs (owned by this project)

| File | Tier | Read when |
|---|---|---|
| `../AGENTS.md` | Always | Every session, first |
| `STATUS.md` | Always | Every session, second |
| `SETUP.md` | On demand | `agent-check.sh` reports open SETUP items |
| `PROJECT.md` | On demand | Scoping, prioritising, writing an intent or spec |
| `ISSUES.md` | On demand | Fixing bugs, touching an area with known issues |
| `ARCHITECTURE.md` | On demand | Adding code, finding where something lives |
| `CONVENTIONS.md` | On demand | Writing or reviewing code |
| `ENVIRONMENTS.md` | On demand | Running, testing, switching environments, test accounts |
| `OPERATIONS.md` | On demand | Deploys, migrations, logs, servers, anything outside git |
| `UI.md` | On demand | Any UI work |
| `RESOURCES.md` | On demand | A task leans on a reference or an external system |
| `GLOSSARY.md` | On demand | A domain word is unclear |
| `../REVIEW.md` | On demand | Reviewing or committing |

## Folders

| Folder | Tier | Read when |
|---|---|---|
| `changes/` | On demand | Working on a change: read its `intent.md`, `spec.md`, `plan.md` |
| `adr/` | On demand | A decision is questioned or a new one is needed |
| `meetings/` | Background | Tracing where a requirement came from |
| `incidents/` | On demand | Same area as a past incident, or writing a new one |
| `guides/` | On demand | The task needs the rule (see the table below) |
| `agents/` | On demand | Acting in a role: reviewer, planner, QA, resource scout |

## Kit guides (`guides/`, managed by agent-first-dev-kit)

| Guide | Read when |
|---|---|
| `DOCS.md` | Adding, moving or pruning docs; syncing with the kit |
| `WORKFLOW.md` | Starting or finishing a change or a session |
| `AUTONOMY.md` | Unsure whether you may do something without the human |
| `GIT.md` | Branching, committing, pushing, pull requests |
| `TESTING.md` | Writing tests, claiming something works |
| `DEBUGGING.md` | A bug, a failed hypothesis, or a claim about an external system |
| `CI-CD.md` | Pipelines, builds, deploys, releases |
| `SECURITY.md` | Auth, secrets, user data, third-party services |
| `ENGINEERING.md` | Errors, fallbacks, config, i18n, AI features, generated files |
| `UI.md` | Any UI work, with the project's `docs/UI.md` |
| `BROWSER.md` | Using a browser for testing or checking |

## Other docs

<!-- SETUP(P2): List any other doc this project has (existing plans, specs, audits), with a tier and a "read when" line. Existing docs found during setup are listed here first, then moved or archived as agreed. -->
