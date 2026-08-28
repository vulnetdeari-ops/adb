---
name: adb-define
description: "ADB Phase 1 — DEFINE. Grill the product, not the user. Build the Source of Truth, then gate into BUILD."
---

# /adb-define

Canonical: `/Users/bubby/Development/_System/Methods/ADB/SKILL.md` (DEFINE). Ignore a leftover project `ADB.md`.
Inherit global `AGENTS.md`. No product implementation in DEFINE.

1. **Mode** — GREENFIELD or BROWNFIELD, one line. Brownfield: inspect first (SKILL.md 2, 51–54).
2. **Don’t ask** what repo, docs, tests or research can answer.
3. **One decision** at a time. A/B/C as in AGENTS.md. Record in the Source of Truth (SKILL.md 15–23). Default collapsed: `adb/01-VISION.md`, `02-PRODUCT-SPEC.md`, `07-STATUS.md`.
4. **Uncertainty** — KNOWN / UNKNOWN / ASSUMED / CONFLICTING / NEEDS RESEARCH / NEEDS USER DECISION. Never silently turn an assumption into product truth.
5. **Gate** — (1) Could a fresh team build from these files without inventing important behavior? (2) Does leftover uncertainty block the first slice? If yes, only that blockage. Don’t fill unused files.
6. **Once:** DEFINE fertig — BUILD starten? `A) BUILD starten` `B) Noch offene Punkte` `C) Entscheide du`. No BUILD on silence. Don’t restart DEFINE as a whole.

Forbidden: extra files, agents or reviews to tick a point; secrets in git or `adb/` files.
