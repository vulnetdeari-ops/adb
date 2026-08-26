# ADB

**Ask. Decide. Build.**

ADB is a product method for AI coding agents. It asks until the intended product is clear, proposes decisions, then builds. It is not an agent framework, a fake company, or a pile of extra process.

This is not the Android Debug Bridge.

## Use it in a project

1. Copy [`SKILL.md`](SKILL.md) to the project root as `ADB.md`.
2. Add a `METHOD.md` that contains exactly:

```text
METHOD: ADB
```

3. Tell the agent to follow `ADB.md`.
4. Stamp `ADB.md` with `METHOD-VERSION` (see `SKILL.md` point 1A). Keep YAML frontmatter first when the copy has it; the stamp goes on the next line.

Slash commands (`/adb-define`, `/adb-slice`, `/adb-review`, `/adb-status`, `/adb-triage`) live in [`commands/`](commands/). They point at `SKILL.md`; they are not a second method. Install or repair them in Cursor, Codex and Claude with:

```text
./install-commands.sh
```

`./install-commands.sh --check` reports without changing anything. Each harness gets a symlink, so one edit here updates all three.

Do not combine ADB with BMAD.

Defects in the method itself, found by real projects, go in [`LESSONS.md`](LESSONS.md). Ordinary project issues do not.

## What it does

- **Ask** — grill the product, not the user. Research what can be discovered. Offer real choices. `Decide for me` is valid.
- **Decide** — keep a durable source of truth. Small products may collapse to Vision, Product Spec and Status. Larger products use `adb/01` … `adb/08`. Uncertain findings get registered, not swallowed.
- **Build** — execute against that truth. When the harness can delegate, the lead agent stays **orchestra** and workers do heavy slices (see `SKILL.md` points 32 and 32A). Small products stay small. Missing required behavior is fixed or written down, not ignored.

The full method is in [`SKILL.md`](SKILL.md).

Zum Lesen auf Deutsch: [`ADB-LESEN-DE.html`](ADB-LESEN-DE.html). Agenten folgen nicht dieser Datei — nur `SKILL.md`.
