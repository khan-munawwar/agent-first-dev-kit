# Agent roles

<!-- Managed by agent-first-dev-kit. -->

Plain-Markdown role playbooks. Any tool or model can load one as its task
prompt. Each role assumes the agent has already read `AGENTS.md`.

| Role | Use when |
|---|---|
| `pre-commit-reviewer.md` | Before every commit: "commit", "verify and commit", "review my changes" |
| `planner.md` | Turning an accepted intent into a spec, or a spec into a plan and STATUS tasks |
| `qa.md` | Walking acceptance criteria by hand, or a regression pass before a release |
| `resource-scout.md` | A task leans on a reference or an external system, before anything is called blocked |

Claude Code runs the pre-commit reviewer as a subagent
(`.claude/agents/pre-commit-reviewer.md`) and the commit flow as a skill
(`.claude/skills/commit/`). Both point back to these files. Other tools read
these files directly.
