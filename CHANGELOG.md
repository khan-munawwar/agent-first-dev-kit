# Changelog

All notable changes to the kit. Projects read this when `agent-check.sh`
reports a newer version. Format based on Keep a Changelog; versions follow
Semantic Versioning.

## 0.3.0 (2026-10-13)

### Added
- Guide pairs: a kit guide `docs/guides/<TOPIC>.md` holds rules and reasons,
  its project partner `docs/<TOPIC>.md` holds the values. Slots are either
  required (a SETUP comment: the agent asks, never guesses) or on a kit
  default (a `default` comment: used, named once, confirmed by deleting the
  comment). Described in `docs/guides/DOCS.md`, "Guide pairs".
- `docs/GIT.md` project partner for `guides/GIT.md`: identity, who commits,
  attribution, branch naming, tracker and ticket pattern, examples, overrides.
- `scripts/settings-check.sh TOPIC`: lists required slots still open and kit
  defaults in use. First step of the commit skill.
- `agent-check.sh` reports kit defaults in use across `docs/`.
- Claude Code guard hook rule 7: no commit while a required Git slot is open.
- `AGENTS.md` hard rule 12: missing settings are asked, not guessed.

### Changed
- `guides/GIT.md` "Commit messages" is now a structure rule: imperative
  subject under 72 characters with the ticket key first when one exists, a
  short form and a long form with labels (Why, What, Verified, Touches,
  Ticket), and a `Ticket:` line always last.
- The Git section of `AGENTS.md` is a pointer to `docs/GIT.md`. `REVIEW.md`,
  `AUTONOMY.md`, the pre-commit reviewer and the commit skill point there too.

### Follow-up
- `TESTING.md` commands and `AUTONOMY.md` overrides still live in `AGENTS.md`;
  they get their own partners in a later version.

## 0.2.0 (2026-10-13)

### Added
- Workspace layout: the kit can live in a wrapper folder with the code
  repository in a sub-folder, so client repositories stay free of kit files.
  `adopt.sh --repo <subfolder>` selects it and writes `.agent-kit`.
- `scripts/kit-env.sh`: finds the kit root and the code repository for both
  layouts. `agent-check.sh`, `review-gate.sh` and the Claude Code guard hook
  use it, so git state, review markers and branch checks come from the code
  repository.
- `agent-check.sh` reports the layout, a missing repo folder, and a wrapper
  repository that does not ignore the code sub-folder.

### Changed
- Git guide, commit skill and pre-commit reviewer say where git commands run
  in the workspace layout.

### Fixed
- The Claude Code guard hook now also catches `git -C <dir> commit` and
  `git -C <dir> push`. Before, only the plain `git commit` and `git push`
  forms were checked.

## 0.1.0 (2026-09-29)

First version.

### Added
- `AGENTS.md` entry template with session start, hard rules, critical
  invariants, Git section and a docs map. Pointers for Claude Code, Gemini CLI,
  Cursor and GitHub Copilot.
- Project docs with SETUP markers: `PROJECT`, `STATUS`, `ISSUES`,
  `ARCHITECTURE`, `CONVENTIONS`, `ENVIRONMENTS`, `OPERATIONS`, `UI`,
  `RESOURCES`, `GLOSSARY`, and a docs index with reading tiers.
- `docs/SETUP.md` onboarding flow and `scripts/agent-check.sh` session check.
- Per-change chain from Anthropic's AI-native SDLC playbook: `intent.md`,
  `spec.md`, `plan.md`. `REVIEW.md` review policy.
- ADR, meeting and incident templates.
- Kit guides: `DOCS`, `WORKFLOW`, `AUTONOMY`, `GIT`, `TESTING`, `DEBUGGING`,
  `CI-CD`, `SECURITY`, `ENGINEERING`, `UI`, `BROWSER`.
- Agent roles: pre-commit reviewer, planner, QA, resource scout.
- Claude Code extras: session-start hook, Bash guard hook, review gate,
  pre-commit-reviewer subagent, commit skill.
- Optional files: mobile release guide, API map, comms ledger, handoff template.
- `scripts/adopt.sh` to copy the template into a project without overwriting.
