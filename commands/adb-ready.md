---
name: adb-ready
description: "ADB whole-product readiness walk (P61B). Separate walker; stamp in STATUS. Not per slice."
---

# /adb-ready

Canonical method: `ADB.md` in the project root (or `~/Development/_System/Methods/ADB/SKILL.md`).
This command enforces P22, P39, P45, P46, P50, P58, P60, P61 and P61B.

Skill: `/Users/bubby/Development/_System/Rules/skills/product-readiness/SKILL.md`.

## Spawn rules (for the Lead / coordinator)

Spawn this as a **separate agent**. The builder’s session plus the builder’s story is not independent. A lead agent re-reading its own work is not independent (P39, P61B).

Hand exactly:

- pointers to the Source of Truth files that exist
- `adb/07-STATUS.md`
- the issue register (`adb/08-OPEN-ISSUES.md`, or `## Open issues` in STATUS while collapsed)
- project `AGENTS.md` (how to run, live URLs if listed)
- walk + verdict: P61B keys only

Never hand the walker: interview history, the builder’s narrative or rationale, full project history, or any instruction to confirm the builder’s conclusion (P38).

The walker **writes the stamp** (`READINESS`, `READINESS-AT`, `READINESS-BY` and overwrites `## Readiness`). Lead/coordinator must **not** change the key.

**No product-code edits.** Walker does not implement (P39). Discoveries: REGISTER (P46). Mini-fixes: BUILD afterwards, then a **new** walk if needed. Walker must not grade their own repair.

If the environment cannot provide a separate walker, record that limitation in STATUS `REVIEW LIMITATION` as today and run a constrained self-check instead. Do not call that self-check independent. Constrained self-check **must not** return `LIVE`. `READINESS-BY` is then `constrained-self-check` — that field is **not** `REVIEW LIMITATION`.

Do **not** run this at every slice INTEGRATE. Slice VERIFY and `/adb-review` stay unchanged. Not a station on P36.

## Walker instructions

Reload SoT + STATUS + issues (P58). Those files outrank interview chat.

Walk the **current product**, not a slice story. Depth scales (P60); do not skip the gate. User-facing: harness browser, real clicks. High-integrity: relevant calc/permissions. P45/P46. No invented leftover work.

Judge one P61B key:

| Key | Meaning |
|---|---|
| `NICHT_FERTIG` | Core path broken, spec unsatisfied, or P50 blockers. |
| `ALPHA` | Real user can complete the **core** path. Gaps registered. Not for real operations. **Never** P61 completion. Quality bar does **not** choose ALPHA vs BETA; it only chooses **BETA** (real use) vs **LIVE** (production). |
| `BETA` | Agreed scope matches SoT. Important journeys, empty/loading/error, relevant edges proven on a real path (browser if UI). Only MEDIUM/LOW remain if acceptable under P50 (ACCEPT recorded if needed). |
| `LIVE` | BETA + P50 clear + applicable `05-QUALITY` production items. **Does not mean already deployed.** Deploy only when Bubby asks, via the project's documented path. Constrained self-check **must not** return LIVE. |

**ALPHA is never product completion (P61).**

Register real issues in the existing register. Do not duplicate full issue bodies in STATUS if 08 exists. Do not create a new numbered ADB file.

## Stamp (walker writes)

In `adb/07-STATUS.md`:

- Header: `READINESS` (one of the four keys), `READINESS-AT` (when this walk finished), `READINESS-BY` (`independent` or `constrained-self-check`)
- Overwrite `## Readiness` — not a changelog: verdict, what was walked, evidence, issue IDs from this walk

Do not edit product code. Do not change `REVIEW LIMITATION` except to record a missing independent walker, as today.

## Return format

Short. No praise. German keys for Bubby.

```
READINESS: NICHT_FERTIG | ALPHA | BETA | LIVE
READINESS-BY: independent | constrained-self-check
WALKED: what, how, what happened
GAPS: none | ISSUE-IDs registered
STALE-NEXT: when this stamp would go stale (later INTEGRATE / SoT or required behavior this walk covered changes)
```
