# ADB Lessons

Append-only record of defects in the method itself, found by real projects (P61A).

This file is not an issue tracker. Project problems belong in that project's `adb/08-OPEN-ISSUES.md`. Only findings whose root cause is ADB itself belong here.

Nothing here changes the method until the user adopts it. STATUS says whether that happened.

---

## L-001 — Setup never enforced the issue-register location

DATE: 2026-08-26
PROJECT: buchhaltung-web
SYMPTOM: The project kept its issue register at the repository root as `OPEN-ISSUES.md`, declared that file canonical inside the file itself, and also carried an `## Open issues` section in `adb/07-STATUS.md`. `adb/08-OPEN-ISSUES.md` did not exist although the Source of Truth was not collapsed. Three candidate locations, and the STATUS section claimed `0` open issues while real unresolved conflicts existed.
ROOT CAUSE: P15 forbids alternate filenames and P23 names the register, but nothing in the method verifies the register's location once a project is running. The inherited `AGENTS.md` already routed ADB projects to `adb/08-OPEN-ISSUES.md`, so the method and its own rules file disagreed in practice with no point responsible for noticing. Method silent where the project needed a rule.
PROPOSED CHANGE: Give the status review an explicit Source-of-Truth layout check: the numbered files present, no ADB content living under non-ADB filenames, no topic duplicated between a numbered file and an ad-hoc one.
STATUS: ADOPTED — added as Step 2A of `/adb-status`, 2026-08-26.

---

## L-002 — No terminating condition for open issues

DATE: 2026-08-26
PROJECT: buchhaltung-web
SYMPTOM: The product could sit indefinitely in "almost complete". P61 correctly refused to call it complete, but nothing forced any open issue toward an exit, so a status review could run any number of times and produce the same verdict with no progress.
ROOT CAUSE: P50 defines what blocks release and P61 defines what completion means, but neither bounds how long an issue may stay OPEN. A gate that can be re-failed forever is a report, not a gate.
PROPOSED CHANGE: Count how many reviews each issue survives and force an exit — FIX, ACCEPT or REJECT — at a fixed count.
STATUS: ADOPTED — added as P50A ISSUE CONVERGENCE and the `CARRIED` field in P25, 2026-08-26.

---

## L-003 — Project copies of the method have no age

DATE: 2026-08-26
PROJECT: buchhaltung-web
SYMPTOM: The project's `ADB.md` was modified but uncommitted. Its working copy was byte-identical to the canonical `SKILL.md`, so the committed version was some older method revision — but which one, and how old, was not answerable from the repository.
ROOT CAUSE: Setup copies the method into the project and the copy carries no provenance. A copy with no version is unfalsifiable.
PROPOSED CHANGE: Stamp the copy with the canonical repository's short git sha and date on its first line.
STATUS: ADOPTED — added as P1A METHOD VERSION, 2026-08-26.

---

## L-004 — P1A collided with the frontmatter it was written for

DATE: 2026-08-26
PROJECT: buchhaltung-web
SYMPTOM: P1A demanded the `METHOD-VERSION` stamp on the first line of the project `ADB.md`. The canonical `SKILL.md` opens with a YAML frontmatter block, and the project copy keeps it. Following P1A literally would have pushed `---` to line 3 and broken the block for any harness that parses it.
ROOT CAUSE: The point was written without checking the file it governs. A rule about a copy must hold for the actual shape of that copy.
PROPOSED CHANGE: Allow the stamp as the first line after the frontmatter block, and forbid placing it above frontmatter.
STATUS: ADOPTED — P1A reworded 2026-08-26, same day it was introduced.

---

## L-005 — Slash commands were installed into the user home

DATE: 2026-08-26
PROJECT: ADB method repo
SYMPTOM: `/adb-define` and the other four commands appeared in every Cursor, Codex and Claude session, including projects without `METHOD: ADB`.
ROOT CAUSE: `install-commands.sh` targeted `$HOME/.cursor/commands`, `$HOME/.codex/prompts` and `$HOME/.claude/commands`. P1 forbids ADB from affecting ordinary work in unrelated projects. A home-level command list is exactly that.
PROPOSED CHANGE: Install into the project's own harness directories. Remove leftover home-level links. State the rule in P1.
STATUS: ADOPTED — installer is project-scoped; P1 forbids home-level installs; `--remove-global` cleans leftovers, 2026-08-26.

---

## L-006 — Project helpers copied ADB.md without stamp, commands, or adb/08

DATE: 2026-08-26
PROJECT: ADB method + Shared/Scripts
SYMPTOM: `new-project` / `adopt-project` wrote `METHOD.md` and a bare `ADB.md`, but left no `METHOD-VERSION` stamp, installed no project-local slash commands, and still created a root `OPEN-ISSUES.md` that contradicts P15/P23 and `AGENTS.md`.
ROOT CAUSE: Setup lived outside the method. The method gained P1A, project-scoped commands and the numbered issue register; the helpers were never updated.
PROPOSED CHANGE: One `setup-into-project.sh` that stamps, ensures `adb/08-OPEN-ISSUES.md`, and installs commands into the project. Wire it into `new-project` and `adopt-project`. Do not auto-create Vision/Spec — that is DEFINE.
STATUS: ADOPTED — 2026-08-26.

---

## L-007 — Chip labels vs A/B/C Decision Questions

DATE: 2026-08-26/27
PROJECT: ADB method + Paseo Decision Questions
SYMPTOM: Draft decision UI used Perplexity-style chip labels. Agents and drafts drifted toward long label text instead of single-letter answers. That conflicted with global `AGENTS.md` Decision Questions (A/B/C + „Entscheide du“).
ROOT CAUSE: A feature sketch taught a discarded interaction. The method and the reading copy already followed A/B/C; the feature note still named “chips” and looked like an open path.
PROPOSED CHANGE: Keep A/B/C + „Entscheide du“ as the only rule. Mark chips rejected. Rename the feature note so the filename does not teach chips.
STATUS: ADOPTED — A/B/C + Entscheide du; chips verworfen; `FEATURE-decision-options.md`, 2026-08-27.

---

## L-008 — Project copy of the method was a second source

DATE: 2026-08-28
PROJECT: ADB method
SYMPTOM: Setup copied `SKILL.md` into every project as `ADB.md`, then needed a version stamp, a STALE check, and slash commands that restated the method so they would not cite a stale copy. Agents had two method files. P60 was cited though it had no own section.
ROOT CAUSE: A copy ages. Machinery to keep the copy honest became larger than the method. Commands restated `SKILL.md` instead of pointing at it.
PROPOSED CHANGE: Do not copy the method into the project. `METHOD.md` is the switch. Agents read canonical `SKILL.md`. Commands stay short. Leftover `ADB.md` is ignored; `--refresh` removes it. Drop the P60 citation.
STATUS: ADOPTED — 2026-08-28.

---

## L-009 — Rulebook should state who sets the destination

DATE: 2026-08-28
PROJECT: ADB method
SYMPTOM: The method explained phases and files. It did not say in one place: Bubby sets where the product must land; the agent writes that down, builds in slices that fit context, and proves it (browser, tests, logins).
ROOT CAUSE: The method was written as numbered process. The reason it exists is a non-programmer owner.
PROPOSED CHANGE: Open `SKILL.md` with that job. DEFINE / BUILD / COMPLETION in plain language. Commands point at those sections, not at old point numbers.
STATUS: ADOPTED — 2026-08-28.

---

## L-010 — Dual-method framing kept BMAD alive after it was gone

DATE: 2026-08-31
PROJECT: ADB method
SYMPTOM: Agents still treated BMAD as a peer method: `adopt-project` said “choose ADB when asked”, setup left `METHOD: BMAD` untouched, and leftover `_bmad/` / `.bmad-core/` / BMAD commands could still be followed. Bubby no longer has BMAD.
ROOT CAUSE: The method was defined against BMAD (“never combine”). After BMAD was retired, that opposition still taught agents that BMAD exists. Setup had no job to replace the switch or remove the engine. Planning leftovers and the engine were not distinguished.
PROPOSED CHANGE: ADB is the product method. BMAD is retired. Setup replaces `METHOD: BMAD` and removes the engine; planning leftovers stay as brownfield evidence for DEFINE. Commands and the reading copy say BMAD is not a method.
STATUS: ADOPTED — 2026-08-31.


