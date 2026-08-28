---
name: adb-slice
description: "ADB Phase 2 — BUILD one vertical slice. Closes only after PROVE and RECORD."
---

# /adb-slice

Canonical: `/Users/bubby/Development/_System/Methods/ADB/SKILL.md` (BUILD). Ignore a leftover project `ADB.md`.
Inherit global `AGENTS.md`. If DEFINE was not approved, stop and run `/adb-define`.

1. **Plan** — vertical slices from the Source of Truth. Not “entire backend first”. Parallel only when jobs don’t share files or unfinished deps.
2. **Brief** — goal, path, SoT pointers, scope, proof (AGENTS.md Work, SKILL.md 32). Heavy: plan + done criteria before implementers.
3. **Loop** — SPEC → BUILD → PROVE → RECORD. PROVE fail → do not RECORD as done. Fix-round cap 3, then Bubby (not `CARRIED`).
4. **Close** — RECORD updates SoT + status review (SKILL.md 25, 50A). Then: done / still missing / next.

Accounting or payment: correctness over brevity; no silent schema change.
