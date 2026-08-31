---
name: adb
description: "Ask. Decide. Build. Bubby sets the product destination. Lead only directs. Code implements, tests, and signs in. Activates only when METHOD.md says METHOD: ADB — not when METHOD.md is missing or PLAIN. BMAD is retired. Talk, proof, secrets, git, roles: global AGENTS.md."
---

# ADB

Ask. Decide. Build. Canonical: this file. Do not copy it into the project.

**Job:** Bubby knows where the product must land. He is not the coder, not the tester, not the one who signs into every site. Roles are global AGENTS.md: **Lead** (session Hauptagent) only directs; **Plan** plans; **Code** implements, tests, and signs in; **Review** reviews. Never spawn a new agent for a job — queue on the living named agent. Ask until the destination is written down, then Code builds it in pieces that fit in context, and Code proves it (browser, tests, logins). He chooses only when the prompt means two different products or scopes (A/B/C). Not a fake company.

Talk, proof, secrets, git, roles: `/Users/bubby/Development/_System/Rules/AGENTS.md`. Do not copy those rules here. Do not contradict them.

Activates **only** when `METHOD.md` contains `METHOD: ADB`. If `METHOD.md` is missing or `PLAIN`, do not load ADB. **BMAD is retired.** Leftover `METHOD: BMAD`, `_bmad/`, `.bmad-core/` or BMAD commands are not a method — do not follow them. Setup replaces the switch and removes the engine. Leftover BMAD planning docs (`_bmad-output`, old PRD) are brownfield evidence for DEFINE, not product truth. Slash commands live **in the project**, never in the user home. Ignore a leftover project `ADB.md`. Helpers: `setup-into-project.sh`, `new-project … adb`, `adopt-project`. Canonical repo: `~/Development/_System/Methods/ADB`. Method defects: `LESSONS.md`.

Product truth is the project’s `adb/` files. Chat is not product truth. A later agent reads `adb/`, not the old interview.

Each rule judges the product. If it does not apply, extra work is forbidden.

⸻

# DEFINE

No product code yet. Lead directs **Plan**. Lead does not write `adb/`. Code does not implement in DEFINE.

**Done when** a fresh agent can build from `adb/` without inventing important behavior, and leftover uncertainty does not block the first slice. More research possible ≠ keep DEFINE open.

**Greenfield** — nothing exists yet. **Brownfield** — inspect first: what exists / works / is wrong / unclear / keep / what Bubby wants. Existing code is evidence, not automatically the destination. Leftover BMAD planning files are evidence for DEFINE, not a second method and not `adb/`.

Ask the **product**, not Bubby, for what repo, docs, tests or research can answer. Ask Bubby only for intent, priorities, trade-offs. One decision at a time. A/B/C: AGENTS.md. Record decisions in `06` or the decisions section of `02` while collapsed. Challenge choices that hurt usability, safety, or coherence — not taste. If Bubby knows WHAT but not HOW it should look: Plan owns a coherent direction. No generic AI look.

Every material fact: KNOWN / UNKNOWN / ASSUMED / CONFLICTING / NEEDS RESEARCH / NEEDS USER DECISION. Never silently turn an assumption into product truth.

## Source of truth

Default small: `adb/01-VISION.md`, `02-PRODUCT-SPEC.md`, `07-STATUS.md`. Split into 03–06 and 08 only when keeping it merged would hide truth. Setup does **not** create 08. Numbered names only. No extra permanent docs without a concrete need.

- **01** — what it is, who, why, what it is not.
- **02** — behavior: features, rules, states, data, errors, examples.
- **03** — screens, flows, empty / loading / error.
- **04** — stack, boundaries, deploy, security — only what matters, with WHY.
- **05** — what DONE means for this product.
- **06** — important WHY, not trivia.
- **07** — STATUS header only: PHASE, NOW, NEXT, BLOCKERS, OPEN, READINESS. Several slices: `## Execution plan`. Preserve `## Readiness` — Review writes it (verdict, when, who). Lead does not change the key.
- **08** — real unresolved problems, or `## Open issues` in 07 while collapsed.

## Issues

No wishes. Stable `ISSUE-00N`. Only these fields:

```
### ISSUE-00N — TITLE
SEVERITY: CRITICAL | HIGH | MEDIUM | LOW
PROBLEM:
EVIDENCE:
STATUS: OPEN | WAITING ON USER | CLOSED
CARRIED: n
RESOLUTION:   (when CLOSED)
VERIFIED BY:  (when CLOSED)
```

**CARRIED:** status reviews survived while OPEN. New = 0. A review is: slice RECORD, before release, or Bubby asks status. Not the `agy-review` cap. At **3**: FIX, ACCEPT (not for CRITICAL, not for HIGH data/security), or REJECT. WAITING ON USER freezes the count. CLOSED = verified. Don’t delete closed issues.

Leave DEFINE: could a fresh team build from these files without the interview? Does any UNKNOWN / CONFLICTING / NEEDS USER DECISION block the first slice? Then ask **once**: start BUILD / still open points / Entscheide du. No BUILD on silence. Do not restart DEFINE as a whole.

⸻

# BUILD

Stop interviewing. `adb/` governs. A slice is done when its SPEC done-criteria are proved. Do not open a next slice unless it is already in `## Execution plan` or Bubby asks. Don’t park work that was in this slice’s plan as a note with no next move.

The whole product does not fit in one context window. User-visible slices — not “entire backend first”. Parallel only when jobs don’t share files or unfinished deps. Large product: `## Execution plan` in 07.

Brief: what, where, done, `adb/` pointers, proof. The next agent gets `adb/`, not your story. Lead does not plan, implement, or review — Lead only directs the living named agents (AGENTS.md). Never spawn. **Heavy** (money, login/security, live, data, new public contract): **Plan** writes plan + done criteria first; do not skip Plan; then Code builds. **Review** sees the plan and never implements; same session + builder’s story ≠ independent. `agy-review` is the commit check; it does not replace the heavy plan.

Every meaningful slice:

**SPEC → BUILD → PROVE → RECORD**

- **SPEC** — what this slice must do, from `adb/`. Heavy: Plan writes plan + done criteria here.
- **BUILD** — Code, smallest safe change. Delete dead code when safe. Test business rules, money, permissions, edges — not coverage theater.
- **PROVE** — vs `adb/`, on a real path. UI: this harness’s browser. Code signs into sites (AGENTS.md; Bubby only for 2FA / captcha / passkey / OS-blocked keys). Not “it compiles.”
- **RECORD** — update `adb/` + STATUS; increment CARRIED; apply the CARRIED-3 exit. Git: AGENTS.md — when this job is done (plan met, proved, meaningful diff), Code commits automatically after `agy-review` PASS. Do not wait for Bubby to say commit. Push only when Bubby asks.

PROVE fails: do not RECORD as done. Code fixes here or registers. Cap 3 fix rounds, then Bubby.

`/adb-review` PASS WITH ISSUES: register findings; RECORD only if PROVE passed and release blockers allow.

Green tests ≠ spec satisfied. Drift is a bug or an intentional spec change — never silent. Spec change → update `adb/` first. Accidental code is not new product truth. Accounting/payment: correctness over brevity; no silent schema change.

Brownfield gaps: KEEP / IMPROVE / REPLACE / REMOVE. Don’t rebuild what’s right. Don’t mechanically port old code.

After DEFINE: don’t interrupt Bubby for reversible details. Ask on product ambiguity, irreversible risk, credentials, spending.

⸻

# COMPLETION

Not complete because it compiles. Intended behavior exists, real path, spec satisfied, issues under the bar, READINESS stamp current.

| Key | Meaning |
|---|---|
| `NICHT_FERTIG` | Core path broken, spec unsatisfied, or release blockers. |
| `ALPHA` | Core path works. Gaps registered. Not real operations. **Never product complete.** |
| `BETA` | Agreed scope matches `adb/`. Important flows + empty/loading/error on a real path. Only MEDIUM/LOW if the bar allows. |
| `LIVE` | BETA + bar clear + 05 production items. Not “already online.” Constrained self-check must not return LIVE. |

The bar chooses BETA vs LIVE, not ALPHA vs BETA. `/adb-ready` is the whole-product walk — only when Bubby asks about the **whole app**, not after a slice whose plan is met. Skill `product-readiness`. Lead directs living **Review**. Review writes `READINESS` in the STATUS header and overwrites `## Readiness` (what was walked, when, independent or self-check). Lead does not change the key. Constrained self-check must not return LIVE. Stale after a later RECORD or spec change this walk covered.

Method silent, method conflict, or method caused the defect → append `LESSONS.md`. Still fix the project.

Curious in DEFINE. Aggressive about a product that holds. Conservative about extra code. **The smallest coherent system that delivers the full intended product.**
