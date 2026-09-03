---
name: start
description: "First-run (and re-run) of this method. Offers chip answers, then writes METHOD, copies, OWNER.md and LESEN.html into the app. Use when the owner says start, first run, or there is no METHOD.md."
---

# Start

Canonical: `Rules/skills/start/SKILL.md` in the method factory. Setup copies this file into each product as `START.md`. Follow **that copy** when it exists.

Not ADB itself. Start only **chooses** PLAIN or ADB and lays down files.

Talk, proof, secrets, git, roles: the project’s `AGENTS.md`. Do not contradict it.

**Job:** the owner answers a **fixed** list of questions. Every question offers options (**chips** when clickable, else A/B/C). They never have to invent an option. After the last answer: write files, say what landed and where to read, then they can build. Do not add questions. Do not skip the listed ones unless already answered in this thread.

MainAgent directs. CodeAgent runs `Rules/start-into-project.sh` (factory) and writes nothing by hand that the script already writes.

⸻

## When

Run this when any of:

- The owner says start / first run / setup / Sprache oder Ton wählen / “AGENTS.md fehlt”.
- This folder has no `METHOD.md`, no `AGENTS.md`, or no `OWNER.md`, and they want an app here (not the method factory).
- They want to change language, tone, address, or small↔large (`OWNER.md` already exists: same questions, current values in the options).

`METHOD.md` or `ADB.md` without `AGENTS.md` or without `OWNER.md` is an unfinished first run. Start from Q1. Do **not** call `setup-into-project.sh` instead of asking language.

Do **not** run as a leftover after an ordinary product job.

If this workspace **is** the method factory (`AGENTS.md` at repo root, `Methods/ADB/SKILL.md`, and `Rules/start-into-project.sh`): the app path must be **another** folder. Never write a product `METHOD.md` into the factory.

⸻

## How to ask

One question at a time. Offer **chips** when clickable, else A/B/C. Last option is always **Entscheide du** / Decide for me. Label text: 1–4 words.

If this harness has a native multiple-choice tool that renders clickable chips (Cursor: `AskQuestion`): call it with **one** question and the options below as `options` (`id` = the store key or a short slug, `label` = the chip). Do **not** also print A/B/C.

If that tool is missing: print the question, then lettered options (`A` `B` `C` …) with the same short labels. Last letter = decide-for-me.

Wait for a pick (click, matching label, or letter — map letters in listed order). Then the next question.

Ask **Q1 in the language they already used**. After Q1, ask the rest in the chosen language (decide-for-me → the language they used). Use that language’s option labels.

Do not rephrase options into new products. Do not ask stack, colors, hosting, or “any more questions?”.

The only typed values allowed beyond picking an option:

- A language name, if they pick “Ich tippe die Sprache” / “Type language” (any language: Italiano, Shqip, 日本語, …).
- A folder path, if they pick the type-the-path option.
- One product sentence, if they pick the type-a-sentence option.

If unclear: show the **same options** again, once.

⸻

## Questions (fixed)

### Q1 — Language

Any language. Offer chips so they do not invent a list. Last chip is decide-for-me.

DE: **Welche Sprache?**
EN: **Which language?**
(After this pick, ask Q2–Q7 in that language — same chips and meanings, translated labels.)

Chips:

- `Deutsch` → `de`
- `English` → `en`
- `Shqip` → `sq`
- `Italiano` → `it`
- `Français` → `fr`
- `Español` → `es`
- `Ich tippe die Sprache` / `Type language` → wait for one name (Italiano, 日本語, Polski, …). Not a programming quiz. Map with `Rules/templates/resolve-language.py` (from the factory) or the same names in `Rules/templates/language-tags.txt`. Unknown name → tag `und` and keep their words as `LANGUAGE-NAME`.
- `Entscheide du` / `Decide for me` → language of this thread, mapped the same way (German → `de`, English → `en`, Italian → `it`, …). If you cannot tell: `en`.

Store `LANGUAGE` as the tag (`de`, `it`, `sq`, `ja`, `pt-BR`, `und`, …) and `LANGUAGE-NAME` as the display name (Deutsch, Italiano, 日本語, …).

### Q2 — Address

DE: **Wie sollen wir dich ansprechen?**
EN: **How should we address you?**

Chips:

- `Du` / `Informal you` → `du`
- `Sie` / `Formal` → `sie`
- `Vorname` / `First name` → `name`
- `Entscheide du` / `Decide for me` → `du` if LANGUAGE is `de`, else informal (`du` stored)

Store `ADDRESS=du|sie|name`.

### Q3 — Tone

DE: **Welchen Ton?**
EN: **Which tone?**

Chips:

- `Direkt` / `Direct` → `direct`
- `Ruhig` / `Calm` → `calm`
- `Knapp` / `Short` → `short`
- `Entscheide du` / `Decide for me` → `direct`

Store `TONE=direct|calm|short`.

### Q4 — Small or large

DE: **Was willst du bauen?**
EN: **What are you building?**

Chips:

- `Klein` / `Small` → later `PLAIN` unless Q5 says yes (`SIZE=small`)
- `Groß` / `Large` → `ADB` (`SIZE=large`)
- `Entscheide du` / `Decide for me` → wait for Q5, then: Q5 yes → `ADB`, else `PLAIN` (`SIZE=decide`)

Store `SIZE=small|large|decide`.

### Q5 — Risk

DE: **Geht es um Geld, Login, eine Live-Seite oder Daten von anderen?**
EN: **Money, login, a live site, or other people’s data?**

Chips:

- `Nein` / `No` → `none`
- `Ja` / `Yes` → `yes`
- `Entscheide du` / `Decide for me` → treat as `yes` if SIZE=large, else `none`

Store `RISK=none|yes`.

**Method (script also enforces this):**

- `RISK=yes` → always `METHOD=adb` (even if they picked small). WHY must say that.
- `SIZE=large` and `RISK=none` → `METHOD=adb`
- `SIZE=small` and `RISK=none` → `METHOD=plain`
- `SIZE=decide` and `RISK=none` → `METHOD=plain`
- `SIZE=decide` and `RISK=yes` → `METHOD=adb`

### Q6 — Where

DE: **Wohin die Dateien?**
EN: **Where should the files go?**

If the current folder **is** the method factory, **do not offer This folder**. Offer:

- `Ich tippe den Pfad` / `Type a path`
- `Entscheide du` / `Decide for me` → not allowed on the factory; show the path chip again and say the factory is not an app

If the current folder is **not** the factory:

- `Dieser Ordner` / `This folder`
- `Anderer Pfad` / `Another path`
- `Entscheide du` / `Decide for me` → this folder

If they type a path that does not exist: create it (the script mkdir). Do not send them to the terminal.

Store `PROJECT` as an absolute path.

### Q7 — Product sentence

DE: **Worum geht’s — in einem Satz?** (nicht erfinden müssen)
EN: **What is it, in one sentence?** (they do not have to invent)

Chips:

- `Ich tippe einen Satz` / `Type a sentence` → wait for that sentence
- `Noch kein Satz` / `No sentence` → use “Product in this folder”
- `Entscheide du` / `Decide for me` → same as no sentence

Store `PRODUCT` text. Default (no sentence / decide-for-me): that sentence **in the chosen language** (DE: `Produkt in diesem Ordner`. EN: `Product in this folder`. Any other: translate that EN default; do not invent a product).

⸻

## After the last answer

Do not ask anything else.

Code runs (from the method factory clone):

```bash
./Rules/start-into-project.sh \
  --project "$PROJECT" \
  --language "$LANGUAGE" \
  --language-name "$LANGUAGE_NAME" \
  --address du|sie|name \
  --tone direct|calm|short \
  --method plain|adb \
  --risk none|yes \
  --product "..." \
  --why "..."
```

`--why` in the owner’s language when you already write in it; otherwise English is fine — the TRANSLATE step below must put WHY and the human lines into their language.

If the script fails: show the error, do not invent a manual file layout. If `$PROJECT/AGENTS.md` is missing after a successful-looking run, Start is **not** done.

If the script prints `TRANSLATE: LESEN.html OWNER.md → …` (no native template for that language; de and en have templates): **Start is not done yet.** Code translates:

1. `LESEN.html` — every visible heading and paragraph into `LANGUAGE-NAME`. Keep HTML structure. Keep `<code>` text, slash commands, and file names (`AGENTS.md`, `OWNER.md`, `/start`, `/adb`, …) untranslated. Set `<html lang="{LANGUAGE}">`. Remove the `TRANSLATE-TO` comment.
2. `OWNER.md` — keep the `LANGUAGE:` / `ADDRESS:` / … keys in English. Translate `WHY` and the human sentences. Set `TRANSLATE: no`. `LANGUAGE-NAME` stays their name.

Do not add or drop method rules while translating. Then tell the owner, in their language:

1. **Which method** and **why** (one line).
2. **Which files** landed (names, not a tour).
3. Open **`LESEN.html` in the app folder** — that page says what they do, what the system can do, and how to go on.
4. Daily: open the **app** folder in this harness, not the factory. Cloud Agent: the **app** GitHub repo after those copies are committed.

Then they can give the first product job. Start does not invent that job.

Re-run: same seven questions. The script overwrites `OWNER.md` and `LESEN.html`. Switching small→large or large→small is allowed; Start passes `--switch` so setup writes `METHOD.md` to match and (on PLAIN) removes `ADB.md` and `/adb` commands. `risk=yes` forces ADB the same way. `--refresh` on setup still updates `AGENTS.md` / `ADB.md` / `START.md` from the factory; it does not invent new owner answers and does not switch the method.

⸻

## Decide-for-me (do not improvise)

| Question | Decide-for-me |
|---|---|
| Q1 | Thread language via the same map (Deutsch→`de`, Italiano→`it`, …). Unclear → `en` |
| Q2 | `du` if `de`, else informal you (`du` stored) |
| Q3 | `direct` |
| Q4 | Let Q5 choose |
| Q5 | `yes` if Q4 was large, else `none` |
| Q6 | This folder if it is not the factory; else they must type a path |
| Q7 | Default sentence in the chosen language |
