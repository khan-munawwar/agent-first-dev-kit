# ENGINEERING: defaults for code quality

<!-- Managed by agent-first-dev-kit v0.1.0. Project rules in docs/CONVENTIONS.md add to or override these. -->

## Read before writing

- Search for an existing helper, component or pattern before adding one.
- **One method per concern.** If the project already has a way to fetch data,
  navigate, style, validate or format, use it. Adding a second way needs a yes
  and an entry in `docs/CONVENTIONS.md`.

## Fail loudly

- No silent fallbacks. If code falls back to another source or default, it
  logs that it did.
- No swallowed errors. Every catch either handles the error or logs it and
  re-raises.
- Never pass placeholder content ("[unsupported file]", empty strings) on as
  if it were real data.
- Loops with a limit say so in the log when they hit it, and return an error
  instead of an empty result.
- A missing system package or dependency fails at startup with a clear
  message, not later with empty output.

## Errors users see

A clear, generic message and a next step. The full detail goes to the log.
(`guides/SECURITY.md`)

## Long-running work

Work that can take longer than a normal request (AI calls, imports, exports,
file processing) runs in the background. Web requests have proxy timeouts;
users retry, and the retries pile up. Log request durations so slow paths are
visible.

## Configuration

- External versions (AI model IDs, API versions, SDK endpoints) live in one
  central config. Never as literals in feature code. Deprecated IDs break
  features without warning.
- Config baked in at build time is documented in `docs/ENVIRONMENTS.md`.

## Generated files

Build output, generated native projects, generated API clients and lock files
are never edited by hand. Fixes go into the source (config, plugins,
generators) so they survive the next regenerate.

## AI features

- Text the AI reads (prompts, tool descriptions, option lists, feature
  catalogues) is generated from, or checked against, the code. When options
  change in code, that text changes in the same commit. A drift check in CI is
  ideal.
- Verifiers check that output is correct, not only that it exists.

## Data lifecycle

For every new stored record or file: who writes it, who reads it, how long it
is kept, how it is deleted. Data that is written and never read, and deletes
that leave orphan files, are bugs.

## Internationalisation

If the project has more than one language: every new string exists in every
locale file, no raw keys ship, and no customer-specific text ends up in
product copy.

## Removing behaviour

Removing a fallback, route, permission or option is a behaviour change. It
needs to be in the spec, or a yes.
