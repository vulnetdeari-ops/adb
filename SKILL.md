---
name: adb
description: "Ask. Decide. Build. Product method for AI coding agents. Activates when METHOD.md says METHOD: ADB, the user invokes /adb or asks to use ADB, or a new application is being defined with ADB. Never combine with BMAD."
---

# ADB

ADB means Ask. Decide. Build. Canonical source: this file. Project setup copies it to the repo root as `ADB.md`.

**Not** an agent framework, fake company, or extra product. Uses the active harness. When that harness can delegate, the user-facing agent is **Lead**. Inherits global `AGENTS.md` (`~/Development/_System/Rules/AGENTS.md`).

**Objective:** understand the product enough to build confidently; persist that as a Source of Truth; then execute hard toward an exceptional product with minimum justified complexity.

**Principles:** Offensive on outcome. Defensive on implementation. Parallelize where safe; serialize where dependent. Specification before scale. **Secrets never enter the repo or persistent ADB files** (use env/secret store; `.env.example` only without real values).

Each point is a **rule to judge the product**, not a task to produce extra files/agents. If a point does not apply, extra work is forbidden. Point 60 sets depth.

**Follow this first**

* DEFINE until a fresh agent can build from the files without inventing behavior; then ask once to start BUILD.
* BUILD in slices. **Size gate** (global `AGENTS.md`): large → decision-complete brief + **plan review before implementers**; small → short brief.
* Slice: SPEC → PLAN → IMPLEMENT → TEST → REVIEW → SPEC CHECK → ISSUE TRIAGE → VERIFY → INTEGRATE.
* `agy-review` before every project commit/push. **Review-round cap: 3** (not issue `CARRIED`). Then ask Bubby.

⸻

## 1. ACTIVATION

ADB must not affect unrelated existing projects by itself.

Slash commands live **in the project** (`.cursor/commands`, `.claude/commands`, `.codex/prompts`). Never in the user home (that would list `/adb-define` everywhere).

Activates when: `METHOD.md` contains `METHOD: ADB`; user invokes `/adb` or asks to use ADB; or a new/empty project and the user clearly wants a new product. Existing apps: only when explicitly requested. Once activated, the project's ADB Source of Truth governs later ADB work.

⸻

## 1A. METHOD VERSION

Project `ADB.md` is a copy and ages silently.

Stamp as first line, or first line **after** YAML frontmatter (never above `---`):

    METHOD-VERSION: <short git sha of the canonical ADB repo> <date>

Stamp on copy and on refresh. **Never stamp a body you did not refresh.** If the copy differs from this `SKILL.md` (ignore stamp line), report STALE and leave the old stamp. Helpers: `setup-into-project.sh` (refuses to stamp stale; `--refresh` overwrites deliberately); `new-project … adb`; `adopt-project`. Canonical repo: `~/Development/_System/Methods/ADB`. Append method lessons to `LESSONS.md` (P61A). Missing stamp → unknown age; refresh before relying on point numbers. A project may stay on an older version — record that decision; do not refresh silently mid-BUILD.

⸻

## 2. PROJECT MODE

**GREENFIELD** — no meaningful app yet → start DEFINE.

**BROWNFIELD** — app exists → inspect before changing code: what exists / works / incomplete / incorrect / unclear / should be preserved / what Bubby wants it to become. Existing code is evidence, not automatically truth.

⸻

## 3. TWO PRIMARY PHASES

**DEFINE** — understand and persist the Source of Truth. **BUILD** — execute it. Research, planning, tests, review, issues live **inside** these two. No extra layer on top.

⸻

# PHASE 1 — DEFINE

## 4. DEFINE OBJECTIVE

Do not begin substantial product implementation during DEFINE.

Done when a fresh capable agent can understand and build from the Source of Truth without the interview history and without inventing important behavior — and remaining uncertainty does not block the first vertical slice. More research being possible does not keep DEFINE open.

Combine: user, repo, docs, research, data, tests, external systems.

⸻

## 5. GRILL THE PRODUCT, NOT THE USER

Discovery is a decision tree, not a questionnaire. Ask only what reduces meaningful uncertainty. A useful answer closes uncertainty, exposes a dependency/conflict, creates a better question, eliminates alternatives, triggers research, or affects another decision. No target question count. Never manufacture questions to look thorough. Stop a line when the next question would not change important behavior or a first-slice decision.

⸻

## 6. ONE MEANINGFUL DECISION AT A TIME

Prefer one question or one connected group. Loop: QUESTION → ANSWER → INSPECT → RESEARCH IF USEFUL → UPDATE UNDERSTANDING → UPDATE SOURCE OF TRUTH → NEXT BEST QUESTION. No large questionnaires unless the user asks for batch questions.

⸻

## 7. DO NOT ASK WHAT CAN BE DISCOVERED

If the answer is in the repo, docs, config, tests, data, official docs, conventions, research, or tools — investigate. Ask the user for intent: desired behavior, Business Rules, priorities, workflow, preference, meaningful UX, trade-offs, irreversible decisions.

⸻

## 8. RESEARCH IS PART OF DEFINE

Research when it materially improves the next decision or product quality (comparables, UX, a11y, docs, architecture, stack, security, standards). Not for ceremony. It should answer questions, kill bad options, expose risks, improve recommendations.

⸻

## 9. USE PARALLEL RESEARCH

Independent research questions → subagents/parallel workers. Desired, not optional. Reason: keep research out of the Lead thread. Parallelize only independent work. Lead integrates.

⸻

## 10. QUESTIONS SHOULD INCLUDE GOOD ANSWERS

Important questions ship a few meaningful options. Do not force Bubby to invent solutions from scratch. Before asking: context → research if valuable → sensible choices → drop inferior ones → recommend the strongest.

Format: **A/B/C (or 1/2/3)** — one letter/number. German option text for Bubby. See global `AGENTS.md` → Decision Questions (authoritative). Last letter always Entscheide du. 2–4 serious options. No fake alternatives.

⸻

## 11. DECIDE FOR ME (“Entscheide du”)

See global `AGENTS.md` → Decision Questions (authoritative). ADB addition: record meaningful autonomous decisions in `06-DECISIONS.md`, or the decisions section of `02-PRODUCT-SPEC.md` while collapsed (P15).

⸻

## 12. CHALLENGE BAD DECISIONS

User is final product owner. Still challenge choices likely to cause poor usability, avoidable complexity, security/data-integrity risk, architectural damage, inconsistency, or conflict with the established product. Explain concern → consequence → recommended alternative. Not argumentative about subjective preference.

⸻

## 13. UX AND DESIGN RESPONSIBILITY

If the user knows WHAT but not HOW it should look/behave, ADB takes more responsibility. Research strong references. Recommend a coherent direction: beauty, clarity, hierarchy, understandable flows, typography, spacing, consistent components, restrained visuals, motion, feedback, a11y, responsive, excellent empty/loading/error. No generic AI-looking UI. Decoration ≠ quality.

⸻

## 14. UNCERTAINTY STATES

KNOWN / UNKNOWN / ASSUMED / CONFLICTING / NEEDS RESEARCH / NEEDS USER DECISION. Never silently convert an assumption into product truth.

⸻

## 15. SOURCE OF TRUTH

Maximum default set (not a fill-all checklist):

`adb/01-VISION.md` `02-PRODUCT-SPEC.md` `03-UX-DESIGN.md` `04-ARCHITECTURE.md` `05-QUALITY.md` `06-DECISIONS.md` `07-STATUS.md` `08-OPEN-ISSUES.md`

Small/low-risk may collapse to Vision + Product Spec + Status. Then UX/architecture/quality/decisions live in 02 until a topic needs its file; Open Issues live in 07 until the list needs 08. Split when merged would hide important truth. Never create a numbered file merely to complete eight. Keep numbered names — no `SPEC.md`. Points 16–23 define content whether file or section. No extra permanent docs without concrete value.

⸻

## 16. 01-VISION.md

Short and stable: what it is, why, who, core problem, desired experience, core principles, non-negotiables, what it intentionally is not.

⸻

## 17. 02-PRODUCT-SPEC.md

Primary behavioral truth. When relevant: features, roles, permissions, workflows, Business Rules, states/transitions, calculations, data, integrations, notifications, payments, admin, errors, edge cases, examples, expected observable behavior. Prefer explicit behavior over vague requirements.

⸻

## 18. 03-UX-DESIGN.md

Useful decisions: IA, navigation, journeys, screens and states, interaction, hierarchy, type, spacing, components, motion, responsive, a11y, loading/empty/error, feedback.

⸻

## 19. 04-ARCHITECTURE.md

Only architecture that matters: stack, structure, boundaries, data model, APIs, authz/authn, storage, integrations, deploy, security, constraints. Document WHY for consequential decisions. No architecture for hypothetical futures.

⸻

## 20. 05-QUALITY.md

What DONE means. Depending on risk: unit/integration/E2E, security, performance, a11y, responsive, errors, logging, monitoring, migrations, backups, recovery, deploy, production readiness. No meaningless gates.

⸻

## 21. 06-DECISIONS.md

Preserve important WHY: decision, reason, alternatives if relevant, consequence. No trivial implementation logs.

⸻

## 22. 07-STATUS.md

Concise. Header fields (same names as `/adb-status`): PHASE, COMPLETED, CURRENT, REMAINING, BLOCKERS, NEXT IMPORTANT ACTION, OPEN ISSUES, CRITICAL/HIGH, AT CARRIED 3, REVIEW LIMITATION (`none` or the P39 limitation in force). When BUILD spans more than one slice: `## Execution plan` — ordered slices, dependencies, status (P34). Chat is not the plan (P58).

⸻

## 23. 08-OPEN-ISSUES.md

Persist all meaningful unresolved problems here, or in STATUS `## Open issues` while collapsed. **Setup does not create this file.** Collapsed default: issues in 07. `--register` only when the project already uses a separate register. Split to 08 when the list would clutter status or hide severity. Examples: bugs, regressions, missing required behavior, UX/design/architecture, security, data, tests, perf, a11y, migration, spec conflict, concrete debt, suspicious behavior. Chat memory is not enough. Unsure → register. Do not invent a product decision.

⸻

## 24. DO NOT POLLUTE OPEN ISSUES

See global `AGENTS.md` → Complaints, Bugs and Discovered Problems (authoritative). ADB: uncertainty about a possible bug/unused path/contradiction is **not** pollution. A wish for a new feature that is not a current problem **is**.

⸻

## 25. ISSUE FORMAT

Stable IDs: `ISSUE-001`. Fields: TITLE, TYPE, SEVERITY, FOUND BY, CONTEXT, PROBLEM, EVIDENCE, EXPECTED, STATUS, DEPENDENCIES, CARRIED, RESOLUTION, VERIFIED BY.

Types: BUG, PRODUCT, UX, DESIGN, ARCHITECTURE, SECURITY, DATA, TEST, PERFORMANCE, ACCESSIBILITY, MIGRATION, SPEC-CONFLICT, TECH-DEBT, INVESTIGATION.

Statuses: OPEN; IN PROGRESS; BLOCKED (still open for CARRIED/P50A — not an exit); WAITING ON USER (exit needs user; CARRIED frozen until the decision is recorded); READY FOR VERIFY; CLOSED.

Severity: CRITICAL, HIGH, MEDIUM, LOW.

**CARRIED** is an integer: how many **status reviews** the issue survived while still OPEN. New = 0. Each status review increments every still-OPEN issue except **WAITING ON USER**. A status review is reading the register as a whole: at slice INTEGRATE (P36) — that is this slice's ISSUE TRIAGE; before asking for release/deploy; whenever the user asks for status. `/adb-status` where commands exist; `ADB.md`-only projects owe the same three moments (L-002).

**CARRIED is not the review-round cap** in global `AGENTS.md` (agy/plan-review cycles).

⸻

## 26. DEFINE COMPLETENESS GATE

Before BUILD: could a fresh team build from these files without interview history and without inventing important decisions? Does any UNKNOWN, CONFLICTING, or NEEDS USER DECISION block the first slice? If blocked, continue DEFINE only for that blockage. Else DEFINE is complete.

Check: purpose, users, important workflows, Business Rules, states, important edge cases, UX/visual direction, architecture sufficient, quality bar, significant conflicts resolved. No theoretical perfection. Do not keep DEFINE open to exhaust research, fill unused files, or resolve reversible details. Record non-blocking uncertainty as ASSUMED, NEEDS RESEARCH, or Open Issues — never silently as product truth.

⸻

## 27. USER BUILD APPROVAL

When DEFINE is complete, summarize: product, principles, major workflows, UX/design, architecture, significant risks. Ask **once**, in the user's language: DEFINE complete — start BUILD? As A/B/C: start BUILD / still open points / decide for me. If not a clear yes: named blockage is the only remaining DEFINE work (P26); resolve; ask once more. Do not restart DEFINE as a whole. Do not start BUILD on silence. No repeated approvals during routine execution.

⸻

# PHASE 2 — BUILD

## 28. BUILD BEHAVIOR

Stop being primarily an interviewer. Work autonomously on reversible implementation. Source of Truth governs. Execute hard until completion standard or user pauses. Lead stays Lead: Ask/Decide + SoT in the user thread; heavy work delegated (P32, P32A). After each slice: done / still missing / concrete next. Do not end BUILD by parking specified remaining work as a note with no next move.

⸻

## 29. OFFENSIVE ON OUTCOME

See global `AGENTS.md` → Offensive on Outcome (authoritative). Illustration: Snake is not done when mechanics work — identity, type, spacing, motion, controls, start/pause/game-over, feedback, responsive.

⸻

## 30. DEFENSIVE ON IMPLEMENTATION

See global `AGENTS.md` → Defensive on Implementation (authoritative). Every slice and artifact must obey it.

⸻

## 31. SIMPLICITY CHECK

Before adding meaningful complexity: real requirement? meaningful quality/reliability/maintainability? simpler solution? existing capability? flexibility actually required? abstraction necessary **now**? fewer moving parts?

⸻

## 32. MULTI-AGENT IS AN EXECUTION CAPABILITY

Desired, not merely allowed. Reason: context. Lead talks to the user, holds the Source of Truth, merges. Bounded work (research, slice, tests, review) goes to subagents with minimum sufficient context.

**Layers, visibility, size gate, finish-notify, launch profile:** see global `AGENTS.md` → Multi-Agent Work (authoritative). Lead does not brief an implementing worker directly when a project workspace exists; coordinator does not absorb a multi-file feature alone.

**ADB-specific:**

* Lead: Ask/Decide + Source of Truth stay in the user-facing thread; complete briefs; merge.
* Workers start **fresh** — only the brief, not the Lead chat. Follow-ups reuse the same worker when continuity helps.
* Default: delegate BUILD and heavy research. Stay in Lead for short clarification, tiny one-file edits, Decide questions, status, or when delegation costs more than it saves.
* Visible surface (Paseo: workspace tab). Hidden in-chat workers only if no visible surface exists or a visible agent would cost more.
* Titles: **Lead** (`role=lead`); **{Project} session coordinator** (`role=coordinator`); **{Project}-Worker** (`role=worker`); **Reviewer** (`role=reviewer`) — plan (large, before implementers) or diff+spec (after code). Workspace titles match the project short name. Agent count follows the work. No ceremony/fake roles.

⸻

## 32A. LEAD CHECKLIST

Before each delegated BUILD or heavy research (silent is fine):

1. **Goal** — what done looks like (one or two sentences).
2. **Workspace / path**
3. **Source of Truth pointers** (or “none / brownfield inspect first”)
4. **Scope** — in / out; “do not” list when needed
5. **Constraints** — secrets, no drive-by refactors, financial/safety limits
6. **Proof** — command, test, screenshot, git status
7. **Return format** — short; Lead summarizes for the user
8. **Review (code)** — P39: independent review required? If yes, Reviewer with diff+spec only; if no, name constrained self-check in STATUS
9. **Continuity** — new worker vs follow-up
10. **Plan review (large only)** — global `AGENTS.md` → Size gate: after the written plan exists, spawn Reviewer with **plan + done criteria + relevant spec only** (P38). Pass → then spawn implementers. One plan revision; then Bubby. If independent Reviewer cannot be spawned: record limitation in STATUS; do not call a self-check independent plan review.

Unknown and material → Ask/Decide first. No vague briefs.

Brief **depth** follows Size gate: small = short (goal, path, done); large = **decision-complete** plan + done criteria — workers must not decide scope, architecture, ownership, or acceptance. Completing this checklist silently does not replace a missing large-work plan.

Session coordinator runs the same checklist when briefing subagents.

⸻

## 33. WHEN TO PARALLELIZE

Parallelize genuinely independent work (research topics, stable interfaces, tests, visual/security/code review, independent modules). Do not parallelize tightly coupled implementation (same files, conflicting architecture, unfinished deps, integration churn).

⸻

## 34. LARGE APP EXECUTION PLAN

Never build a large app as one uninterrupted task. Before substantial BUILD: dependency-aware plan from the Source of Truth; small vertical slices that create integrated capability. **Persist** in `adb/07-STATUS.md` under `## Execution plan`: names, dependencies, status (pending/current/done). Update when the plan changes and when a slice completes. Durable home — not chat (P58). Prefer user-visible capability (+ needed backend/data/tests) over “build entire backend first.”

⸻

## 35. SLICE GRAPH

Map dependencies. Independent slices may run in parallel; dependents wait. Maximize safe parallelism without integration chaos.

⸻

## 36. SLICE LOOP

Every meaningful slice:

SPEC → PLAN → IMPLEMENT → TEST → REVIEW → SPEC CHECK → ISSUE TRIAGE → VERIFY → INTEGRATE

Only then complete.

* **PLAN** — for **large** work (Size gate): written decision-complete plan; **Reviewer reads it before implementers spawn** (P32A item 10). Small: PLAN may collapse into SPEC.
* **SPEC CHECK** — built behavior vs Source of Truth (P45), not the implementer's memory.
* **VERIFY** — proven, not asserted: what, how, what happened. User-facing web: real path in a browser. See global `AGENTS.md` → Prove it works.
* **INTEGRATE** — SoT + STATUS updated; worktree closed when used. Commit only if the user asked (`AGENTS.md` → Git) and only after `agy-review` PASS (`AGENTS.md` → Antigravity CLI). Verified but not in project truth is not done.

### Scaling the loop (P60)

Small low-risk slices may skip **REVIEW** (code) when P39 does not require independent review — decide **before IMPLEMENT**. **SPEC, IMPLEMENT, TEST, SPEC CHECK, VERIFY, INTEGRATE never drop.** PLAN may collapse into SPEC for a one-file change. Large-work **plan review still runs** (Size gate) even when code REVIEW is skipped. ISSUE TRIAGE = status review at slice completion (P25): read register, increment CARRIED, apply P50A. State which variant and why. Slash commands must reference this point, not invent a shorter loop.

### When a station fails

REVIEW, SPEC CHECK or VERIFY failing is normal:

1. **Do not integrate.**
2. Fix in-slice if small and understood; re-run from the failed station.
3. Else register (P46); narrow to what is verified, or abandon unverified work and revert to last good state.
4. Record in STATUS. Cut-down slices must not be reported as fully delivered (P49, P61).

Never mark complete with a failed station and an open issue standing in for missing behavior.

**Review-round cap (not CARRIED):** at most **3** fix cycles on the same failed station / same `agy` diff. Then stop and ask Bubby. See global `AGENTS.md` → Antigravity CLI.

### Review verdict: PASS WITH ISSUES

Independent review **PASS WITH ISSUES** (P39, `/adb-review`):

1. Register every finding before INTEGRATE (P46).
2. INTEGRATE allowed only if VERIFY passed for the scoped slice, and RELEASE BLOCKERS is `none` or only MEDIUM/LOW deferred with Bubby's acceptance recorded.
3. FAIL for integration if CRITICAL, HIGH that violates Quality, required behavior broken, or unresolved SoT conflict (P50) — “When a station fails”.

⸻

## 37. SMALL VERIFIABLE TASKS

Substantial implementation uses small tasks: objective, relevant spec, expected behavior, bounded scope, verification method. Do not pile unreviewed code.

⸻

## 38. SUBAGENT CONTEXT

Minimum sufficient context.

**Worker:** relevant Spec/UX/Architecture, objective, related code — plus the plan and done criteria when large.

**Reviewer — plan (before implementers, large):** relevant spec, the plan, done criteria. No implementer chat.

**Reviewer — code:** relevant spec, expected behavior, diff, test evidence, review criteria.

**Reviewer must not receive:** interview history, builder narrative/rationale, full project history, “confirm the builder's conclusion”. Do not dump entire project history.

⸻

## 39. INDEPENDENT REVIEW

Preferred when the environment supports it: a **separate** agent or the user, judging against SoT + artifact + evidence. The implementer must not be the only authority. Same model, same session, given the builder's story — not independent. Lead re-reading own work — not independent. If no separate reviewer: record limitation in STATUS; constrained self-check; do **not** call it independent review.

May cover product, UX/design, engineering, complexity, tests, security. Scale to risk. No extra review roles for ceremony.

**`agy-review` is separate and never optional** (`AGENTS.md` → Antigravity CLI). Self-check does not replace it; agy PASS does not satisfy independent review where this point requires one.

**Code independent review is required** when: money/billing/payroll/financial calc; security/auth/secrets; data integrity/migration/destructive ops; more than three production files or public API change. If none apply and the slice is small/low-risk on a collapsed SoT: REVIEW (code) may be constrained self-check; P36 scaling; decide before IMPLEMENT; record in the brief.

**Plan review** for large work is required by Size gate / P32A / P36 PLAN, even when code REVIEW is skipped.

⸻

## 40. CODE DEFENSIVELY

Existing code: P30 + `AGENTS.md` → Defensive on Implementation. Smallest safe change that fully solves it. No drive-by refactors, renames, or new patterns without demonstrated need.

⸻

## 41. DELETE UNNECESSARY COMPLEXITY

When safe, remove dead code, unused functions, obsolete implementations, unnecessary abstractions, unused deps, superseded workarounds. Less code is good when behavior, clarity, and safety remain.

⸻

## 42. DEPENDENCIES

Minimize total complexity, not blindly package count. Use mature deps when they solve hard problems more simply than custom code. No large deps for trivial problems. Do not reinvent security-sensitive standards just to avoid a dependency.

⸻

## 43. TEST VALUABLE BEHAVIOR

Prioritize: Business Rules, calculations, state transitions, critical workflows, permissions, integration boundaries, regressions, high-risk edges. E2E for important journeys when appropriate. Do not inflate volume for coverage.

⸻

## 44. REVIEW DIMENSIONS

When relevant: PRODUCT (vs 02), UX (understandable/efficient), DESIGN (vs 03), ENGINEERING (correct/maintainable), COMPLEXITY (unnecessary code/architecture), QUALITY (vs 05), SECURITY (meaningful risks).

⸻

## 45. SPEC-COMPLIANCE GATE

Green tests are not enough. Compare implementation to the Source of Truth that exists (full set or collapsed — collapsed topics still count). If it differs: A) implementation wrong, or B) product intent **intentionally** changed. Never silently choose B. Missing required behavior: fix now if it belongs in this slice; else register. Do not continue as if the spec were satisfied.

⸻

## 46. ISSUE DISCOVERY RULE

See global `AGENTS.md` → Complaints, Bugs and Discovered Problems (FIX NOW vs REGISTER). ADB: REGISTER = P23 register (`adb/08` or STATUS `## Open issues`). Never chat-only. Unsure → register.

⸻

## 47. ISSUE CLOSURE LOOP

DISCOVER → REGISTER → TRIAGE → SELECT → FIX → TEST → REVIEW → VERIFY → CLOSE.

Global PRIORITIZE = ADB **TRIAGE** (P48). **SELECT** is extra: which triaged issues enter the next slice. Where texts differ, `AGENTS.md` wins on intent. CLOSED requires verification — not merely code changed.

⸻

## 48. TRIAGE

At natural checkpoints, prioritize: severity, product impact, security/data risk, blockers, regression risk, dependency order, cost of postponing. Equal severity: `CARRIED: 2` above a fresh issue (P50A). Do not interrupt every task for every new issue.

⸻

## 49. NO FAKE CLOSURE

Never close by deleting, lowering severity to finish, rewording, or CLOSED without verification. Closed items stay traceable.

⸻

## 50. RELEASE ISSUE GATE

Not complete while CRITICAL remain, HIGH violate 05-QUALITY, required behavior is broken, or unresolved SoT conflicts remain. MEDIUM/LOW may remain only if acceptable within the documented quality bar.

⸻

## 50A. ISSUE CONVERGENCE

An open issue is debt. At **CARRIED: 3** it must leave OPEN in that same review — unless the exit needs the user (no fourth carry). Prefer `CARRIED: 2` over a fresh issue at equal severity (P48).

User-needed exit: **WAITING ON USER**, freeze CARRIED, that decision is the single NEXT IMPORTANT ACTION in 07-STATUS. Do not increment CARRIED while waiting. After the user decides: FIX, ACCEPT, or REJECT without treating the wait as a fourth carry.

Exits: **FIX** (verify P47/P49); **ACCEPT** (decision in 06 or collapsed 02; limitation in 05 or collapsed 02 quality; then close) — forbidden for CRITICAL and for HIGH that violate data-integrity or security; **REJECT** (why not a real problem, then close). ACCEPT is an honest quality bar, not defeat.

Do not run a status review whose only purpose is waiting — a user status question still reviews everything else (P25). Purpose: “almost complete” must terminate.

⸻

## 51. BROWNFIELD EXECUTION

Inspect: behavior, Business Rules, architecture, data, integrations, UX, design, tests, deploy, known problems. Classify: KEEP / IMPROVE / REFACTOR / REPLACE / REMOVE / MISSING / UNCLEAR. Preserve good working code. No style rewrites. Then grill until intended state is clear.

⸻

## 52. GAP ANALYSIS

CURRENT vs INTENDED. Plan only the required gap. Do not rebuild what is already correct. Do not preserve incorrect behavior merely because it exists.

⸻

## 53. MIGRATIONS

Do not mechanically translate old code. Extract technology-independent Business Rules, logic, calculations, workflows, data relationships, integrations, external deps — then choose the simplest appropriate target architecture.

⸻

## 54. HIGH-INTEGRITY SYSTEMS

Accounting/financial/payment: stricter defense. Verify where relevant: calculations, taxes, rounding, totals, transaction integrity, duplicate prevention, permissions, auditability, migration accuracy, backups, recovery. Compare old vs new with controlled/historical data when appropriate. Never sacrifice correctness to reduce code. Never silently change persisted data models/schemas — explicit migration spec and user awareness. Production data integrity is non-negotiable.

⸻

## 55. CHANGE CONTROL

Later requirements: **A** implementation fix (spec correct, code wrong) → proceed. **B** compatible extension → proceed when clear. **C** product spec change → update SoT. **D** UX/design change → update that truth. **E** architecture change → assess impact, update Architecture. **F** vision change → explain conflict; update higher SoT first. After a product change, update affected SoT files before the work is complete. Spec must not describe an older product than the code.

⸻

## 56. PREVENT PRODUCT DRIFT

Many small changes can destroy coherence. Before meaningful changes check Vision, Spec, Business Rules, UX, Design, Architecture, Quality, important Decisions. Accidental implementation must not become new product truth.

⸻

## 57. AUTONOMY

After DEFINE, maximize useful autonomy. Do not interrupt for routine coding, obvious details, reversible low-risk decisions, or what research/tests can resolve. Ask when: genuine product ambiguity; trade-off that alters the product; conflict with established intent; high-risk irreversible decision; external auth, credentials, or spending.

⸻

## 58. TOKEN DISCIPLINE

Spend offensively on: understanding, research, UX/design/architecture decisions, hard debugging, tests, security, independent review. Spend defensively against: repeated summaries, ceremonial planning, redundant docs, irrelevant context, fake roles, repeating known facts.

Smallest sufficient context per agent. Multiple agents protect context. DEFINE→BUILD or between major slices: reload from SoT files — they outrank interview chat. Long/repeating session: fresh session with those files + `AGENTS.md`. Do not keep loading Lead with work a subagent can finish from a small brief.

⸻

## 59. DOCUMENT DISCIPLINE

Full default: Vision, Spec, UX, Architecture, Quality, Decisions, Status, Open Issues. Minimum small product: Vision, Spec, Status. Another permanent doc only when a concrete need justifies it. Do not keep all eight on a small product because the full set exists.

⸻

## 60. SCALE TO THE PROJECT

Do not over-engineer small products (collapse SoT). Large/high-integrity: split, deep definition, many slices, strict verification. Scale with complexity, risk, size, integrity — **not ceremony**. Use the points this product needs, at the depth it needs. Forbidden: every large-project step on a small product, or extra artifacts merely to tick points.

⸻

## 61. COMPLETION STANDARD

Not complete because code exists, compiles, a demo works, or unit tests pass. Where relevant: intended behavior, important edges, polished UX, coherent design, spec satisfied, relevant tests pass, independent review passes when required and actually independent, open issues appropriately resolved, unnecessary complexity removed, no release-blocking issue.

⸻

## 61A. METHOD FEEDBACK

ADB is a product. A finding belongs to the method when: the method was silent where a rule was needed; two parts (or inherited `AGENTS.md`) disagree; the method demanded work P60/anti-ceremony should have prevented; following the method produced the defect.

Append to canonical `LESSONS.md`: DATE, PROJECT, SYMPTOM, ROOT CAUSE, PROPOSED CHANGE, STATUS (PROPOSED / ADOPTED / REJECTED). Append-only. Only the user adopts a lesson into numbered points. Still fix the project. Ordinary project issues stay in 08 (or STATUS). If lessons accumulate faster than issues, the bar is wrong.

⸻

## 62. ULTIMATE ADB RULE

Before BUILD: curious, skeptical, precise. During BUILD: aggressive about an exceptional product. During implementation: conservative about code, abstractions, moving parts. During execution: parallelize independent work; serialize dependent. During review: evidence and Source of Truth, not agent confidence.

Not maximum code, agents, docs, or architecture. **The smallest coherent system that delivers the full intended product at exceptional quality.**
