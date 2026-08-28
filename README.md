# ADB

**Ask. Decide. Build.**

ADB is a product method for AI coding agents. It asks until the intended product is clear, proposes decisions, then builds. It is not an agent framework, a fake company, or a pile of extra process.

This is not the Android Debug Bridge.

The method is [`SKILL.md`](SKILL.md). Do not copy it into a project.

## Use it in a project

1. Add a `METHOD.md` that contains exactly:

```text
METHOD: ADB
```

2. Install slash commands **into that project**, never into the user home.
3. Tell the agent to follow `SKILL.md` in this repo. Ignore a leftover project `ADB.md`.
4. Issue register: for **collapsed** Source of Truth (default for small products), issues live in `adb/07-STATUS.md` under `## Open issues` — setup does **not** create `adb/08-OPEN-ISSUES.md`. Create `08` only when the list outgrows STATUS, or run `./setup-into-project.sh --register`. Never use a root `OPEN-ISSUES.md`.

Preferred: use the Development helpers.

```text
# new Active project
new-project my-app adb

# existing repo (from its root)
adopt-project
# choose ADB when asked

# or only the ADB pieces, against any project path
./setup-into-project.sh /path/to/project
./setup-into-project.sh --check /path/to/project
./setup-into-project.sh --refresh /path/to/project   # reinstall commands; remove leftover ADB.md
./setup-into-project.sh --register /path/to/project  # optional: create adb/08-OPEN-ISSUES.md
```

`setup-into-project.sh` creates `METHOD.md` when missing, installs slash commands, and **does not** create `adb/08-OPEN-ISSUES.md` unless you pass `--register`. It does not copy `SKILL.md` into the project.

Slash commands (`/adb`, `/adb-define`, `/adb-slice`, `/adb-review`, `/adb-status`, `/adb-triage`, `/adb-ready`) live in [`commands/`](commands/). They point at `SKILL.md`; they are not a second method.

Inside this repository, `.cursor/commands/`, `.claude/commands/` and `.codex/prompts/` are **symlinks** into `commands/`. There is one copy to edit.

```text
./install-commands.sh                 # install into the current directory
./install-commands.sh --check         # report only
./install-commands.sh --remove        # remove from the current directory
./install-commands.sh --remove-global # delete leftover home-level installs
```

Do not load a second product method on top of ADB.

Defects in the method itself, found by real projects, go in [`LESSONS.md`](LESSONS.md). Ordinary project issues do not.

Vision, Product Spec and the rest of `adb/01`…`adb/07` are **not** created by setup. They are written in DEFINE. The issue register starts in `adb/07-STATUS.md` for collapsed products; split to `adb/08-OPEN-ISSUES.md` when the list needs its own file.

## What it does

- **Ask** — grill the product, not the user. Research what can be discovered. Offer real choices. `Decide for me` is valid.
- **Decide** — keep a durable source of truth. Small products may collapse to Vision, Product Spec and Status. Larger products use `adb/01` … `adb/08`. Uncertain findings get registered, not swallowed.
- **Build** — execute against that truth. Default: one visible worker; prove on a real path. Missing required behavior is fixed or written down, not ignored.

The full method is in [`SKILL.md`](SKILL.md).

Zum Lesen auf Deutsch: [`ADB-LESEN-DE.html`](ADB-LESEN-DE.html). Agenten folgen nicht dieser Datei — nur `SKILL.md`.
