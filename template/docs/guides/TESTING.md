# TESTING: how to test and how to claim something works

<!-- Managed by agent-first-dev-kit v0.1.0. Project test commands live in AGENTS.md and CONVENTIONS.md. -->

## Layers

| Layer | Tool (examples) | Who runs it | When |
|---|---|---|---|
| Unit | The project's test runner | Agent | Every change |
| Integration | Test runner against a local database | Agent | Every change that touches data or APIs |
| End-to-end | Playwright, or the mobile equivalent | Agent locally, CI always | Critical flows only |
| Visual | Screenshot tests | Agent locally, CI always | Shared components, key screens |
| Exploratory | A browser or device, by hand or with a browser agent | Agent, human signs off | UX, new screens |

## Rules

- A bug fix starts with a test that fails because of the bug.
- Never delete, skip or loosen a test to make it pass. Never change expected
  values to match wrong output.
- Only say "tests pass" if they were run in this session. Name the command
  and the result.
- **Lint is not a test.** A syntax check proves nothing about behaviour.
- Test data comes from seeds and fixtures. Never real user data. Never test
  against production.
- Flaky tests go into `ISSUES.md`. Do not rerun until green.
- End-to-end tests: stable selectors (roles, test IDs), no fixed waits,
  traces kept on failure.

## Evidence ("verified" means this)

| Level | Meaning |
|---|---|
| Assumed | Reasoned from code or docs. Say "assumed". |
| Documented | The official docs say so. Cite them. |
| Built | Code exists and compiles. Not verified. |
| Tested | An automated test passes, or a manual check was done with steps. |
| Verified | Tested in the real flow: real data shapes, stored data read back, every consumer checked, dev-only shortcuts off. |

`STATUS.md` uses these words. "Done" means verified.

## What "verified" must include

- Every entry point: create, edit (with prefill), list, detail, export, API.
- The stored data read back from where it is stored, not only the success
  message.
- Release-like conditions: dev flags, mock backends and silent fallbacks off.
  A fallback that makes a screen "work" hides the real failure.
- For deploys: checked on the live environment after deploy, not only locally.

## Release-only risks

Some failures only appear in release builds or on fresh installs: missing
config that dev mode injects, env values baked in at build time, caches that
keep old values. Test at least once per release from a clean build of a
committed state, with dev settings off.

## What not to do

- Do not claim a fix from a guess. After two failed hypotheses, stop and get
  real evidence (`guides/DEBUGGING.md`).
- Do not trigger real side effects (emails, payments, orders) in tests
  without a yes.
- Do not spend many turns fighting a flaky automation tool. After two failed
  tries on a trivial manual step, ask the human.
