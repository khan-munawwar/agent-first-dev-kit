# Meetings

Meetings are inputs. Specs and decisions are outputs. Agents work from the
outputs and read meetings only to trace where something came from.

```
meetings/
  YYYY-MM-DD-topic.md                 summary (from _template.md)
  transcripts/YYYY-MM-DD-topic.txt    raw text, never edited
```

## Rules

- Every meeting gets a summary. The raw transcript is optional.
- Recordings (audio, video) stay outside git. Write where they are kept.
- Transcripts are local text. Produce them with a local tool, not a hosted
  service, unless the project allows it.
- Each decision in a summary links to the ADR or spec it changed. Each open
  question goes to the spec or intent it belongs to, with an owner.
- Distill, then archive: once a meeting's content is in specs and ADRs, set
  `status: background` and fill `absorbed_into`.
- Private or commercial details (prices, contracts, personal information) do
  not go into the repo. Summarise them as "discussed, see private notes".
