---
name: adb-status
description: "Rewrite ADB STATUS and judge the work against the Completion Standard. Optional slice retrospective."
---

# /adb-status

Canonical method: `ADB.md` in the project root (or `~/Development/_System/Methods/ADB/SKILL.md`).
This command enforces P1A, P22, P45, P50A, P55, P56, P58, P61 and P61A.

## Step 1 — Reload truth, not chat (P58)

Read the Source of Truth files that exist plus `AGENTS.md`. Those files outrank interview chat. Do not reconstruct status from conversation memory.

## Step 2 — Rewrite `adb/07-STATUS.md` (P22)

Keep it concise. Overwrite the header fields below, do not append a changelog.

**If the Source of Truth is collapsed and issues live in this file, preserve the entire `## Open issues` section verbatim** — every issue body, ID and field. Updating the header counts must not delete register content (P49).

```
# STATUS

PHASE:              DEFINE | BUILD
COMPLETED:
CURRENT:
REMAINING:
BLOCKERS:
NEXT IMPORTANT ACTION:
OPEN ISSUES:        n
CRITICAL / HIGH:    n / n
AT CARRIED 3:       none | ISSUE-00N (required exit)
REVIEW LIMITATION:  none | no independent reviewer available in this environment

## Open issues

(omit this section when issues live in adb/08-OPEN-ISSUES.md instead)
```

Record the review limitation here when the environment cannot provide a separate reviewer (P39).

## Step 2A — Layout and version check (P1A, P15, P23)

Cheap, and it catches the class of defect that hides everything else.

- `ADB.md` carries a `METHOD-VERSION` stamp as its first line, or as the first line after the frontmatter block when the copy keeps one. Never above frontmatter. Missing or older than the canonical repo → say so; refresh only outside an active slice.
- The numbered files that exist are the ADB ones. No ADB topic lives under an invented filename.
- No topic exists twice — not in a numbered file and an ad-hoc file, not in STATUS and a separate register.
- The issue register is `adb/08-OPEN-ISSUES.md`, or the STATUS section while the Source of Truth is genuinely collapsed. Not both.

A duplicated topic is a spec conflict. Register it.

## Step 3 — Drift check (P55, P56)

Many small changes destroy coherence. Check the current code against Vision, Product Spec, Business Rules, UX, Design, Architecture, Quality and important Decisions.

If a later change altered the product, classify it and update the affected Source of Truth **before** the work counts as complete:

A — implementation fix · B — compatible extension · C — product spec change · D — UX/design change · E — architecture change · F — vision change (explain the conflict before implementing).

Never let accidental implementation become new product truth. Never leave the spec describing an older product than the code.

## Step 3A — Convergence (P50A)

Increment `CARRIED` on every issue still OPEN. This review counts. Do **not** increment issues in **WAITING ON USER** (P50A).

Any issue reaching `CARRIED: 3` must leave OPEN in this same review — unless the required exit needs the user: then set **WAITING ON USER**, freeze CARRIED, and name the decision as NEXT IMPORTANT ACTION. FIX, ACCEPT (decision in `06-DECISIONS.md` or STATUS when collapsed; limitation in `05-QUALITY.md` or STATUS when collapsed), or REJECT with a reason. No fourth carry.

ACCEPT is forbidden for CRITICAL, and for HIGH issues that violate a data-integrity or security requirement.

If the exit needs the user, set WAITING ON USER and make that decision the single NEXT IMPORTANT ACTION. Do not increment CARRIED while waiting. A status question from the user still triggers a review of everything else (P25).

## Step 4 — Completion standard (P61)

Code existing, compiling, demoing or passing unit tests is not completion. Judge each relevant item and mark it yes / no / not applicable:

- intended behavior exists
- important edge cases work
- UX is polished
- design is coherent
- specification is satisfied
- relevant tests pass
- independent review passed, where required and actually independent
- open issues appropriately resolved
- unnecessary complexity removed
- no release-blocking issue remains

Any "no" means not complete. Name the concrete next work rather than a note for later.

## Step 5 — Retrospective (optional, scale per P60)

Run after a group of related slices, or when the session repeated mistakes. Skip it on small low-risk products — running it for ceremony is forbidden.

Answer in three lines, then act:

1. What did the Source of Truth fail to say, that a worker had to guess? → fix that file now.
2. Which brief had to be re-sent or corrected? → what was missing from the P32A checklist?
3. Which issue was found late that an earlier gate should have caught? → tighten that gate or record it in DECISIONS.
4. Was any finding caused by the method rather than the project? → append it to `LESSONS.md` in the canonical ADB repository (P61A) and still fix the project.

The method test for question 4: ADB was silent where a rule was needed, two parts of ADB or `AGENTS.md` disagreed, ADB demanded work P60 or the anti-ceremony rule should have prevented, or following ADB produced the defect. Anything else is a project issue, not a lesson.

If the session is long or repeating errors, start a fresh session loading only the Source of Truth plus `AGENTS.md` (P58).

## Return format

Short summary to the user: phase, what closed, what blocks, next action, issue counts. Name any forced convergence exit and any lesson written. No ceremony.
