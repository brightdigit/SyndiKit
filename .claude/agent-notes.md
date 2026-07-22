# Agent Notes — Corrections & Standing Directives

This file is the running log of the maintainer's corrections and standing **always/never**
directives for this repo. It is the source of truth for *how* to work here.

**Read this file at the start of every work session, before doing any work.**

**Append one line per directive, proactively (without being asked), whenever the maintainer makes
a correction or gives an always/never instruction.** Newest lines go at the bottom. Keep each
entry to a single line; if a directive supersedes an earlier one, update or remove the stale line
rather than leaving both.

---

<!-- Append directives below, one per line. Example:
- Always run ./Scripts/lint.sh before committing; never call swiftlint directly.
-->
- Prefer external JSON files under `.github/matrices/` for CI build matrices instead of inlining large JSON in workflow YAML.
