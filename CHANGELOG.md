# Changelog

All notable changes to the kit. Projects read this when `agent-check.sh`
reports a newer version. Format based on Keep a Changelog; versions follow
Semantic Versioning.

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
