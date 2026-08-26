# ADB

**Ask. Decide. Build.**

ADB is a product method for AI coding agents. It asks until the intended product is clear, proposes decisions, then builds. It is not an agent framework, a fake company, or a pile of extra process.

This is not the Android Debug Bridge.

## Use it in a project

1. Copy [`SKILL.md`](SKILL.md) to the project root as `ADB.md`, **or** run the project helpers below.
2. Add a `METHOD.md` that contains exactly:

```text
METHOD: ADB
```

(`setup-into-project.sh` creates this file when it is missing.)

3. Tell the agent to follow `ADB.md`.
4. Stamp `ADB.md` with `METHOD-VERSION` (see `SKILL.md` point 1A). Keep YAML frontmatter first when the copy has it; the stamp is the first line after the closing `---`, with nothing between.
5. Issue register: for **collapsed** Source of Truth (default for small products), issues live in `adb/07-STATUS.md` under `## Open issues` — setup does **not** create `adb/08-OPEN-ISSUES.md`. Create `08` only when the list outgrows STATUS (P23), or run `./setup-into-project.sh --register` when the project already uses a separate file. Never use a root `OPEN-ISSUES.md`.
6. Install slash commands **into that project**, never into the user home (P1).

Preferred: use the Development helpers so steps 1 and 4–6 are automatic.

```text
# new Active project
new-project my-app adb

# existing repo (from its root)
adopt-project
# choose ADB when asked

# or only the ADB pieces, against any project path
./setup-into-project.sh /path/to/project
./setup-into-project.sh --check /path/to/project    # report only
./setup-into-project.sh --refresh /path/to/project  # update an outdated ADB.md body
./setup-into-project.sh --register /path/to/project # optional: create adb/08-OPEN-ISSUES.md
```

`setup-into-project.sh` copies/stamps `ADB.md`, creates `METHOD.md` when missing, installs slash commands, and **does not** create `adb/08-OPEN-ISSUES.md` unless you pass `--register` (collapsed default: issues in `adb/07-STATUS.md`).

If an existing `ADB.md` body differs from `SKILL.md`, the script reports `STALE` and does **not** stamp it — a stamp naming the current version on an old body would answer the age question wrongly (P1A). It also leaves the slash commands alone in that case, so the project does not end up with an old method and new commands citing points it lacks. Use `--refresh` to update body and commands together, or record a decision to stay on the older version.

Slash commands (`/adb`, `/adb-define`, `/adb-slice`, `/adb-review`, `/adb-status`, `/adb-triage`) live in [`commands/`](commands/). They point at `SKILL.md`; they are not a second method.

Inside this repository, `.cursor/commands/`, `.claude/commands/` and `.codex/prompts/` are **symlinks** into `commands/`. There is one copy to edit, so the harnesses cannot drift apart.

```text
./install-commands.sh                 # into the current project only
./install-commands.sh --check
./install-commands.sh --remove-global # delete leftover home-level installs
```

Do not combine ADB with BMAD.

Defects in the method itself, found by real projects, go in [`LESSONS.md`](LESSONS.md). Ordinary project issues do not.

Vision, Product Spec and the rest of `adb/01`…`adb/07` are **not** created by setup. They are written in DEFINE. The issue register starts in `adb/07-STATUS.md` for collapsed products; split to `adb/08-OPEN-ISSUES.md` when the list needs its own file (P23).

## What it does

- **Ask** — grill the product, not the user. Research what can be discovered. Offer real choices. `Decide for me` is valid.
- **Decide** — keep a durable source of truth. Small products may collapse to Vision, Product Spec and Status. Larger products use `adb/01` … `adb/08`. Uncertain findings get registered, not swallowed.
- **Build** — execute against that truth. When the harness can delegate, the lead agent stays **Lead** and workers do heavy slices (see `SKILL.md` points 32 and 32A). Small products stay small. Missing required behavior is fixed or written down, not ignored.

The full method is in [`SKILL.md`](SKILL.md).

Zum Lesen auf Deutsch: [`ADB-LESEN-DE.html`](ADB-LESEN-DE.html). Agenten folgen nicht dieser Datei — nur `SKILL.md`.
