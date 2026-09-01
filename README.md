# _System

Ein Repo. Zwei Methoden. In jedes **Produktprojekt** kommen **Kopien** — damit Cloud-Agents dieselben Dateien sehen wie auf dem Mac.

**Klein / normal:**

```bash
~/Development/_System/Methods/ADB/setup-into-project.sh --plain /pfad/zur/app
```

Das legt `AGENTS.md` (Kopie) und `METHOD: PLAIN` an. Du liest `Rules/LESEN-DE.html`. Agenten folgen der `AGENTS.md` **im App-Repo**.

**Groß:**

```bash
~/Development/_System/Methods/ADB/setup-into-project.sh /pfad/zur/app
```

Zusätzlich `METHOD: ADB`, `ADB.md` (Kopie von `SKILL.md`) und `/adb`-Befehle. Du liest `Methods/ADB/ADB-LESEN-DE.html`. Agenten folgen `ADB.md` **im App-Repo**.

`--refresh` überschreibt die Kopien aus der Fabrik, wenn du die Methode aktualisieren willst.

## Einmal auf den Mac

```bash
git clone https://github.com/vulnetdeari-ops/adb.git ~/Development/_System
```

Dann Setup in jede App (oben). `install-skills.sh` ist optional (Home-Symlinks auf dem Mac). Die App braucht das nicht.

## Layout

```text
Rules/AGENTS.md        Fabrik — Setup kopiert sie ins Projekt
Methods/ADB/SKILL.md   Fabrik — Setup kopiert sie als ADB.md
```
