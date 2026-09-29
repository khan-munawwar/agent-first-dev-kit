# Changelog

All notable changes to the kit. Projects read this when `agent-check.sh`
reports a newer version. Format based on Keep a Changelog; versions follow
Semantic Versioning.

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
