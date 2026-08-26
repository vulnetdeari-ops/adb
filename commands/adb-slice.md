---
name: adb-slice
description: "ADB Phase 2 — BUILD one vertical slice. Orchestra writes the brief, workers do the heavy work, slice closes only after VERIFY and INTEGRATE."
---

# /adb-slice

Canonical method: `ADB.md` in the project root (or `~/Development/_System/Methods/ADB/SKILL.md`).
This command enforces P28–P38, P40–P43 and P60. Read the referenced points there; do not restate them here.

Inherit the project's `AGENTS.md`.

## Preconditions

DEFINE is complete and the user approved BUILD (P27). If not, stop and run `/adb-define`.
Reload from the Source of Truth files that exist. Those files outrank interview chat (P58).

## Step 1 — Execution plan (P34, P35)

Never build a large application as one uninterrupted task.

Derive a dependency-aware plan from the Source of Truth. Organize work into small vertical slices that deliver user-visible capability plus the necessary backend, data and tests. Do not plan enormous horizontal phases such as "build entire backend first".

State the slice graph: which slices are independent (parallel) and which wait for prerequisites. Maximize safe parallelism without integration chaos (P33).

Do not parallelize work that would modify the same code, make conflicting architectural decisions, depend on unfinished work, or create integration churn.

## Step 2 — Orchestra checklist before delegating (P32, P32A)

You are the orchestra. Ask/Decide and the Source of Truth stay in this thread; heavy BUILD work goes to workers. Workers start fresh and see only the brief.

Complete silently before every delegated task — if any item is unknown and material, Ask/Decide with the user first. Never send a vague brief.

1. **Goal** — what done looks like, 1–2 sentences.
2. **Workspace / path** — exact project directory or workspace.
3. **Source of Truth pointers** — which `adb/` files or sections apply, or "none / brownfield inspect first".
4. **Scope** — in scope / out of scope, plus an explicit "do not" list when needed.
5. **Constraints** — secrets rules, no drive-by refactors, financial/safety limits.
6. **Proof** — commands, tests, screenshots, git status the worker must produce.
7. **Return format** — short; you summarize for the user.
8. **Review** — is an independent reviewer required before merge? If yes, spawn separately with diff + spec only (`/adb-review`).
9. **Continuity** — new worker, or follow-up to an existing worker id/session.

Stay in this thread only for: short clarification, tiny one-file edits, Decide questions, status summaries, and work where delegation costs more than it saves.

Agent count follows the work. No agents for ceremony or fake roles.

## Step 3 — Subagent context (P38)

Give each worker the minimum sufficient context: relevant Product Spec, relevant UX, relevant Architecture, task objective, related code. Never send the whole project history.

## Step 4 — Slice loop

Run every meaningful slice through (P36):

SPEC → PLAN → IMPLEMENT → TEST → REVIEW → SPEC CHECK → ISSUE TRIAGE → VERIFY → INTEGRATE

**Scaling (P46, P60):** when the Source of Truth is collapsed and the slice is low-risk, reduce to SPEC → IMPLEMENT → TEST → VERIFY. Running the full nine stations on a small product is exactly the ceremony ADB forbids. State which variant you are using and why.

Use small verifiable tasks, each with clear objective, relevant specification, expected behavior, bounded scope and verification method. Do not accumulate large quantities of unreviewed code (P37).

## Step 5 — Implementation discipline (P30, P31, P40, P41, P42)

Before adding meaningful complexity: real requirement? meaningful quality/reliability/maintainability gain? simpler solution? existing capability? flexibility actually required? abstraction necessary now? fewer moving parts possible?

Smallest safe change that fully solves the requirement. No unrelated refactors, no renames of unrelated structures, no rewrites for style, no unused config or dependencies, no helpers for hypothetical future use. Remove dead code when safe.

No speculative features, architecture, abstractions or future-proofing.

## Step 6 — Test what matters (P43)

Prioritize Business Rules, calculations, state transitions, critical workflows, permissions, integration boundaries, regressions, high-risk edge cases. E2E for important journeys. Do not inflate test volume for coverage.

## Step 7 — Close the slice (P28, P45, P61)

Green tests are not enough. Run SPEC CHECK against the Source of Truth. Missing required behavior is fixed now if it belongs in this slice, otherwise registered via `/adb-triage` — never continued past as if satisfied.

Then report:

- what is done
- what still stands between this and a finished product
- the concrete next work

Do not end BUILD by leaving specified remaining work as a note with no next move. Keep leading until the completion standard is met or the user pauses.

## High-integrity work (P54)

For accounting, financial or payment code: verify calculations, taxes, rounding, totals, transaction integrity, duplicate prevention, permissions, auditability, migration accuracy, backups, recovery. Compare old and new results against controlled or historical data. Never silently change a persisted data model or schema — that needs an explicit migration spec and user awareness.
