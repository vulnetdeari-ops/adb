# Method factory

One repository. Two methods. Setup copies files **into each product project** so any harness and any Cloud Agent sees the same rules.

**Small / plain:**

```bash
./Methods/ADB/setup-into-project.sh --plain /path/to/app
```

Writes `AGENTS.md` (copy) and `METHOD: PLAIN`. Read `Rules/LESEN-DE.html`. Agents follow `AGENTS.md` **in the app repo**.

**Large / ADB:**

```bash
./Methods/ADB/setup-into-project.sh /path/to/app
```

Also writes `METHOD: ADB`, `ADB.md` (copy of `SKILL.md`), and `/adb` commands. Read `Methods/ADB/ADB-LESEN-DE.html`. Agents follow `ADB.md` **in the app repo**.

`--refresh` overwrites the copies from the factory.

## Clone

```bash
git clone https://github.com/vulnetdeari-ops/adb.git
cd adb
```

Then run setup on each app (above). `Rules/install-skills.sh` is optional (home links). Apps do not need it.

## Layout

```text
Rules/AGENTS.md        factory — setup copies into the project
Methods/ADB/SKILL.md   factory — setup copies as ADB.md
```
