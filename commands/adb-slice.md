---
name: adb-slice
description: "ADB Phase 2 — BUILD one vertical slice. Closes only after PROVE and RECORD."
---

# /adb-slice

Canonical method: `ADB.md` in the project root (or `~/Development/_System/Methods/ADB/SKILL.md`).
This command enforces P28–P38, P40–P43 and P60. Read the referenced points there; do not restate them here.

Inherit global `AGENTS.md` (talk, proof, workers, git).

## Preconditions

DEFINE is complete and the user approved BUILD (P27). If not, stop and run `/adb-define`.
Reload from the Source of Truth files that exist. Those files outrank interview chat (P58).

## Step 1 — Execution plan (P34, P35)

Never build a large application as one uninterrupted task.

Derive a dependency-aware plan from the Source of Truth. Organize work into small vertical slices that deliver user-visible capability plus the necessary backend, data and tests. Do not plan “build entire backend first”.

Independent slices may run in parallel; dependents wait (P33). Do not parallelize work that would modify the same code or depend on unfinished work.

## Step 2 — Brief before sending work (P32, P32A)

Ask/Decide and the Source of Truth stay in the user-facing thread. Heavy BUILD goes to a **visible** worker. Workers start fresh and see only the brief. See global `AGENTS.md` → Work (default one worker; written plan only when **heavy**).

Complete silently before every delegated task — if any item is unknown and material, Ask/Decide first. Never send a vague brief.

1. **Goal** — what done looks like, 1–2 sentences.
2. **Workspace / path**
3. **Source of Truth pointers** — or "none / brownfield inspect first".
4. **Scope** — in / out, plus "do not" when needed.
5. **Constraints** — secrets, no drive-by refactors, financial/safety limits.
6. **Proof** — commands, tests, real path.
7. **Return format** — short; summarize for Bubby.
8. **Review** — P39: independent reviewer if heavy? If yes, spec + plan or spec + diff only (`/adb-review`).
9. **Continuity** — new worker vs follow-up.
10. **Heavy only** — do not spawn implementers until Bubby or Reviewer has passed on **plan + done criteria + relevant spec**. One plan revision, then Bubby.

Stay in this thread only for: short clarification, tiny one-line fixes, Decide questions, status, and work where a second agent costs more than it saves.

## Step 3 — Worker context (P38)

Minimum sufficient context: relevant spec, task, related code. For **heavy** work also the plan and done criteria. Never the whole project history or the builder’s story.

## Step 4 — Slice loop (P36)

**SPEC → BUILD → PROVE → RECORD**

**If PROVE fails:** do not RECORD as done. Fix in-slice or register (P46). **Review-round cap: 3**, then ask Bubby — this is **not** `CARRIED`.

Use small verifiable tasks (P37). Do not pile unproven code.

## Step 5 — Implementation (P30, P31, P40, P41, P42)

Smallest safe change that fully solves it. No unrelated refactors. Remove dead code when safe.

## Step 6 — Test what matters (P43)

Business rules, calculations, states, permissions, regressions, high-risk edges. Not coverage theater.

## Step 7 — Close the slice (P28, P45, P61)

PROVE against the Source of Truth. Missing required behavior: fix now if it belongs in this slice, otherwise register via `/adb-triage`.

**RECORD includes the status review (P25):** read the register, increment `CARRIED` on still-OPEN except WAITING ON USER, apply P50A. Run `/adb-status` or do the same work here — do not close the slice without it.

Then report: what is done, what still stands between this and a finished product, the concrete next work.

## High-integrity work (P54)

Accounting, financial or payment: verify calculations, permissions, no silent schema change.
