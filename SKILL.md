---
name: adb
description: "Ask. Decide. Build. Product method. Activates when METHOD.md says METHOD: ADB, the user invokes /adb, or a new app is being defined with ADB. Talk, proof, secrets, git, and workers: global AGENTS.md."
---

# ADB

Ask. Decide. Build. Canonical: this file. Do not copy it into the project.

**Job:** a product that holds in real life. Bubby is not the tester. You ask until the product is clear, write that down, then build and prove. Not a fake company. Not a second rulebook — inherit `/Users/bubby/Development/_System/Rules/AGENTS.md` for talk, proof, secrets, git, and how work is sent.

**Follow this first**

* DEFINE until a fresh agent can build from the files without inventing behavior; then ask once to start BUILD.
* BUILD in slices: **SPEC → BUILD → PROVE → RECORD**. `agy-review` at project commit (AGENTS.md). Review-round cap: 3, then Bubby. That cap is not `CARRIED`.
* Workers: AGENTS.md (default one visible worker; written plan only when **heavy**: money, login/security, live, data migration, new public contract).

Each point judges the product. If it does not apply, extra work is forbidden. No ceremony to tick points.

⸻

## 1. ACTIVATION

Slash commands live **in the project**, never in the user home.

Activates when: `METHOD.md` contains `METHOD: ADB`; user invokes `/adb`; or a new product is clearly wanted. Existing apps: only when asked. This file is the method. Product truth is the project’s `adb/` files. Do not load a second product method.

## 1A. NO PROJECT COPY

Do not copy this file into the project. `METHOD.md` with `METHOD: ADB` is the switch. Helpers install `METHOD.md` and slash commands: `setup-into-project.sh`, `new-project … adb`, `adopt-project`. Canonical repo: `~/Development/_System/Methods/ADB`. Lessons: `LESSONS.md` (P61A). A leftover project `ADB.md` is not the method — ignore it.

## 2. PROJECT MODE

**GREENFIELD** — no app yet → DEFINE. **BROWNFIELD** — inspect first: what exists / works / is wrong / unclear / keep / what Bubby wants. Existing code is evidence, not automatically truth.

## 3. TWO PHASES

**DEFINE** — persist the Source of Truth. **BUILD** — execute it. No extra layer on top.

# PHASE 1 — DEFINE

## 4. DEFINE OBJECTIVE

No substantial product implementation in DEFINE. Done when a fresh agent can build from the files without inventing important behavior, and leftover uncertainty does not block the first slice. More research possible ≠ keep DEFINE open.

## 5–7. ASK THE PRODUCT, NOT BUBBY

Ask only what changes important behavior. One decision at a time. Never ask what repo, docs, tests, or research can answer. Ask Bubby for intent, priorities, and trade-offs. A/B/C: AGENTS.md (only when the prompt can mean two things).

## 8–9. RESEARCH

Research when it improves the next decision. Independent questions → visible workers (AGENTS.md). Lead integrates.

## 10–12. DECISIONS

Important questions: 2–4 real options, last = Entscheide du. Record autonomous decisions in `06-DECISIONS.md` or the decisions section of `02` while collapsed. Challenge choices that hurt usability, safety, or coherence — not taste.

## 13. UX

If Bubby knows WHAT but not HOW it should look: you own a coherent, usable direction. No generic AI look.

## 14. UNCERTAINTY

KNOWN / UNKNOWN / ASSUMED / CONFLICTING / NEEDS RESEARCH / NEEDS USER DECISION. Never silently turn an assumption into product truth.

## 15–23. SOURCE OF TRUTH

Maximum set (not a fill-all list):

`adb/01-VISION.md` `02-PRODUCT-SPEC.md` `03-UX-DESIGN.md` `04-ARCHITECTURE.md` `05-QUALITY.md` `06-DECISIONS.md` `07-STATUS.md` `08-OPEN-ISSUES.md`

Small products collapse to Vision + Spec + Status. Other topics live in 02 until they need a file. Issues live in 07 until the list needs 08. Setup does **not** create 08. Keep numbered names. No extra permanent docs without a concrete need.

- **01** — what it is, who, why, what it is not.
- **02** — behavior: features, rules, states, data, errors, examples.
- **03** — journeys, screens, states, hierarchy, empty/loading/error.
- **04** — stack, boundaries, data, deploy, security — only what matters, with WHY.
- **05** — what DONE means for this product.
- **06** — important WHY, not trivia.
- **07** — STATUS header: PHASE, COMPLETED, CURRENT, REMAINING, BLOCKERS, NEXT IMPORTANT ACTION, OPEN ISSUES, CRITICAL/HIGH, AT CARRIED 3, REVIEW LIMITATION, READINESS, READINESS-AT, READINESS-BY. Multi-slice BUILD: `## Execution plan`. Preserve `## Readiness` on rewrite — the walker writes the stamp (P61B).
- **08** — unresolved real problems, or `## Open issues` in 07 while collapsed.

## 24–25. ISSUES

Do not file wishes. Format: stable `ISSUE-00N`; TITLE, TYPE, SEVERITY, FOUND BY, CONTEXT, PROBLEM, EVIDENCE, EXPECTED, STATUS, DEPENDENCIES, CARRIED, RESOLUTION, VERIFIED BY.

Statuses: OPEN; IN PROGRESS; BLOCKED (still OPEN for CARRIED); WAITING ON USER; READY FOR VERIFY; CLOSED.

**CARRIED:** how many **status reviews** the issue survived while OPEN. New = 0. Each status review increments still-OPEN except WAITING ON USER. A status review is: slice RECORD (P36), before release, or when Bubby asks status. CARRIED is not the agy round cap.

## 26–27. LEAVE DEFINE

Fresh team could build without the interview? Nothing UNKNOWN/CONFLICTING/NEEDS USER DECISION blocking the first slice? Then ask **once**: start BUILD / still open points / Entscheide du. No BUILD on silence. Do not restart DEFINE as a whole.

# PHASE 2 — BUILD

## 28. BUILD

Stop interviewing. SoT governs. After each slice: done / still missing / next move. Do not park promised work as a note with no next move.

## 29–31. QUALITY OF BUILD

Holds in real life: AGENTS.md. Simple code: AGENTS.md. Before extra complexity: is it required now?

## 32–32A. WORKERS

AGENTS.md is authoritative (right workspace, visible, default one worker, heavy = plan first).

Lead: Ask/Decide + SoT in the user thread. Brief: what, where, done (+ SoT pointers, proof). Workers start fresh from the brief. Titles follow the work. No fake roles.

Silent checklist before sending work: goal, path, SoT pointers, scope, constraints, proof, return short. Heavy: plan + done criteria; Bubby or Reviewer sees the plan before implementers (P38). No vague briefs.

## 33–35. SLICES

Parallel only when jobs don’t share files or unfinished deps. Large app: persist `## Execution plan` in 07 — user-visible slices, not “entire backend first”.

## 36. SLICE LOOP

Every meaningful slice:

**SPEC → BUILD → PROVE → RECORD**

- **SPEC** — what this slice must do, from the SoT. Heavy work: written plan + done criteria here (AGENTS.md).
- **BUILD** — implement the spec. Test what matters (P43).
- **PROVE** — vs SoT (P45) and a real path (AGENTS.md). UI: harness browser. Not “it compiles.”
- **RECORD** — update SoT + STATUS; status review (P25): increment CARRIED, apply P50A. Commit only if Bubby asked, after `agy-review`.

If PROVE fails: do not RECORD as done. Fix in-slice or register (P46) and narrow to what was proven. Cap 3 fix rounds, then Bubby.

PASS WITH ISSUES (`/adb-review`): register findings; RECORD only if PROVE passed and P50 allows.

Old names (SPEC CHECK / VERIFY / INTEGRATE / ISSUE TRIAGE) mean PROVE + RECORD. Slash commands must use this loop, not invent a longer one.

## 37–38. CONTEXT

Small verifiable tasks. Worker: relevant spec + code (+ plan when heavy). Reviewer: spec + plan + done criteria, or spec + diff + evidence — never the builder’s story.

## 39. INDEPENDENT REVIEW

Required for **heavy** work (money, login/security, live, data) — plan before build; code review vs spec+diff when the slice is heavy. Same session + builder’s story ≠ independent. If none: STATUS limitation; don’t call it independent. `agy-review` is the commit check and does not replace this where heavy work requires it.

## 40–44. CODE AND TESTS

Smallest safe change. Delete dead code when safe. Mature deps for hard problems, not trivia. Test business rules, money, permissions, edges — not coverage theater. Review vs SoT, UX, safety, extra complexity.

## 45–50. TRUTH AND ISSUES

Green tests ≠ spec satisfied. Drift is either a bug or an intentional spec change — never silent. FIX NOW vs REGISTER: AGENTS.md; ADB register = P23. CLOSED = verified. CRITICAL / HIGH-that-violates-quality / broken required behavior / SoT conflict → not complete.

## 50A. CARRIED

At **CARRIED: 3** leave OPEN in that review — unless the exit needs Bubby (WAITING ON USER, freeze count). Exits: FIX, ACCEPT (not for CRITICAL or HIGH data/security), REJECT. “Almost done” must end.

## 51–54. BROWNFIELD, GAPS, MONEY

Inspect, classify KEEP/IMPROVE/REPLACE/REMOVE. Plan the gap, don’t rebuild what’s right. Don’t mechanically port old code. Accounting/payment: correctness over brevity; no silent schema change.

## 55–57. CHANGE AND AUTONOMY

Spec change → update SoT first. Accidental code is not new product truth. After DEFINE: don’t interrupt for reversible details. Ask on product ambiguity, irreversible risk, credentials, spending.

## 58–60. DISCIPLINE

SoT files outrank chat. Smallest sufficient context. Collapse small products. Forbidden: ceremony to tick points.

## 61. COMPLETION

Not complete because it compiles. Intended behavior, real path, spec, issues under P50, P61B stamp current. **ALPHA is never completion.** Quality bar chooses BETA vs LIVE, not ALPHA vs BETA.

## 61B. PRODUCT READINESS

When someone says the **product** is finished, or `/adb-ready`. Not per slice. Skill `product-readiness` is the executable text.

| Key | Meaning |
|---|---|
| `NICHT_FERTIG` | Core path broken, spec unsatisfied, or P50 blockers. |
| `ALPHA` | Core path works. Gaps registered. Not real operations. Never P61 complete. |
| `BETA` | Agreed scope matches SoT. Important journeys + empty/loading/error proven on a real path. Only MEDIUM/LOW if P50 allows. |
| `LIVE` | BETA + P50 clear + 05 production items. Not “already deployed.” Constrained self-check must not return LIVE. |

Separate walker writes `READINESS` / `READINESS-AT` / `READINESS-BY` and `## Readiness`. Lead must not change the key. Stale after later RECORD or SoT change that this walk covered. Not ADB: don’t create ADB files; persist in the tracker the project already has.

## 61A. METHOD FEEDBACK

Method silent, method conflict, or method caused the defect → append `LESSONS.md`. User adopts. Still fix the project.

## 62.

Curious in DEFINE. Aggressive about a product that holds. Conservative about extra code. **The smallest coherent system that delivers the full intended product.**
