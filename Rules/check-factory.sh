#!/usr/bin/env bash
# Prove this clone is a usable method factory. Exit 0 only if Start can lay AGENTS.md.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail() { echo "FAIL: $*" >&2; exit 1; }

[ -f AGENTS.md ] || fail "root AGENTS.md missing"
[ -f Rules/start-into-project.sh ] || fail "Rules/start-into-project.sh missing"
[ -f Rules/skills/start/SKILL.md ] || fail "Start skill missing"
[ -f Methods/ADB/SKILL.md ] || fail "ADB SKILL.md missing"
[ -x Methods/ADB/setup-into-project.sh ] || fail "setup-into-project.sh missing or not executable"
[ -x Rules/start-into-project.sh ] || fail "start-into-project.sh not executable"

head -1 AGENTS.md | grep -qx '# Agent rules' || fail "root AGENTS.md must be the product rules (# Agent rules)"
grep -q 'MainAgent' AGENTS.md || fail "root AGENTS.md is not the product rules"
grep -q 'Chips, not A/B/C' AGENTS.md || fail "AGENTS.md must offer chips, not A/B/C"
grep -q 'Offer \*\*chips\*\*' Rules/skills/start/SKILL.md || fail "Start skill must offer chips"
grep -q 'This folder is the method factory' AGENTS.md && fail "root AGENTS.md is still the old pointer"

if grep -q 'MainAgent' Rules/AGENTS.md 2>/dev/null; then
  :
else
  grep -q '\.\./AGENTS.md' Rules/AGENTS.md || fail "Rules/AGENTS.md should point at ../AGENTS.md"
fi

# Refuse Start against the factory
ERR="$(mktemp)"
if Rules/start-into-project.sh --project "$ROOT" --language de --address du --tone direct --method plain --risk none --product "x" >/dev/null 2>"$ERR"; then
  rm -f "$ERR"
  fail "Start must refuse the factory folder"
fi
grep -qi 'factory' "$ERR" || { cat "$ERR" >&2; rm -f "$ERR"; fail "Start refusal did not mention factory"; }
rm -f "$ERR"

APP="$(mktemp -d)"
Rules/start-into-project.sh \
  --project "$APP" \
  --language de \
  --address du \
  --tone direct \
  --method adb \
  --risk none \
  --product "Factory check" >/dev/null

[ -s "$APP/AGENTS.md" ] || fail "Start did not write AGENTS.md"
[ -s "$APP/OWNER.md" ] || fail "Start did not write OWNER.md"
[ -s "$APP/LESEN.html" ] || fail "Start did not write LESEN.html"
[ -s "$APP/ADB.md" ] || fail "Start did not write ADB.md"
grep -q '^METHOD-VERSION:' "$APP/AGENTS.md" || fail "app AGENTS.md has no METHOD-VERSION"
head -1 "$APP/AGENTS.md" | grep -q '^METHOD-VERSION:' || fail "app AGENTS.md stamp is not first line"
grep -q 'MainAgent' "$APP/AGENTS.md" || fail "app AGENTS.md is not the product rules"
grep -q '^LANGUAGE: de' "$APP/OWNER.md" || fail "OWNER.md language was not stored"
grep -qx 'METHOD: ADB' "$APP/METHOD.md" || fail "METHOD.md is not ADB"

rm -rf "$APP"
echo "OK: factory can Start; app gets AGENTS.md"
