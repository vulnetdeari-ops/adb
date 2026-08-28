---
name: adb-review
description: "ADB independent review. Plan: spec + plan + done criteria. Code: spec + diff + evidence. Never the builder's narrative."
---

# /adb-review

Canonical: `/Users/bubby/Development/_System/Methods/ADB/SKILL.md`. Ignore a leftover project `ADB.md`.

Spawn a **separate** agent. Same session + builder’s story ≠ independent. Reviewer never implements. If none: STATUS limitation; constrained self-check; don’t call it independent.

**Hand:** plan review → spec + plan + done criteria. Code review → spec + diff + evidence. Never interview history, builder narrative, or “confirm the builder”.

**Plan (heavy, before implementers):** decision-complete? Can a worker execute without inventing scope? Done criteria concrete? Invents work the spec does not require?

**Code:** vs SoT (SKILL.md 40–44). Green tests ≠ spec. Divergence: A implementation wrong, or B spec changed (update SoT first).

```
VERDICT: PASS / FAIL / PASS WITH ISSUES
FINDINGS
- [SEVERITY] [TYPE] finding — evidence — expected
SPEC COMPLIANCE: satisfied / diverges (A or B)
RELEASE BLOCKERS: none / list
```

PASS WITH ISSUES: register via `/adb-triage`. RECORD only if PROVE passed and SKILL.md 50 allows.
