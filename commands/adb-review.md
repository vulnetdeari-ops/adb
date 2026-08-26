---
name: adb-review
description: "ADB independent review. Reviewer receives Spec + Diff + Evidence only — never the builder's narrative."
---

# /adb-review

Canonical method: `ADB.md` in the project root (or `~/Development/_System/Methods/ADB/SKILL.md`).
This command enforces P38, P39, P44, P45 and P50.

## Spawn rules (for the Lead)

Spawn this as a **separate agent**. The same model in the same session, given the builder's story, is not independent review. A lead agent re-reading its own work is not independent review (P39).

Hand the reviewer exactly:

- the relevant specification (from the Source of Truth files that exist)
- expected behavior
- the diff
- test evidence
- concrete review criteria

Never hand the reviewer: interview history, the builder's narrative or rationale, full project history, or any instruction to confirm the builder's conclusion (P38).

If the environment cannot provide a separate reviewer, record that limitation in STATUS and run a constrained self-check instead. Do not call that self-check independent review.

Scale the review to risk. Do not invent extra review roles for ceremony.

## Reviewer instructions

You are reviewing against the Source of Truth, the diff and the test evidence. Agent confidence is not evidence. Green tests are not sufficient proof (P45).

Judge only the dimensions that are relevant (P44):

| Dimension | Question |
|---|---|
| PRODUCT | Does the implementation match `02-PRODUCT-SPEC.md`? |
| UX | Is it understandable and efficient? |
| DESIGN | Does the real output match `03-UX-DESIGN.md`? |
| ENGINEERING | Is it correct and maintainable? |
| COMPLEXITY | Did unnecessary code or architecture enter the system? |
| QUALITY | Does it satisfy `05-QUALITY.md`? |
| SECURITY | Are meaningful risks handled? Any secret in the repo or in persistent ADB files? |

When the Source of Truth is collapsed, compare against the surviving files. Collapsed topics still count.

## Divergence rule (P45)

If implementation differs from the Source of Truth, decide explicitly:

- **A** — the implementation is wrong, or
- **B** — product intent intentionally changed.

Never silently choose B. If B, say so and require the Source of Truth to be updated first.

If required behavior is missing: fix it now when it belongs in the current slice, otherwise register it in Open Issues via `/adb-triage`. Do not report the slice as spec-satisfied.

## Issue discovery (P46)

Report problems you notice outside the immediate diff. If you are not sure whether something is wrong, unused, contradictory or still needed, register it — do not skip it in silence and do not invent a product decision.

## Return format

Short. No praise, no restating the diff.

```
VERDICT: PASS / FAIL / PASS WITH ISSUES

FINDINGS
- [SEVERITY] [TYPE] finding — evidence — expected
...

SPEC COMPLIANCE: satisfied / diverges (A or B, per finding)
RELEASE BLOCKERS: none / list
```

Severity: CRITICAL / HIGH / MEDIUM / LOW.
Types: BUG, PRODUCT, UX, DESIGN, ARCHITECTURE, SECURITY, DATA, TEST, PERFORMANCE, ACCESSIBILITY, MIGRATION, SPEC-CONFLICT, TECH-DEBT, INVESTIGATION.

A verdict of PASS is not available while a CRITICAL issue stands, while a HIGH issue violates `05-QUALITY.md`, while required product behavior is broken, or while an unresolved Source-of-Truth conflict remains (P50).

## PASS WITH ISSUES (P36)

When the verdict is **PASS WITH ISSUES**:

1. Register every finding via `/adb-triage` before the Lead integrates.
2. The Lead may integrate only if VERIFY already passed for this slice's scope and **RELEASE BLOCKERS** is `none`, or names only MEDIUM/LOW items explicitly deferred to a named later slice.
3. Treat as **FAIL** (do not integrate) when any condition that forbids PASS (above) applies — return to P36 “When a station fails”.
