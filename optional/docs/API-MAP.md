# API-MAP

<!-- Optional file from agent-first-dev-kit v0.1.0. Use when the app calls several backends or is migrating between them. -->

Every external call the app makes, which backend serves it, and its state.
During a migration this is the scoreboard.

States: planned, wired (code calls it), endpoint-verified (the call works on
its own), verified (works in the real flow with fallbacks off).

| Feature | Call | Backend | State | Notes |
|---|---|---|---|---|
