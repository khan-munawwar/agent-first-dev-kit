# DEBUGGING: evidence before conclusions

<!-- Managed by agent-first-dev-kit v0.1.0. -->

Most wasted time with coding agents comes from confident guesses. These rules
keep claims tied to evidence.

## Claims need receipts

- Every claim says how it is known: tested, documented, or assumed.
- Cite the receipt: a log line, a test output, a network capture, a doc link,
  a line of code.
- Offer the check that would fail if the claim were wrong.
- "I did not find it" is not "it does not exist". Say which one it is.

## When you cannot see the problem

For bugs on another person's device, in production, or in a build you cannot
run:
- After **two** failed hypotheses, stop. Say plainly that you are guessing.
- Propose one way to get ground truth: a build with error reporting, the real
  log, a screenshot, a recording, a debug flag.
- A fix for a side issue is not a fix for the symptom. Say which one it is.

## Find the real log first

Know where the application's own log is (`docs/OPERATIONS.md`). The web
server log, the build log and the app log are different things.

## External systems (vendors, APIs, clients)

- Compare before blocking: use the resource scout (`docs/agents/resource-scout.md`).
- Before reporting a bug on the other side: re-read the current docs, check
  your own parameters, and make your probe print exactly what it sent.
- A vendor's statement ("it is fixed", "it works like this") is a hypothesis
  until you see it on the wire.
- Keep false reports in `docs/RESOURCES.md` "Retracted gaps".

## Reproduce from a known state

- Build from a committed state, so the only difference between two builds is
  the git state.
- After a toolchain or dependency upgrade, do a clean build before trusting
  results.
- Clear caches that hold config (bundler caches, build caches) when switching
  environments.

## Pausing a hard problem

If a problem is paused, write a handoff before the session ends (optional
template in the kit: `docs/handoffs/_template.md`): what is verified, what is
not, open hypotheses, and the next step to get ground truth.
