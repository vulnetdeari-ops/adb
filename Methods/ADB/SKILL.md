---
name: adb
description: "Ask. Decide. Build. Setup copies this file into each project as ADB.md, and copies Rules/AGENTS.md as AGENTS.md. Activates only when METHOD.md says METHOD: ADB — not when missing or PLAIN. BMAD is retired. Talk, proof, secrets, git, roles: the project’s AGENTS.md."
---

# ADB

Ask. Decide. Build. Canonical: this file. Setup copies it into every project as `ADB.md`. Follow that copy. `--refresh` updates it.

Stamp as first line after YAML frontmatter (never above `---`):

    METHOD-VERSION: <short git sha of this repo> <date>

Never stamp a body you did not refresh. If the copy differs from this file (ignore the stamp): STALE. `--refresh` to update, or stay on the older version on purpose.

**Job:** The owner knows where the product must land. They are not the coder, not the tester, not the one who signs into every site. Write that destination in `adb/`. Then CodeAgent builds it in slices that fit in context and proves it (browser, tests, logins). They choose only when the prompt means two different products or scopes (A/B/C). Not a fake company.

Talk, proof, secrets, git, roles: this project’s `AGENTS.md` (setup copy of `Rules/AGENTS.md`). Do not contradict it. MainAgent only directs; PlanAgent / CodeAgent / ReviewAgent do the work; never spawn.

Activates **only** when `METHOD.md` contains `METHOD: ADB`. Missing or `PLAIN` → do not load. Follow the project’s `ADB.md`. **BMAD is retired** — do not follow leftover BMAD; setup removes the engine; leftover planning docs are DEFINE evidence, not `adb/`. Slash commands and `AGENTS.md` live **in the project** as copies. First run: `/start` (`START.md`). Helper: `setup-into-project.sh` (`--plain` for rules only) or `Rules/start-into-project.sh`. Method source: `Methods/ADB` in this repository. Method defects: `LESSONS.md`.

Product truth is `adb/`. Chat is not. A later agent reads `adb/`, not the interview.

Each rule judges the product. If it does not apply, extra work is forbidden.

⸻

# DEFINE

No product code. MainAgent directs **PlanAgent**. CodeAgent does not implement.

**Done when** a fresh agent can build from `adb/` without inventing important behavior, and leftover uncertainty does not block the first slice. More research possible ≠ keep DEFINE open.

**Greenfield** — nothing exists yet. **Brownfield** — inspect first: exists / works / wrong / unclear / keep / what the owner wants. Existing code is evidence, not automatically the destination.

Ask the **product**, not the owner, for what repo, docs, tests or research can answer. Ask the owner only for intent, priorities, trade-offs. One decision at a time. A/B/C: AGENTS.md. Record in `06`, or in `02` while collapsed. Challenge choices that hurt usability, safety, or coherence — not taste. If the owner knows WHAT but not HOW it should look: PlanAgent owns a coherent direction. No generic AI look.

Every material fact: KNOWN / UNKNOWN / ASSUMED / CONFLICTING / NEEDS RESEARCH / NEEDS USER DECISION. Never silently turn an assumption into product truth.

## Source of truth

Default small: `01-VISION`, `02-PRODUCT-SPEC`, `07-STATUS`. Split 03–06 and 08 only when merged would hide truth. Setup does **not** create 08. Numbered names only. No extra permanent docs without a concrete need.

- **01** — what it is, who, why, what it is not.
- **02** — behavior: features, rules, states, data, errors, examples.
- **03** — screens, flows, empty / loading / error.
- **04** — stack, boundaries, deploy, security — only what matters, with WHY.
- **05** — what DONE means for this product.
- **06** — important WHY, not trivia.
- **07** — header only: PHASE, NOW, NEXT, BLOCKERS, OPEN, READINESS. Several slices: `## Execution plan`. Preserve `## Readiness` — ReviewAgent writes it. MainAgent does not change the key.
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

**CARRIED:** status reviews survived while OPEN. New = 0. A review is: slice RECORD, before release, or the owner asks status. Not the PROVE 3-round cap. At **3**: FIX, ACCEPT (not for CRITICAL, not for HIGH data/security), or REJECT. WAITING ON USER freezes the count. CLOSED = verified. Don’t delete closed issues.

Leave DEFINE: could a fresh team build from these files without the interview? Does any UNKNOWN / CONFLICTING / NEEDS USER DECISION block the first slice? Then ask **once**: start BUILD / still open points / decide for me. No BUILD on silence. Do not restart DEFINE as a whole.

⸻

# BUILD

Stop interviewing. `adb/` governs. A slice is done when its SPEC done-criteria are proved. Next slice only if already in `## Execution plan` or the owner asks. Don’t park this slice’s leftover work as a note with no next move.

The whole product does not fit in one context window. User-visible slices — not “entire backend first”. Parallel only when jobs don’t share files or unfinished deps. Large product: `## Execution plan` in 07.

Brief: what, where, done, `adb/` pointers, proof. The next agent gets `adb/`, not your story. **Heavy** (money, login/security, live, data, new public contract): PlanAgent writes plan + done criteria first — do not skip PlanAgent — then CodeAgent builds. ReviewAgent sees the plan and never implements. Same session + builder’s story ≠ independent.

**SPEC → BUILD → PROVE → RECORD**

- **SPEC** — what this slice must do, from `adb/`. Heavy: PlanAgent’s plan + done criteria here.
- **BUILD** — CodeAgent, smallest safe change. Delete dead code when safe. Test business rules, money, permissions, edges — not coverage theater.
- **PROVE** — vs `adb/`, on a real path. UI: this harness’s browser. CodeAgent signs in (AGENTS.md; the owner only for 2FA / captcha / passkey / OS-blocked keys). Not “it compiles.”
- **RECORD** — update `adb/` + STATUS; increment CARRIED; apply CARRIED-3. Git: AGENTS.md (job done → CodeAgent commits; push only when the owner asks).

PROVE fails: do not RECORD as done. CodeAgent fixes or registers. Cap 3 fix rounds, then the owner.

`/adb-review` PASS WITH ISSUES: register; RECORD only if PROVE passed and release blockers allow.

Green tests ≠ spec satisfied. Drift is a bug or an intentional spec change — never silent. Spec change → update `adb/` first. Accidental code is not new product truth. Accounting/payment: correctness over brevity; no silent schema change.

Brownfield: KEEP / IMPROVE / REPLACE / REMOVE. Don’t rebuild what’s right. Don’t mechanically port old code.

After DEFINE: don’t interrupt the owner for reversible details. Ask on product ambiguity, irreversible risk, credentials, spending.

⸻

# COMPLETION

Not complete because it compiles. Intended behavior exists, real path, spec satisfied, issues under the bar, READINESS stamp current.

| Key | Meaning |
|---|---|
| `NICHT_FERTIG` | Core path broken, spec unsatisfied, or release blockers. |
| `ALPHA` | Core path works. Gaps registered. Not real operations. **Never product complete.** |
| `BETA` | Agreed scope matches `adb/`. Important flows + empty/loading/error on a real path. Only MEDIUM/LOW if the bar allows. |
| `LIVE` | BETA + bar clear + 05 production items. Not “already online.” Constrained self-check must not return LIVE. |

The bar chooses BETA vs LIVE, not ALPHA vs BETA. `/adb-ready` only when the owner asks about the **whole app**, not after a slice whose plan is met. Follow COMPLETION in this file. MainAgent directs living ReviewAgent. ReviewAgent writes `READINESS` and overwrites `## Readiness`. MainAgent does not change the key. Stale after a later RECORD or spec change this walk covered.

Method silent, method conflict, or method caused the defect → append `LESSONS.md`. Still fix the project.

Curious in DEFINE. Aggressive about a product that holds. Conservative about extra code. **The smallest coherent system that delivers the full intended product.**
