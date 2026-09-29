# REVIEW.md

The review policy for every change, from Anthropic's AI-native SDLC playbook.
The same passes run on every change: before a commit (the pre-commit reviewer,
`docs/agents/pre-commit-reviewer.md`) and again on the pull request.

## Severity

| Level | Meaning | Effect |
|---|---|---|
| Blocking | Wrong behaviour, security or data risk, broken rule or invariant, lost work | Stops the commit |
| Important | Likely bug, missing test, stale doc, risky pattern | Fix before merge, or record in `docs/ISSUES.md` |
| Nit | Style, naming, small cleanup | Optional |

<!-- SETUP(P2): Adjust the thresholds if needed. Example: "In production phase, a missing test for changed logic is Blocking." Delete this comment when settled. -->

## Passes

1. **Intent and scope.** The change matches its intent and spec. Every changed
   file is explained by that intent. Unrelated changes are split out.
2. **Correctness.** Logic, edge cases, error paths, data shapes at every seam
   (what writes the data, what reads it), and removed behaviour.
3. **Rules.** `AGENTS.md` hard rules and critical invariants, accepted ADRs,
   `docs/CONVENTIONS.md`, and the kit guides that apply.
4. **Security and data.** Secrets, auth and owner checks on every new query
   or endpoint, input validation, user-facing errors without internals, no
   data sent to third parties.
5. **UI.** Design tokens, shared components, the reference screen, known UI
   pitfalls (`docs/UI.md`).
6. **Tests and evidence.** Tests added or updated with the logic. No weakened
   tests. The claimed verification has a receipt.
7. **Docs.** STATUS, ISSUES, the change folder, ARCHITECTURE, OPERATIONS
   ledgers and invariants are updated where this change makes them stale.
8. **Hygiene.** Debug code, generated files edited by hand, backups or copies
   of folders, large binaries, lockfile churn, local URLs or dev flags that
   could ship.
9. **Commit.** One topic per commit. The message follows the Git section of
   `AGENTS.md`. Attribution follows the project setting.

## Project-specific checks

<!-- SETUP(P2): Checks that only apply to this project, one line each. Examples of the kind: "every new endpoint has an owner check", "every new string exists in all locale files", "no literal AI model IDs outside the central config". -->

## Excluded from review

<!-- SETUP(P2): Paths the reviewer should skip (generated code, vendored libraries, build output). -->
