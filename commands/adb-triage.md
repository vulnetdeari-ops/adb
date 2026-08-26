---
name: adb-triage
description: "ADB issue register and triage. Stable IDs, no fake closure, no pollution."
---

# /adb-triage

Canonical method: `ADB.md` in the project root (or `~/Development/_System/Methods/ADB/SKILL.md`).
This command enforces P23–P25, P46–P50 and P50A.

Issues live in `adb/08-OPEN-ISSUES.md`, or in the Open Issues section of `adb/07-STATUS.md` while the Source of Truth is collapsed. Split to `08-OPEN-ISSUES.md` as soon as the list would clutter status or hide severity (P23).

Do not trust chat memory. If a problem matters and is unresolved, it is written down.

## Register or fix (P46)

**FIX NOW** when it directly affects current scope, is safe, is small, and logically belongs with the current work.

**REGISTER** when it is outside scope, needs separate investigation, depends on other work, needs a user decision, would cause harmful context switching, is a meaningful risk, or when you are not sure whether it is wrong, unused, contradictory or still needed.

Never silently ignore it. If unsure: register. Do not invent a fix. Do not defer to a later chat's memory.

## Do not pollute (P24)

Register concrete problems and risks. Reject: vague ideas, theoretical improvements, speculative features, hypothetical refactors, "maybe useful someday", coding-style preferences without product impact.

Uncertainty is not pollution — a possible bug, unused path, contradiction or missing decision is a concrete risk. A wish for a feature that is not a current problem is pollution.

## Issue format (P25)

Stable IDs, never renumbered: `ISSUE-001`.

```
### ISSUE-00N — TITLE

TYPE:         BUG | PRODUCT | UX | DESIGN | ARCHITECTURE | SECURITY | DATA | TEST |
              PERFORMANCE | ACCESSIBILITY | MIGRATION | SPEC-CONFLICT | TECH-DEBT | INVESTIGATION
SEVERITY:     CRITICAL | HIGH | MEDIUM | LOW
FOUND BY:
CONTEXT:
PROBLEM:
EVIDENCE:
EXPECTED:
STATUS:       OPEN | IN PROGRESS | BLOCKED | READY FOR VERIFY | CLOSED
DEPENDENCIES:
CARRIED:      n          # status reviews survived while OPEN; new issue = 0
RESOLUTION:
VERIFIED BY:
```

## Convergence (P50A)

`CARRIED` is incremented by `/adb-status`, not here. This command respects it.

At `CARRIED: 3` the issue must exit OPEN in that review — FIX, ACCEPT (decision plus a written limitation in `05-QUALITY.md`), or REJECT. There is no fourth carry, and ACCEPT is not available for CRITICAL or for HIGH issues touching data integrity or security.

When triaging, order a `CARRIED: 2` issue above an equally severe fresh one. It is about to force a decision either way.

## Closure loop (P47)

DISCOVER → REGISTER → TRIAGE → SELECT → FIX → TEST → REVIEW → VERIFY → CLOSE

Code changed is not CLOSED. Verification is required, and `VERIFIED BY` must name who or what verified it.

## No fake closure (P49)

Never close by deleting the issue, lowering severity to finish, rewording it, or marking CLOSED without verification. Closed items stay traceable in the file.

## Triage pass (P48)

At natural checkpoints, review the open list and order by:

1. severity
2. product impact
3. security / data risk
4. blockers
5. regression risk
6. dependency order
7. cost of postponing

Do not interrupt every task immediately for every new issue.

## Release gate (P50)

The product is not complete while:

- CRITICAL issues remain
- HIGH issues violate `05-QUALITY.md`
- required product behavior is broken
- unresolved Source-of-Truth conflicts remain

MEDIUM/LOW may remain only inside the documented release quality bar.

## Return format

```
REGISTERED: ISSUE-00N ... (n new)
FIXED NOW:  ISSUE-00N ... (with verification)
TRIAGE ORDER: ISSUE-00N, ISSUE-00M, ...
OPEN: n  |  CRITICAL: n  |  HIGH: n
AT CARRIED 3: none / ISSUE-00N + required exit
RELEASE-BLOCKING: none / list
NEXT: concrete next action
```

Then update the issue counts in `adb/07-STATUS.md` (P22).
