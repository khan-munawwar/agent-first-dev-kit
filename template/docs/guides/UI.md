# UI: keeping the interface consistent

<!-- Managed by agent-first-dev-kit v0.1.0. Project facts (tokens, components, reference screens, pitfalls) live in docs/UI.md. -->

Agents drift from the existing design because they cannot see it. They invent
a new table style, a new colour, a new header. These rules tell the agent
where to look, and the checks catch it when it drifts anyway.

## Before building

1. Find the reference screen for this kind of page in `docs/UI.md`. Name it in
   the spec. Open its code and follow its structure, spacing and components.
2. List the shared components you will use. If one you need does not exist,
   propose a new **shared** component. Never a one-off.
3. Read "Known UI pitfalls" and "Navigation rules" in `docs/UI.md`.

## While building

- **Tokens only** for colour, spacing, font size, radius and shadow. No raw hex
  values, pixel values or one-off styles in feature code.
- **Tables, forms, modals and headers** always come from the shared
  components. These drift the most.
- Take exact values from the reference code, not from a guess or a screenshot.
- Batch visual changes and check them together. Do not tune UI by many
  trial-and-error rebuilds.
- New colours or components need a yes, and go into the design system, not
  into the screen.

## Fixing visual bugs

- Fix at the shared level (the component or token), not in the one screen
  where it showed up.
- Add a screenshot test for the fixed component or screen.
- Add a line to "Known UI pitfalls" in `docs/UI.md`: symptom, cause, rule.

## After building

- Screenshot the new screen next to its reference screen. The human signs off
  on the look.
- Check narrow and wide widths, and light and dark themes if the app has them.

## Enforcement (set up per project)

- Lint rules that block raw colours and arbitrary values.
- Screenshot tests for shared components and key screens, run in CI.
- Optional: a style page or Storybook that shows every component. It is the
  visual source of truth for humans and agents.
