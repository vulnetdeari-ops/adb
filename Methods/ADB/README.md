# ADB

**Ask. Decide. Build.**

ADB is a product method for AI coding agents. The owner sets where the product must land. Roles follow the project’s `AGENTS.md` (setup copy): the owner talks only to MainAgent; on ADB, PlanAgent, CodeAgent and ReviewAgent are required subagents. It is not an agent framework, a fake company, or a pile of extra process.

This is not the Android Debug Bridge.

The method is [`SKILL.md`](SKILL.md). Setup copies it into each project as `ADB.md`, and copies `Rules/AGENTS.md` as `AGENTS.md`. **Start** (`/start`, `Rules/skills/start/SKILL.md`) chooses PLAIN vs ADB with offered letters and writes `OWNER.md` + `LESEN.html`. Agents in a project follow those copies.

## Use it in a project

1. Add a `METHOD.md` that contains exactly:

```text
METHOD: ADB
```

2. Install slash commands **into that project** as copies, never into the user home.
3. Tell the agent to follow the project’s `ADB.md` when `METHOD.md` contains `METHOD: ADB`. If `METHOD.md` is missing or `PLAIN`, do not load ADB (follow `AGENTS.md` only).
4. Issue register: for **collapsed** Source of Truth (default for small products), issues live in `adb/07-STATUS.md` under `## Open issues` — setup does **not** create `adb/08-OPEN-ISSUES.md`. Create `08` only when the list outgrows STATUS, or run `./setup-into-project.sh --register`. Never use a root `OPEN-ISSUES.md`.

```text
./Rules/start-into-project.sh --project /path/to/project --language de --address du --tone direct --method adb --risk none --product "..."
./setup-into-project.sh /path/to/project              # AGENTS.md + START.md + ADB
./setup-into-project.sh --plain /path/to/project      # AGENTS.md + START.md only
./setup-into-project.sh --check /path/to/project
./setup-into-project.sh --refresh /path/to/project    # overwrite copies from factory
./setup-into-project.sh --register /path/to/project   # optional: create adb/08-OPEN-ISSUES.md
```

`setup-into-project.sh` copies `Rules/AGENTS.md` to project `AGENTS.md` (stamped `METHOD-VERSION`). Without `--plain` it also creates `METHOD.md` when missing, **copies `SKILL.md` to `ADB.md`**, **replaces leftover `METHOD: BMAD`**, installs slash commands as **copies**, **removes leftover BMAD engine files** (`_bmad/`, `.bmad-core/`, `.bmad-*`, BMAD-named commands/rules/skills, BMAD `core-config.yaml`), and **does not** create `adb/08-OPEN-ISSUES.md` unless you pass `--register`. `--plain` writes `METHOD: PLAIN` and skips ADB. It does **not** delete BMAD planning leftovers such as `_bmad-output/` or an old PRD — those are brownfield evidence for DEFINE, not the method. If a copy is older than the factory file, setup reports `STALE` and does not stamp; `--refresh` updates copies (and commands, when ADB).

Slash commands (`/adb`, `/adb-define`, `/adb-slice`, `/adb-review`, `/adb-status`, `/adb-triage`, `/adb-ready`) live in [`commands/`](commands/). They point at the project’s `ADB.md`; they are not a second method.

Inside this repository, `.cursor/commands/`, `.claude/commands/` and `.codex/prompts/` are **symlinks** into `commands/`. There is one copy to edit.

```text
./install-commands.sh                 # install into the current directory
./install-commands.sh --check         # report only
./install-commands.sh --remove        # remove from the current directory
./install-commands.sh --remove-global # delete leftover home-level installs
```

Do not load another product method on top of ADB. **BMAD is retired.** Do not follow leftover BMAD agents, commands, or `_bmad/` files. Ignore a leftover `METHOD: BMAD` — setup replaces it with `METHOD: ADB`.

Defects in the method itself, found by real projects, go in [`LESSONS.md`](LESSONS.md). Ordinary project issues do not.

Vision, Product Spec and the rest of `adb/01`…`adb/07` are **not** created by setup. They are written in DEFINE. The issue register starts in `adb/07-STATUS.md` for collapsed products; split to `adb/08-OPEN-ISSUES.md` when the list needs its own file.

## What it does

- **Ask** — grill the product, not the user. Research what can be discovered. Offer real choices. `Decide for me` is valid.
- **Decide** — keep that in `adb/`. Small products may collapse to Vision, Product Spec and Status. Larger products use `adb/01` … `adb/08`. Uncertain findings get registered, not swallowed.
- **Build** — CodeAgent executes against `adb/` (MainAgent directs). Prove on a real path (browser, tests, logins). Missing required behavior is fixed or written down, not ignored. Git: AGENTS.md (auto-commit when the job is done; push only when the owner asks).

The full method is in [`SKILL.md`](SKILL.md).

Zum Lesen auf Deutsch: [`ADB-LESEN-DE.html`](ADB-LESEN-DE.html). Agenten in einem Projekt folgen `ADB.md` — nicht dieser Datei.
