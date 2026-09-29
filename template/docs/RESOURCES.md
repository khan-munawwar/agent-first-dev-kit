# RESOURCES

Registry of references (how something should look or behave) and external
systems (what is actually available). Read by the resource scout
(`agents/resource-scout.md`) before anything is declared blocked.

Modes:
- `static`: the local copy is the truth.
- `dynamic`: check project docs first; if the answer is not there, re-check
  the live source before declaring anything unavailable.

Entry format:

```
### <name>
- kind: functional reference | backend API | vendor | data contract | design
- location: where it is (path, repo, dashboard name). No secrets.
- docs: link to official docs, or "none"
- mode: static | dynamic
- use_for: what questions this answers
- not_for: what it must not be used for
- authority: who owns it, and which side wins when it disagrees with our docs
```

## References (how it should look and behave)

<!-- SETUP(P1): Old app, prototype, design files, legacy system, spreadsheets. One entry each. -->

## External systems (what is available)

<!-- SETUP(P1): Our own backend, vendor APIs, CRMs, payment, email, AI providers, automation tools. One entry each. -->

## Retracted gaps

Things once reported as missing or broken on the other side that turned out to
be our mistake. Keep them, so the same false report is not made twice.
