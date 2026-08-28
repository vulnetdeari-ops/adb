---
name: adb-slice
description: "ADB BUILD one slice. Closes only after PROVE and RECORD."
---

# /adb-slice

Canonical: `/Users/bubby/Development/_System/Methods/ADB/SKILL.md` (BUILD). Ignore a leftover project `ADB.md`.
Inherit global `AGENTS.md`. If DEFINE was not approved, stop and run `/adb-define`.

1. **Plan** — user-visible slices from `adb/`. Not “entire backend first”. Parallel only when jobs don’t share files or unfinished deps.
2. **Brief** — goal, path, `adb/` pointers, scope, proof (AGENTS.md Work). Heavy: plan + done criteria before implementers.
3. **Loop** — SPEC → BUILD → PROVE → RECORD. PROVE fail → do not RECORD as done. Fix-round cap 3, then Bubby (not `CARRIED`).
4. **Close** — RECORD updates `adb/` + status review (SKILL.md Issues / CARRIED). If SPEC points are met: this slice is done; do not invent a next slice. Next only if already in `## Execution plan` or Bubby asks. If the plan is not met: what’s left in the plan.

Accounting or payment: correctness over brevity; no silent schema change.
