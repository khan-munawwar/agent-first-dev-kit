# UI

This project's design system facts. The generic rules are in
`guides/UI.md`. Read both before any UI work.

## Design tokens

<!-- SETUP(P2): Path of the theme or token file. Token names for colours, spacing, font sizes, radius, shadows. Raw values in feature code are not allowed. -->

## Shared components

| Need | Use | Path |
|---|---|---|
<!-- SETUP(P2): One row per common pattern: table, form, modal, button, header, list, empty state, toast. If a pattern has no shared component yet, write "none yet" so the agent proposes one instead of styling by hand. -->

## Reference screens

| Pattern | Match this screen |
|---|---|
<!-- SETUP(P2): The best existing screen for each kind: list page, detail page, form, settings, dashboard. New screens follow their reference. -->

## Navigation rules

<!-- SETUP(P2): How navigation works and what must never happen (for example: back never skips to home, background screens never show alerts). -->

## Known UI pitfalls

Bugs that came back. Each line: the symptom, the cause, the rule that
prevents it. The pre-commit reviewer checks every line.

## Style page

<!-- SETUP(P3): Is there a page or Storybook that shows every component? Path or URL. Write "none" if not. -->

## Visual tests

<!-- SETUP(P3): Which screens and components have screenshot tests, and the command to run them. -->
