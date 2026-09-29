# CONVENTIONS

Project coding rules that are always true. Generic defaults live in the kit
guides (`guides/ENGINEERING.md`, `guides/TESTING.md`, `guides/UI.md`). This
file adds or overrides for this project. When overriding a guide, say
"overrides guides/X.md" so the conflict is explicit.

Point-in-time decisions go in `adr/`, not here.

## Language and framework

<!-- SETUP(P1): Versions, strictness settings, formatter and linter, naming rules. -->

## One method per concern

<!-- SETUP(P2): The single established way to do each common thing. Adding a second way needs a yes. Rows of the kind: data fetching -> X; navigation -> Y; styling -> Z; forms -> W; state -> V; dates and money -> U. -->

## Data and database

<!-- SETUP(P2): Migration tool and folder, key and foreign-key types, enum handling, naming, time zones, money type, soft or hard deletes. Where the schema source of truth is. -->

## API

<!-- SETUP(P2): Request validation, error shape, auth and owner checks on every endpoint, ID format in URLs, pagination. -->

## Errors and logging

<!-- SETUP(P2): Where logs go, log format, what users see on errors. Defaults are in guides/ENGINEERING.md. -->

## Internationalisation

<!-- SETUP(P3): Supported languages, where strings live, the rule for adding a string. Write "single language" if not needed. -->

## Tests

<!-- SETUP(P1): Test framework, where tests live, how to run one test and the full suite, what must be tested. -->
