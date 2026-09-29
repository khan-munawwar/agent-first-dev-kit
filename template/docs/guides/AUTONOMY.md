# AUTONOMY: what the agent does alone, and where a human takes over

<!-- Managed by agent-first-dev-kit v0.1.0. Project overrides go in AGENTS.md, and must say "overrides guides/AUTONOMY.md". -->

The human stays in the loop where a mistake is expensive or cannot be undone.
The agent prepares everything; the human presses the button.

## Levels

| Level | Meaning |
|---|---|
| Alone | The agent may do it without asking, inside the current task |
| Go-ahead | The agent says exactly what it will do and waits for a yes |
| Human only | The agent prepares it (command, script, text) and the human runs it |

A go-ahead covers one task. It does not carry over to the next task.
A question from the human is never a go-ahead.

## Defaults

| Action | Prototype | Pre-launch | Production |
|---|---|---|---|
| Read code, docs, logs shared with it | Alone | Alone | Alone |
| Edit code and docs for the current task | Alone | Alone | Alone |
| Run tests, lint, local builds | Alone | Alone | Alone |
| Install or upgrade dependencies | Go-ahead | Go-ahead | Go-ahead |
| Commit (after the pre-commit review) | Per `AGENTS.md` Git section | Per Git section | Per Git section |
| Push a feature branch | Go-ahead | Go-ahead | Go-ahead |
| Merge, push to the default branch | Human only | Human only | Human only |
| Local database writes and migrations | Alone | Alone | Alone |
| Shared or staging database writes | Go-ahead | Go-ahead | Human only |
| Production database writes, schema or data | Human only | Human only | Human only |
| Read-only production access (logs, status) | Go-ahead | Go-ahead | Go-ahead, written grant |
| Server or cloud changes | Go-ahead | Human only | Human only |
| Deploy to staging | Go-ahead | Go-ahead | Human only |
| Deploy to production, release to stores | Human only | Human only | Human only |
| Change CI gates, branch protection | Human only | Human only | Human only |
| Create, rotate or read secrets | Human only | Human only | Human only |
| Send email, SMS or notifications to real people | Human only | Human only | Human only |
| Real payments, orders, vendor-side changes | Human only | Human only | Human only |
| Send project data to any third-party service | Go-ahead per case | Go-ahead per case | Go-ahead per case |
| Money, pricing, contract decisions | Human only | Human only | Human only |

## How human-only work is prepared

- **Database writes:** the agent writes the SQL or migration and the exact
  command, plus a dry run or a read-only query that shows what will change.
  The human runs it. The migration ledger in `OPERATIONS.md` records it.
- **Server changes:** the agent writes an idempotent script (safe to run
  twice) and logs it in `OPERATIONS.md` as "not yet run". The human runs it
  and sets "applied" with the date.
- **Production data questions:** run the analysis on the server; only
  aggregates leave it.
- **Messages to users:** the agent drafts. The human sends.

## Never, in any phase

- Work around a block from a hook, a permission prompt or a failing check.
  Report it and ask.
- Force-kill system services, revoke certificates or keys, or delete
  backups.
- Paste secrets into chat or docs. A secret that was pasted anywhere is
  treated as leaked and rotated.
