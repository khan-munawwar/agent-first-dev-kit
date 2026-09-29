# OPERATIONS

The runbook: deploys, logs, servers, and every piece of state that lives
outside git. Production actions are human steps (`guides/AUTONOMY.md`). The
agent prepares them here; the human runs them and records the result.

## What production runs

<!-- SETUP(P3): Which branch or tag is deployed, how to check the deployed version, what is built but not yet deployed. -->

## Deploy order

<!-- SETUP(P3): Exact steps in order (for example: back up, run migrations, deploy code, clear caches, verify). Link the pipeline file. -->

## Rollback

<!-- SETUP(P3): How to undo a deploy and a migration. Who can do it. -->

## Logs and monitoring

<!-- SETUP(P2): Where the real application logs are (not only the web server log), how to read them read-only, what alerts exist. -->

## Server facts and limits

<!-- SETUP(P3): Size, memory, proxy and request timeouts, restart policy, required OS packages, scheduled jobs. -->

## Settings outside the repo

<!-- SETUP(P3): Server, proxy, cloud console, DNS and third-party dashboard settings that affect behaviour but are not in git. -->

## Secrets

<!-- SETUP(P1): Where secrets live for each environment (manager, env file, CI variables). Never the values. -->

## Migration ledger

Every schema or data migration, and where it has been applied.

| Migration | Local | Staging | Production | Notes |
|---|---|---|---|---|

## Server change log

Changes to servers or external systems. The agent writes the script or steps
and sets "not yet run". The human runs it and sets "applied" with the date.

| Date | Change | Script or steps | State |
|---|---|---|---|

## Checkpoints

State outside git that a risky change could break (env files, generated
folders, cloud variables, server config). Write a checkpoint before the work,
with an exact way back. Close it when the work is safe.

| Date | What | How to restore | State (open, closed) |
|---|---|---|---|
