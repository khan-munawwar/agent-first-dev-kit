# DOCS: how this documentation system works

<!-- Managed by agent-first-dev-kit v0.1.0. Do not edit in a project; change the kit and sync. -->

## The idea

`AGENTS.md` is the one entry file that every tool reads. It points to a small
set of project docs that carry state between sessions, a per-change trail
(intent, spec, plan), decision records, and kit guides that hold the generic
rules. Tool-specific files only point to `AGENTS.md`.

## Three layers

| Layer | Holds | Where | Changes when |
|---|---|---|---|
| Personal | One developer's own preferences | Home folder, imported by the tool's global config | That person changes them |
| Kit | Generic rules, guides, templates, scripts | `docs/guides/`, `docs/agents/`, `scripts/`, templates | The kit is synced |
| Project | Everything specific to this project | `AGENTS.md`, `REVIEW.md`, other `docs/` files | Every session |

A closer layer wins. When a project overrides a guide, it says so in words:
"overrides guides/X.md: ...".

## Three reading tiers

| Tier | Loaded | Examples |
|---|---|---|
| Always | Every session | `AGENTS.md`, `STATUS.md` |
| On demand | When the task touches it | specs, ADRs, conventions, UI, operations |
| Background | Only when asked, or to trace a decision | meeting notes, transcripts, old analysis |

The tier of every file is in `docs/README.md`. Front matter can also carry
`status: active | background | superseded` and `absorbed_into:`.

## Where does it go?

| You have | Put it in |
|---|---|
| A task, a next step, a blocker | `STATUS.md` (the only task list) |
| A bug you will not fix now | `ISSUES.md` |
| A bug that happened twice | `ISSUES.md` and "Critical invariants" in `AGENTS.md` |
| A problem with real impact | `incidents/` |
| A lasting decision | `adr/` |
| A new piece of work | `changes/NNNN-name/` |
| A meeting | `meetings/` |
| A rule for how code is written here | `CONVENTIONS.md` |
| A fact about servers, deploys, state outside git | `OPERATIONS.md` |
| A generic lesson for every project | The kit (see "Growing the kit") |
| A secret, password, personal or commercial detail | Nowhere in the repo. Write where it lives. |

Do not create a new file for one bug, one task or one correction.

## Rules that keep it healthy

- **One source of truth.** Each fact lives in one place. Other places link to
  it. Never "update both".
- **One task list.** `STATUS.md`. No second tracker, watchdog or TODO file.
- **Small files.** `AGENTS.md` under one page. Any section over about 30
  lines moves to its own file with a link. A living doc over about 300 lines
  is split: status, history and plan do not share a file.
- **No docs at the repo root** except `README.md`, `AGENTS.md`, `REVIEW.md`,
  tool pointer files, and standard files (`LICENSE`, `CHANGELOG.md`,
  `SECURITY.md`, `CONTRIBUTING.md`).
- **Engineering docs only.** Marketing, sales and pitch material lives
  elsewhere.
- **Tool memory is a cache, the repo is the truth.** When an agent's own
  memory holds a project rule, move the rule into the repo and delete it from
  memory. Memory may keep only personal preferences and pointers.
- **Docs are not mirrored** to hosted pages or other tools. Link instead.
- **A stale doc is worse than none**, because agents trust it.

## Pruning (at every milestone)

- Delete "Done" in `STATUS.md`. Move closed issues. Mark superseded ADRs.
- Set finished meetings and changes to background.
- Re-read `AGENTS.md`. Keep it under one page.
- Check `ARCHITECTURE.md` against the real folders.
- Remove backup folders, scratch files and old copies.

## Growing the kit

At the end of a session, when a lesson was learned, ask: is it only for this
project, or for every project?
- Only this project: `AGENTS.md` invariant, `CONVENTIONS.md`, or the right doc.
- Every project: propose a change to the kit. The kit gets a changelog line
  and a version bump.

## Syncing with the kit

The project records its kit version at the top of `AGENTS.md`. When
`agent-check.sh` reports a newer kit (set `AGENT_KIT_PATH` to your local kit
checkout):
1. Read the kit's `CHANGELOG.md` from the project's version to the latest.
2. Show the human what would change. Wait for a yes.
3. Replace kit-managed files (`docs/guides/`, `docs/agents/`, `scripts/`,
   `.claude/hooks/guard-bash.sh`, templates). Never overwrite project-owned
   files; apply their template changes by hand, keeping the project's content.
4. Update the version at the top of `AGENTS.md`.
