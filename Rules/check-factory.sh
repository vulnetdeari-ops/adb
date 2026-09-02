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
if grep -q 'A) BUILD' Methods/ADB/commands/adb-define.md; then
  fail "adb-define still offers A) B) C)"
fi
if grep -q 'offers letters' Rules/start-into-project.sh; then
  fail "start-into-project.sh header still says letters"
fi
if grep -q 'I will type' Rules/skills/start/SKILL.md; then
  fail "Start English chips still over 4 words"
fi
if grep -rniE '\bbmad\b' --include='*.md' --include='*.html' .; then
  fail "method text still names a former method"
fi
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

has_adb_commands() {
  local root="$1" f
  for f in \
    "$root/.cursor/commands"/adb.md \
    "$root/.cursor/commands"/adb-*.md \
    "$root/.claude/commands"/adb.md \
    "$root/.claude/commands"/adb-*.md \
    "$root/.codex/prompts"/adb.md \
    "$root/.codex/prompts"/adb-*.md
  do
    [ -e "$f" ] && return 0
  done
  return 1
}

assert_adb_app() {
  local root="$1" why="$2"
  [ -s "$root/AGENTS.md" ] || fail "$why: AGENTS.md missing"
  [ -s "$root/START.md" ] || fail "$why: START.md missing"
  [ -s "$root/ADB.md" ] || fail "$why: ADB.md missing"
  grep -qx 'METHOD: ADB' "$root/METHOD.md" || fail "$why: METHOD.md is not ADB"
  has_adb_commands "$root" || fail "$why: /adb commands missing"
  [ -f "$root/.cursor/commands/start.md" ] || fail "$why: /start command missing"
  if [ -f "$root/OWNER.md" ]; then
    grep -q '^METHOD: ADB' "$root/OWNER.md" || fail "$why: OWNER.md METHOD is not ADB"
  fi
  if [ -f "$root/LESEN.html" ]; then
    grep -q 'Große Methode' "$root/LESEN.html" || fail "$why: LESEN.html is not ADB"
  fi
}

assert_plain_app() {
  local root="$1" why="$2"
  [ -s "$root/AGENTS.md" ] || fail "$why: AGENTS.md missing"
  [ -s "$root/START.md" ] || fail "$why: START.md missing"
  grep -qx 'METHOD: PLAIN' "$root/METHOD.md" || fail "$why: METHOD.md is not PLAIN"
  [ ! -e "$root/ADB.md" ] || fail "$why: leftover ADB.md"
  if has_adb_commands "$root"; then
    fail "$why: leftover /adb commands"
  fi
  [ -f "$root/.cursor/commands/start.md" ] || fail "$why: /start command missing"
  if [ -f "$root/OWNER.md" ]; then
    grep -q '^METHOD: PLAIN' "$root/OWNER.md" || fail "$why: OWNER.md METHOD is not PLAIN"
  fi
  if [ -f "$root/LESEN.html" ]; then
    grep -q 'Kleine Methode' "$root/LESEN.html" || fail "$why: LESEN.html is not PLAIN"
  fi
}

start_into() {
  local root="$1" method="$2" risk="$3"
  Rules/start-into-project.sh \
    --project "$root" \
    --language de \
    --address du \
    --tone direct \
    --method "$method" \
    --risk "$risk" \
    --product "Factory check" >/dev/null
}

APP="$(mktemp -d)"
PLAIN_APP="$(mktemp -d)"
SETUP_PLAIN="$(mktemp -d)"
RISK_APP="$(mktemp -d)"
trap 'rm -rf "$APP" "$PLAIN_APP" "$SETUP_PLAIN" "$RISK_APP"' EXIT

start_into "$APP" adb none
assert_adb_app "$APP" "Start ADB"
mkdir -p "$APP/adb"
printf '%s\n' '# Vision' > "$APP/adb/01-VISION.md"
[ -s "$APP/OWNER.md" ] || fail "Start did not write OWNER.md"
[ -s "$APP/LESEN.html" ] || fail "Start did not write LESEN.html"
grep -q '^METHOD-VERSION:' "$APP/AGENTS.md" || fail "app AGENTS.md has no METHOD-VERSION"
head -1 "$APP/AGENTS.md" | grep -q '^METHOD-VERSION:' || fail "app AGENTS.md stamp is not first line"
grep -q 'MainAgent' "$APP/AGENTS.md" || fail "app AGENTS.md is not the product rules"
grep -q '^LANGUAGE: de' "$APP/OWNER.md" || fail "OWNER.md language was not stored"
if grep -qiE '\bbmad\b' "$APP/LESEN.html" "$APP/AGENTS.md" "$APP/ADB.md" "$APP/START.md"; then
  fail "app copies still name a former method"
fi

start_into "$PLAIN_APP" plain none
assert_plain_app "$PLAIN_APP" "Start PLAIN"
[ -s "$PLAIN_APP/OWNER.md" ] || fail "PLAIN Start did not write OWNER.md"
grep -q '^METHOD: PLAIN' "$PLAIN_APP/OWNER.md" || fail "PLAIN OWNER.md METHOD is not PLAIN"

Methods/ADB/setup-into-project.sh --plain "$SETUP_PLAIN" >/dev/null
assert_plain_app "$SETUP_PLAIN" "setup --plain"
[ ! -f "$SETUP_PLAIN/OWNER.md" ] || fail "setup-without-interview wrote OWNER.md"

start_into "$APP" plain none
assert_plain_app "$APP" "Start flip to PLAIN"
[ -f "$APP/adb/01-VISION.md" ] || fail "PLAIN cleanup deleted product adb/"

start_into "$APP" adb none
assert_adb_app "$APP" "Start flip to ADB"

start_into "$RISK_APP" plain yes
assert_adb_app "$RISK_APP" "risk=yes from PLAIN"
grep -q '^METHOD: ADB' "$RISK_APP/OWNER.md" || fail "risk=yes OWNER.md METHOD is not ADB"

NO_SWITCH="$(mktemp)"
Methods/ADB/setup-into-project.sh --plain "$APP" >/dev/null 2>"$NO_SWITCH"
assert_adb_app "$APP" "setup --plain without Start stays ADB"
grep -qi 'not switching' "$NO_SWITCH" || fail "setup --plain on ADB without Start should warn"
[ -f "$APP/adb/01-VISION.md" ] || fail "setup --plain without Start deleted product adb/"

Methods/ADB/setup-into-project.sh --refresh "$PLAIN_APP" >/dev/null 2>"$NO_SWITCH"
assert_plain_app "$PLAIN_APP" "--refresh without --plain stays PLAIN"
grep -qi 'not switching' "$NO_SWITCH" || fail "--refresh on PLAIN without Start should warn"
rm -f "$NO_SWITCH"

echo "OK: factory can Start; PLAIN, risk=yes, and METHOD flips match"
