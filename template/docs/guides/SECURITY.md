# SECURITY: secrets, data and access

<!-- Managed by agent-first-dev-kit v0.1.0. -->

## Secrets

- Secrets live in git-ignored env files, a secret manager, or CI variables.
  Never in code, docs, commit messages, test fixtures or chat.
- **Pasted means leaked.** A secret that appeared in chat, a doc, a log or a
  commit is rotated. Removing it later is not enough.
- Nothing secret goes into client bundles (web or mobile apps). Anything in
  the bundle is public.
- No config with credentials inside the web root.
- Docs record where a secret lives, never its value.

## Data leaving the project

Nothing from the project (code, config, logs, database rows, user data,
secrets, error text, or summaries of these) goes to a third-party service
without an explicit yes for that case. This includes web search, web fetch,
external APIs, hosted pages, cloud agents and AI tools outside the project's
agreed provider. Generic questions with nothing from the project are fine.

When asking, say exactly what would be sent and where.

## Access control

- Every new endpoint and query checks who the user is **and** that they own
  or may see the record (owner scoping). Missing owner checks on new code are
  the most common repeat finding.
- IDs in URLs follow the project rule (opaque IDs where required).
- Validate every input: type, size, allowed values, file type and size for
  uploads.
- Keep a "pattern to copy" for each security rule in `docs/CONVENTIONS.md`, so
  new code copies the safe version.

## Errors

- Users see a generic message. The log gets the full detail.
- Never show stack traces, SQL, internal API text or vendor errors to users.

## Personal and client data

- No real personal data in fixtures, docs, screenshots or commit messages.
- Production data analysis runs where the data lives. Only aggregates leave.
- Screenshots and recordings made by agents stay local.

## Security findings

Track each finding with: location, impact, fix, how to verify, and a status
(open, fixed, verified). Critical findings block new features in the same
area until fixed.
