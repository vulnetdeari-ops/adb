# _System

Ein Repo. Zwei Methoden. Clone nach `~/Development/_System`.

**Klein / normal:** `Rules/AGENTS.md`. Du liest `Rules/LESEN-DE.html`. Agenten folgen `AGENTS.md`, nicht der HTML-Datei. Kein ADB.

**Groß:** Im Projekt eine Datei `METHOD.md` mit genau:

```text
METHOD: ADB
```

Dann gilt `Methods/ADB` (Ask. Decide. Build.). Du liest `Methods/ADB/ADB-LESEN-DE.html`. Agenten folgen der Projekt-Kopie `ADB.md`.

## Einmal auf den Mac

```bash
# bestehendes ~/Development/_System umbenennen, dann:
git clone https://github.com/vulnetdeari-ops/adb.git ~/Development/_System
cd ~/Development/_System/Rules
./install-skills.sh
```

Große App danach:

```bash
~/Development/_System/Methods/ADB/setup-into-project.sh /pfad/zur/app
```

`new-project` / `adopt-project` sind Mac-Helfer außerhalb dieses Repos. Fehlen sie: `setup-into-project.sh` reicht für ADB.

## Install

```bash
# normale Methode in Cursor / Codex / Claude / Gemini
./Rules/install-skills.sh
./Rules/install-skills.sh --check

# ADB-Befehle in ein Produktprojekt: setup-into-project.sh (Kopien, nie nach $HOME)
```

## Layout

```text
Rules/                 normale Methode (BubbyOS)
  AGENTS.md            Agenten folgen dieser Datei
  LESEN-DE.html        nur zum Lesen
  install-skills.sh
  skills/
Methods/ADB/           große Apps, nur mit METHOD: ADB
```
