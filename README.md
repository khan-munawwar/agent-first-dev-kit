# Agent-First Development Kit

A versioned, model-agnostic and tool-agnostic framework that sets up software
projects for AI coding agents from day one.

It is based on Anthropic's
[AI-native SDLC playbook](https://claude.com/blog/the-ai-native-sdlc-playbook),
modified by nearly two years of real client work with agentic programming.

## Why this exists

AI coding agents are fast and capable. Most of the problems I have faced with
them were not about the model. They were about **missing context and missing
guardrails**:

- The agent forgets what was decided last week, and the same discussion repeats.
- A new feature looks great but does not match the rest of the app. Tables are
  the usual case.
- A visual bug is fixed, then comes back with the next similar change.
- Colours appear that do not belong in the app.
- A failing test is "fixed" by weakening the test.
- CI and deployment rules are clear in a team, but unclear when one person and
  one agent own a production app.
- The agent browses with a personal browser profile and can act as you on every
  site you are logged in to.
- Every project ends up with its own agent setup, and lessons from one project
  never reach the others.
- Switching between Claude Code, Codex, Cursor and Gemini CLI means rewriting
  instructions for each tool.

Anthropic's playbook gives a strong model for moving one change from idea to
production. It is written for enterprise teams, and it is built around Claude.
This kit keeps its core and fills the gaps I kept running into as a consultant
working alone or with small teams.

## Benefits

- **The agent is onboarded like a new hire.** On every session start it checks
  what context is missing and asks for it, a few questions at a time.
- **Decisions stick.** Every lasting decision is written down once and not
  undone without a new decision.
- **Every change has a trail**: why it was asked for, what was agreed, how it
  was built.
- **Small, focused context.** The agent reads what the task needs, not every
  document in the project.
- **Clear lines between agent and human** for testing, CI/CD, production and
  browser use.
- **UI stays consistent** through shared components, design tokens, lint rules
  and screenshot tests.
- **One kit, many projects.** The kit is versioned. A lesson learned in one
  project can be pulled into all of them.

## Model and tool agnostic

The kit is plain Markdown plus small shell scripts. Nothing in the core depends
on one model or one vendor.

- The entry point is `AGENTS.md`, which Claude Code, Codex, Cursor, Gemini CLI,
  GitHub Copilot and others can read.
- Tool-specific files (`CLAUDE.md`, Cursor rules, Gemini settings) only point to
  `AGENTS.md`. They never duplicate it.
- Checks that must give the same answer everywhere are scripts, not prompts.
- Tool-specific hooks and skills are optional extras on top. Without them the
  kit still works; with them some rules become guaranteed instead of requested.

Different models follow instructions with different strictness, so behaviour is
the same in logic and similar in practice. Scripts and hooks close the gap
where it matters most.

## What is taken from Anthropic's playbook, and what is changed

| Kept from the playbook | Added from real projects | Left out for now |
|---|---|---|
| Per-change chain: `intent.md`, `spec.md`, `plan.md` | Project status file that carries state between sessions | CI jobs that generate specs automatically |
| Short entry file, under one page | Decision records (ADRs) | Enterprise managed settings |
| "Mistake twice, it becomes a rule" | Meeting notes as sources, distilled into specs | Production metric "control bands" |
| `REVIEW.md` with fixed review passes | Reading tiers: always, on demand, background | |
| Skills guide, hooks enforce | Project phases: prototype, pre-launch, production | |
| | CI/CD, testing, browser and UI guides | |
| | Tool-agnostic entry file and a versioned kit shared across projects | |

## How it works

**Three layers**

| Layer | Holds | Where |
|---|---|---|
| Personal | Your own working preferences | Your home folder, never in a project |
| Kit | Generic rules, guides, templates, scripts | This repository |
| Project | Only what is specific to the project | The project's `AGENTS.md` and `docs/` |

**Three reading tiers**

| Tier | Examples | When the agent reads it |
|---|---|---|
| Always | `AGENTS.md`, `STATUS.md` | Every session |
| On demand | Specs, decisions, active changes | When the task touches them |
| Background | Discovery meetings, raw transcripts | Only when asked, or to trace a decision |

**One folder per change**

```
docs/changes/0007-bulk-invoice-export/
  intent.md   the problem, in the requester's words
  spec.md     what will be built and how it will be checked
  plan.md     files, order of work, risks, tests
```

## How to use it

### 1. Add the kit to a project

```
git clone https://github.com/khan-munawwar/agent-first-dev-kit.git
bash agent-first-dev-kit/scripts/adopt.sh /path/to/your/project
```

`adopt.sh` copies the template into the project and **never overwrites** an
existing file. It lists anything it skipped, so you can merge by hand or ask
the agent to. Add `.claude/settings.local.json` to the project's `.gitignore`.

### 2. Start an agent session

Open the project in Claude Code, Codex, Cursor, Gemini CLI or Copilot. The
agent reads `AGENTS.md` and runs `scripts/agent-check.sh`, which reports:

```
== agent-check: my-project
kit version: 0.1.0
phase: NOT SET
setup items open: 57 (P1: 24, P2: 25, P3: 8). Follow docs/SETUP.md.
  P1 AGENTS.md:19  What is this product, who uses it, what problem does it solve?
  ...
STATUS.md last updated: never
git: branch main, 10 changed files (0 staged)
```

### 3. Let the agent onboard itself

Following `docs/SETUP.md`, the agent reads the repo first, proposes answers,
and asks you only what it cannot find, at most five questions at a time. Each
answer replaces a `<!-- SETUP(P1): question -->` comment in the right file.
P1 items are needed before code, P2 before the first change ships, P3 before
production. In an existing project, it first maps your current docs into the
structure and asks before moving anything.

### 4. Work in changes

Every piece of work starts as `docs/changes/NNNN-name/intent.md`, becomes a
`spec.md`, then a `plan.md`, then code. Small fixes skip the folder.

### 5. Commit through the pre-commit reviewer

Say "commit" or "verify and commit". The pre-commit reviewer looks at the git
changes on its own, works out why they were made, and checks them against
your rules, ADRs, UI rules, security and tests, like a pull request review
before the pull request exists. It returns `PASS`, `PASS WITH NOTES` or
`BLOCK`, with findings and a draft commit message. In Claude Code, a hook
blocks any commit whose staged changes did not pass the review.

### 6. Keep the kit and the project in sync

End every session by updating `docs/STATUS.md`. When you learn something that
applies to every project, change the kit, bump `VERSION`, and add a line to
`CHANGELOG.md`. Set `AGENT_KIT_PATH` to your kit checkout and
`agent-check.sh` tells each project when a newer kit exists.

## Layout

```
template/                         copied into your project by adopt.sh
  AGENTS.md                       entry point for every tool
  REVIEW.md                       review policy (severity, passes, project checks)
  CLAUDE.md  GEMINI.md            pointers to AGENTS.md
  .cursor/rules/agents.mdc        pointer to AGENTS.md
  .github/copilot-instructions.md pointer to AGENTS.md
  .claude/                        Claude Code extras (optional, never required)
    settings.json                 session-start check, Bash guard hook
    hooks/guard-bash.sh           blocks push to main, force push, --no-verify,
                                  unreviewed commits, production hosts
    hooks/prod-hosts.txt          your production hosts
    agents/pre-commit-reviewer.md reviewer as a subagent with its own context
    skills/commit/SKILL.md        "verify and commit" flow
  scripts/
    agent-check.sh                session check: setup gaps, status, git state
    review-gate.sh                ties a commit to a passed review
  docs/
    README.md                     index with reading tiers
    SETUP.md                      how the agent onboards itself
    PROJECT.md STATUS.md ISSUES.md ARCHITECTURE.md CONVENTIONS.md
    ENVIRONMENTS.md OPERATIONS.md UI.md RESOURCES.md GLOSSARY.md
    changes/_template/            intent.md spec.md plan.md
    adr/  meetings/  incidents/   with templates
    agents/                       pre-commit-reviewer, planner, qa, resource-scout
    guides/                       DOCS WORKFLOW AUTONOMY GIT TESTING DEBUGGING
                                  CI-CD SECURITY ENGINEERING UI BROWSER
optional/                         copy when the project needs it
  docs/guides/MOBILE-RELEASE.md
  docs/API-MAP.md  docs/COMMS-LEDGER.md  docs/handoffs/_template.md
scripts/adopt.sh                  copy the template into a project
VERSION  CHANGELOG.md
```

**Who owns what:** files in `docs/guides/`, `docs/agents/`, `scripts/` and
`.claude/hooks/guard-bash.sh` are managed by the kit and replaced on sync.
Everything else belongs to the project.

## Requirements

Bash and git. The Claude Code guard hook uses `jq` or `python3` if present.
On Windows, use Git Bash or WSL.

## Status

Version 0.1.0. Tested on macOS. Feedback from real use will shape the next
versions.

- [x] Templates, guides, agent roles
- [x] `agent-check.sh`, `review-gate.sh`, `adopt.sh`
- [x] Claude Code hooks, subagent and skill
- [ ] Automated sync command (today: follow `docs/guides/DOCS.md`, "Syncing with the kit")
- [ ] Hook examples for other tools
- [ ] Lint and screenshot-test starter configs for UI enforcement

## Contributing

Ideas and corrections are welcome through issues and pull requests.

## License

Licensed under [CC BY 4.0](LICENSE). You may use, share and adapt this kit,
including for commercial work, as long as you give credit:

> Agent-First Development Kit by Munawwar Khan,
> https://github.com/khan-munawwar/agent-first-dev-kit, licensed under CC BY 4.0.
