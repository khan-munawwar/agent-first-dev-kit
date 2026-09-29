# MOBILE-RELEASE: building, testing and shipping mobile apps

<!-- Optional guide from agent-first-dev-kit v0.1.0. Copy into docs/guides/ when the project ships a mobile app, and add it to docs/README.md. -->

## Roles

Record the project's answers in `docs/OPERATIONS.md` (who builds, which build
method is settled, who uploads and submits to each store, who holds each
account and signing identity). When copying this guide, add a matching
`<!-- SETUP(P2): ... -->` line to `docs/OPERATIONS.md` so setup asks for them.

Defaults:
- The agent may build with the settled method without asking again.
- The human chooses the upload or submit path for each release, and submits.
- Builds run from committed code.

## Native folders are generated

- Generated native project folders are disposable. Never edit them by hand;
  the next regenerate wipes the edit.
- Native fixes live in committed config or plugins, scoped by platform and
  architecture, so other machines and cloud builds get them too.
- No backup copies of the app or native folders inside the repo.

## Versions

- Bump the version or build number for every build given to testers.
- Record toolchain versions (SDK, build tools, CLI) in `docs/ENVIRONMENTS.md`.
- After a toolchain update, do a clean build before trusting results.

## Environment

- API URLs and flags are baked in at bundle time. Document each build profile
  and where its values come from (local env, cloud secrets).
- Switching environment needs a cache clear. Write the exact command.
- Confirm the value inside the built artifact before handing it out.
- Release-only config: list the keys that dev builds inject automatically but
  release builds need explicitly.

## Signing and accounts

- Record who holds which identity: build service token, store account, store
  API key. Values stay in the secret store.
- Certificates and keys are additive: never revoke without a plan. Note expiry
  dates. Keep backups of upload keys.
- The store account holder must accept yearly agreements. An unsigned
  agreement can make uploads fail with no clear error.

## Testing

- Test release builds with dev flags off, on a fresh install.
- Record device and simulator IDs; select devices by ID, not name.
- Real orders, payments and messages from a test build need a yes, and a list
  of what to cancel afterwards.
- If the install tool fails but the build succeeded, use the documented
  fallback.

## When a release fails

Check in this order: account or agreement banners in the store console, the
build or store service status page, the full build log, then a manual upload
as a fallback.

## Store listing

Decide early whether the app replaces an existing store listing (same app
IDs) or is a new listing. Force-update and minimum-version checks depend on
it.
