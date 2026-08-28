---
name: adb-ready
description: "ADB whole-product readiness walk (P61B). Separate walker; stamp in STATUS. Not per slice."
---

# /adb-ready

Canonical: `/Users/bubby/Development/_System/Methods/ADB/SKILL.md` (61B).
Skill: `/Users/bubby/Development/_System/Rules/skills/product-readiness/SKILL.md`.
Ignore a leftover project `ADB.md`.

Separate walker. Not per slice. No product-code edits. Lead does not change the READINESS key.

**Hand:** SoT pointers, `adb/07-STATUS.md`, issue register, project `AGENTS.md` (URLs). Never the builder’s story.

Walker writes `READINESS` / `READINESS-AT` / `READINESS-BY` and overwrites `## Readiness`. Constrained self-check must not return `LIVE`.

Walk the **current product**, real path (browser if UI). Register issues in the existing register. Do not create a new numbered ADB file.

```
READINESS: NICHT_FERTIG | ALPHA | BETA | LIVE
READINESS-BY: independent | constrained-self-check
WALKED: what, how, what happened
GAPS: none | ISSUE-IDs
STALE-NEXT: later RECORD / SoT this walk covered changes
```
