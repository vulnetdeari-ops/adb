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

3. Tell the agent to follow `ADB.md`.
4. Stamp `ADB.md` with `METHOD-VERSION` (see `SKILL.md` point 1A). Keep YAML frontmatter first when the copy has it; the stamp goes on the next line.
5. Ensure the issue register is `adb/08-OPEN-ISSUES.md` (not a root `OPEN-ISSUES.md`).
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
```

`setup-into-project.sh` copies/stamps `ADB.md`, creates `adb/08-OPEN-ISSUES.md` if missing, and runs `install-commands.sh` for that project.

Slash commands (`/adb-define`, `/adb-slice`, `/adb-review`, `/adb-status`, `/adb-triage`) live in [`commands/`](commands/). They point at `SKILL.md`; they are not a second method.

```text
./install-commands.sh                 # into the current project only
./install-commands.sh --check
./install-commands.sh --remove-global # delete leftover home-level installs
```

Do not combine ADB with BMAD.

Defects in the method itself, found by real projects, go in [`LESSONS.md`](LESSONS.md). Ordinary project issues do not.

Vision, Product Spec and the rest of `adb/01`…`adb/07` are **not** created by setup. They are written in DEFINE. Only the issue register is prepared so agents have one honest place to write.

## What it does

- **Ask** — grill the product, not the user. Research what can be discovered. Offer real choices. `Decide for me` is valid.
- **Decide** — keep a durable source of truth. Small products may collapse to Vision, Product Spec and Status. Larger products use `adb/01` … `adb/08`. Uncertain findings get registered, not swallowed.
- **Build** — execute against that truth. When the harness can delegate, the lead agent stays **Chef** and workers do heavy slices (see `SKILL.md` points 32 and 32A). Small products stay small. Missing required behavior is fixed or written down, not ignored.

The full method is in [`SKILL.md`](SKILL.md).

Zum Lesen auf Deutsch: [`ADB-LESEN-DE.html`](ADB-LESEN-DE.html). Agenten folgen nicht dieser Datei — nur `SKILL.md`.
