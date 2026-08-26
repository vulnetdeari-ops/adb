---
name: adb-define
description: "ADB Phase 1 — DEFINE. Grill the product, not the user. Build the Source of Truth, then gate into BUILD."
---

# /adb-define

Canonical method: `ADB.md` in the project root (or `~/Development/_System/Methods/ADB/SKILL.md`).
This command enforces P2, P4–P14 and P26. Read the referenced points there; do not restate them here.

Inherit the project's `AGENTS.md`: Offensive on Outcome, Defensive on Implementation.

## Preconditions

1. `METHOD.md` contains `METHOD: ADB`, or the user explicitly invoked ADB. If neither, stop and ask (P1).
2. Do not begin substantial implementation during DEFINE (P4).

## Step 1 — Project mode (P2)

Declare GREENFIELD or BROWNFIELD in one line.

If BROWNFIELD, inspect before changing anything and answer: what exists / works / is incomplete / is incorrect / is unclear / should be preserved / what the user intends it to become. Existing code is evidence, not truth (P2, P51).

## Step 2 — Discover before asking (P7)

Never ask what repository inspection, docs, config, tests, existing data, official documentation, platform conventions or research can answer reliably. Investigate that first.

Ask the user only where intent matters: desired behavior, Business Rules, priorities, workflow, product preference, meaningful UX decisions, important trade-offs, irreversible decisions.

## Step 3 — Parallel research (P8, P9)

When independent research questions exist, delegate them to subagents or parallel workers. Research does not belong in this thread when it can run elsewhere. Parallelize only genuinely independent work. Integrate results yourself.

## Step 4 — Ask loop (P5, P6, P10, P11, P12)

One meaningful decision at a time:

QUESTION → ANSWER → INSPECT → RESEARCH IF USEFUL → UPDATE UNDERSTANDING → UPDATE SOURCE OF TRUTH → NEXT BEST QUESTION

Every important question ships 2–4 serious options in this format:

```
Decision

A — Option
Short explanation.

B — Option
Short explanation.

RECOMMENDATION: B

WHY:
Short contextual reasoning.

ANSWER: A / B / Other / Decide for me
```

No fake alternatives. No questionnaires unless the user asks for batch questions. No manufactured questions to look thorough. `Decide for me` is valid — then decide on Vision, prior answers, research, simplicity, usability, quality, maintainability, risk and lowest justified complexity, and record it in DECISIONS (P11).

Challenge choices that cause poor usability, avoidable complexity, security problems, data-integrity risk, architectural damage or inconsistency: concern → consequence → recommended alternative (P12). Not on subjective preferences.

## Step 5 — Uncertainty states (P14)

Every material fact is KNOWN / UNKNOWN / ASSUMED / CONFLICTING / NEEDS RESEARCH / NEEDS USER DECISION.
Never silently convert an assumption into product truth.

## Step 6 — Source of Truth (P15–P23, P59, P60)

Default to the collapsed set: `adb/01-VISION.md`, `adb/02-PRODUCT-SPEC.md`, `adb/07-STATUS.md`.
Split a topic into its numbered file only when keeping it merged would hide important truth.
Keep the numbered filenames. Never invent `SPEC.md`. Never create a file to complete the set of eight.

## Step 7 — Completeness gate (P26)

Answer both, explicitly:

1. Could a fresh capable engineering team build this from these files without the interview history and without inventing important product decisions?
2. Does any remaining UNKNOWN / CONFLICTING / NEEDS USER DECISION block the first vertical slice?

If the first slice is blocked, continue DEFINE for that blockage only. Otherwise DEFINE is done.
Do not continue to exhaust research, fill unused files, or resolve reversible details. Record remaining non-blocking uncertainty as ASSUMED, NEEDS RESEARCH, or in Open Issues.

## Step 8 — Approval (P27)

Summarize briefly: product, core principles, major workflows, UX/design direction, architecture direction, significant risks.

Then ask exactly once:

**ADB DEFINE is complete. Start BUILD?**

## Forbidden

- Extra files, agents, slices or reviews to show a point was visited (P46).
- Large-project machinery on a small product (P60).
- Secrets in the repository or in persistent ADB files (P-secrets).
