---
name: adb
description: "Ask. Decide. Build. Entry point when the user invokes /adb on an ADB project."
---

# /adb

Canonical method: `ADB.md` in the project root (or `~/Development/_System/Methods/ADB/SKILL.md`).

If `METHOD.md` does not contain `METHOD: ADB`, stop and ask whether to activate ADB on this project.

Otherwise:

1. Read `adb/07-STATUS.md` when it exists. If PHASE is DEFINE or STATUS is missing, run `/adb-define`.
2. If PHASE is BUILD and the user asked for status or progress, run `/adb-status`.
3. Otherwise ask once what they want next: continue DEFINE, start or continue a slice, review, triage issues, or status — then run the matching command.

Do not invent a sixth workflow. The five phase commands are `/adb-define`, `/adb-slice`, `/adb-review`, `/adb-status`, and `/adb-triage`.
