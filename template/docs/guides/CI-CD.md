# CI-CD: pipelines, builds, deploys and releases

<!-- Managed by agent-first-dev-kit v0.1.0. Project pipeline facts live in docs/OPERATIONS.md. -->

The agent helps at every stage. The human owns every step that changes what
real users get. Levels are defined in `guides/AUTONOMY.md`.

## Who does what

| Stage | Agent | Human |
|---|---|---|
| Local | Code, tests, lint, build | |
| Branch and pull request | Push branch (with go-ahead), draft PR description, run review passes | Open or approve PR, merge |
| CI fails | Read the logs, find the cause, propose the fix | Approve the fix |
| Pipeline config | Propose changes, explain the effect | Approve every change |
| Staging deploy | Run smoke checks after deploy | Trigger it in production phase |
| Production deploy | Checklist, release notes, rollback plan, post-deploy checks to run | Deploy |
| Mobile store release | Build with the agreed method, bump version | Choose the upload path, submit |
| Incident | Diagnose from shared logs, propose the fix | Apply it, run data fixes |

## Never

- Skip, weaken or disable a failing check to get a green build.
- Use `--no-verify`, force push, or push to the default branch.
- Change branch protection or required checks.
- Add, print or move secrets.

## Pipeline basics every project should have

- On every pull request: tests, lint, typecheck, and a build.
- On the default branch: the production build, plus a leak check that fails
  if docs, env files, keys or agent files end up in the built artifact.
- Visual and end-to-end tests for critical flows once the project has them.

## Deploys

- Follow the deploy order in `docs/OPERATIONS.md` exactly (for example:
  migrations before code).
- Deploy a known branch or tag. Record what is live.
- **Verify on the live environment after deploy.** A setting committed to the
  repo may do nothing if the server ignores it. Check headers, versions and
  the main flow on the real URL.
- Settings that live outside the repo (proxy timeouts, server modules, cloud
  consoles) are listed in `docs/OPERATIONS.md`.

## Builds others will test

- Build from a committed state. The build number or version changes for every
  build given to testers, so builds can be told apart.
- Environment values baked in at build time are confirmed inside the built
  artifact, not assumed from the local env file.
- Download build artifacts that expire into a local builds folder outside git.

## AI inside CI

Running an AI step inside the pipeline (for example an automated review)
sends code to a third-party service. It is a per-project decision, recorded
as an ADR, with the provider and the data it sees named.
