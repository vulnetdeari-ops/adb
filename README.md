# Method factory

One repository. Two methods. **Start** asks with offered letters (A/B/C), then copies files **into each product project** so any harness and any Cloud Agent sees the same rules.

**First run** (clone this repo, open it, say **Start** or `/start`):

The owner picks **any language** (letters for common ones, or they type the name), address, tone, small or large, risk, and the app folder. They do not invent options. Start writes `METHOD.md`, `AGENTS.md`, `OWNER.md`, `LESEN.html` **in that language**, `START.md`, and `/start`. Large also gets `ADB.md` and `/adb` commands. Deutsch and English use shipped pages; any other language is translated from the English page before Start is done.

```bash
# After the interview the agent runs this. You can run it yourself with the same answers:
./Rules/start-into-project.sh \
  --project /path/to/app \
  --language it \
  --address du \
  --tone direct \
  --method plain \
  --risk none \
  --product "Prodotto in questa cartella"
```

`--risk yes` always selects ADB, even if `--method plain`.

**Without the interview** (same copies, no `OWNER.md` / `LESEN.html`):

**Small / plain:**

```bash
./Methods/ADB/setup-into-project.sh --plain /path/to/app
```

Writes `AGENTS.md` (copy), `START.md`, `/start`, and `METHOD: PLAIN`. Factory preview: `Rules/LESEN-DE.html`. Agents follow `AGENTS.md` **in the app repo**.

**Large / ADB:**

```bash
./Methods/ADB/setup-into-project.sh /path/to/app
```

Also writes `METHOD: ADB`, `ADB.md` (copy of `SKILL.md`), and `/adb` commands. Factory preview: `Methods/ADB/ADB-LESEN-DE.html`. Agents follow `ADB.md` **in the app repo**.

`--refresh` overwrites the method copies from the factory (`AGENTS.md`, `ADB.md`, `START.md`). It does not invent new owner answers. Re-run `/start` to change language, tone, or small↔large. `./Rules/start-into-project.sh --lesen-only --project /path/to/app` rebuilds `LESEN.html` from `OWNER.md`.

## Clone

```bash
git clone https://github.com/vulnetdeari-ops/adb.git
cd adb
```

Then **Start**, or run setup on each app (above). `Rules/install-skills.sh` is optional (home links). Apps do not need it.

Daily: open the **app** folder. Cloud Agent: the **app** GitHub repo after the copies are committed.

## Layout

```text
Rules/AGENTS.md              factory — setup copies into the project
Rules/skills/start/SKILL.md  factory — setup copies as START.md
Rules/start-into-project.sh  writes OWNER.md + LESEN.html, then setup
Methods/ADB/SKILL.md         factory — setup copies as ADB.md
```
