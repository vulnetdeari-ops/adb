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
