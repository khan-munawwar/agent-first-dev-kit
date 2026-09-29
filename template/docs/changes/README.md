# Changes

One folder per change, following Anthropic's AI-native SDLC playbook. The
files are the audit trail: why it was asked for, what was agreed, how it was
built.

```
changes/NNNN-short-name/
  intent.md   the problem, in the requester's words      (written first)
  spec.md     what will be built and how it is checked   (after intent is accepted)
  plan.md     files, order, risks, tests                 (after spec is accepted)
```

## Rules

- Copy `_template/` to a new folder. Numbers are never reused.
- Small fixes do not need a folder. A one-line entry in `STATUS.md` and a
  clear commit message are enough. Use a folder when the change touches more
  than one area, changes behaviour users see, or needs a decision.
- `intent.md` is the requester's words. The agent helps write it, the
  requester corrects it. It does not name a technical solution.
- `spec.md` is not written until the intent is accepted. `plan.md` is not
  written until the spec is accepted. Code does not start until the plan is
  accepted.
- If the intent changes after the spec exists, update both and note it in
  the spec's change log.
- Meeting summaries feed intents. Link the meeting in `intent.md`.
- When the change ships, set `status: done` in `intent.md` and fill the
  "Outcome" section of `spec.md`.

## Status values (in `intent.md` front matter)

`draft` -> `accepted` -> `specified` -> `planned` -> `building` -> `done`
Also: `dropped` (keep the folder, add one line why), `superseded`.
