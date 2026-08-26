#!/usr/bin/env bash
# ADB — finish project setup that new-project / adopt-project leave for ADB.
#
# Run from any shell. Required: path to the target project directory.
#
# Does, idempotently:
#   1. Ensure ADB.md exists (copy from this repo's SKILL.md if missing)
#   2. Stamp METHOD-VERSION (P1A) after frontmatter when present
#   3. Ensure adb/08-OPEN-ISSUES.md exists (ADB register; not root OPEN-ISSUES.md)
#   4. Install slash commands into the project (never into $HOME)
#
# Usage:
#   ./setup-into-project.sh /path/to/project
#   ./setup-into-project.sh --check /path/to/project
#
# Exit 0 on success. Prints changed paths, one per line, prefixed with CHANGED:
# so callers can stage them.

set -euo pipefail

ADB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL="$ADB_ROOT/SKILL.md"
INSTALLER="$ADB_ROOT/install-commands.sh"

CHECK=0
PROJECT=""

for arg in "$@"; do
  case "$arg" in
    --check) CHECK=1 ;;
    -*) echo "unknown argument: $arg" >&2; exit 2 ;;
    *)
      if [ -n "$PROJECT" ]; then
        echo "unexpected extra argument: $arg" >&2
        exit 2
      fi
      PROJECT=$arg
      ;;
  esac
done

[ -n "$PROJECT" ] || { echo "usage: $0 [--check] /path/to/project" >&2; exit 2; }
[ -d "$PROJECT" ] || { echo "not a directory: $PROJECT" >&2; exit 1; }
[ -f "$SKILL" ] || { echo "SKILL.md missing: $SKILL" >&2; exit 1; }
[ -x "$INSTALLER" ] || { echo "install-commands.sh missing or not executable: $INSTALLER" >&2; exit 1; }

PROJECT="$(cd "$PROJECT" && pwd -P)"
sha="$(git -C "$ADB_ROOT" rev-parse --short HEAD 2>/dev/null || echo unknown)"
day="$(date +%Y-%m-%d)"
stamp="METHOD-VERSION: ${sha} ${day}"

note_changed() {
  printf 'CHANGED: %s\n' "$1"
}

# --- 1. ADB.md ---
adb_md="$PROJECT/ADB.md"
if [ ! -f "$adb_md" ]; then
  if [ $CHECK -eq 1 ]; then
    echo "WOULD CREATE $adb_md"
  else
    cp "$SKILL" "$adb_md"
    note_changed "ADB.md"
  fi
fi

# --- 2. METHOD-VERSION stamp (P1A) ---
# Only the header stamp counts. SKILL.md also documents the format later in
# the body ("METHOD-VERSION: <short git sha…>"); never rewrite that example.
stamp_adb_md() {
  local file="$1"
  local tmp
  tmp="$(mktemp)"

  awk -v stamp="$stamp" '
    BEGIN { fm=0; past_header=0; has_header_stamp=0; stamped=0 }
    NR==1 && $0=="---" { fm=1; print; next }
    fm==1 {
      print
      if ($0=="---") fm=0
      next
    }
    !past_header && /^METHOD-VERSION:/ {
      print stamp
      has_header_stamp=1
      stamped=1
      next
    }
    !past_header && /^# / {
      if (!has_header_stamp && !stamped) {
        print stamp
        print ""
        stamped=1
      }
      past_header=1
      print
      next
    }
    { print }
    END {
      if (!stamped && !past_header) {
        print ""
        print stamp
      }
    }
  ' "$file" > "$tmp"

  if cmp -s "$file" "$tmp"; then
    rm -f "$tmp"
    return 1
  fi
  if [ $CHECK -eq 1 ]; then
    rm -f "$tmp"
    return 0
  fi
  mv "$tmp" "$file"
  return 0
}

if [ -f "$adb_md" ]; then
  if stamp_adb_md "$adb_md"; then
    if [ $CHECK -eq 1 ]; then
      echo "WOULD STAMP $adb_md ($stamp)"
    else
      note_changed "ADB.md"
    fi
  fi
fi

# --- 3. Issue register: adb/08-OPEN-ISSUES.md ---
mkdir_adb=0
[ -d "$PROJECT/adb" ] || mkdir_adb=1
register="$PROJECT/adb/08-OPEN-ISSUES.md"

write_register() {
  cat > "$1" <<'EOF'
# Open Issues

CANONICAL: This file (`adb/08-OPEN-ISSUES.md`)

Record real unresolved complaints, bugs, regressions, UX or design defects, data problems, specification conflicts, and failing critical behavior here. Remove an entry only after its fix is tested and verified.

Never record secrets, private data, or actionable vulnerability details in this tracked file. Use an explicitly private channel for sensitive security reports.

OPEN: 0 · READY FOR VERIFY: 0 · CRITICAL: 0 · HIGH: 0 · MEDIUM: 0 · LOW: 0 · CLOSED: 0

Closed issues stay in this file and stay traceable (P49).

CARRIED counts status reviews survived while OPEN (P25, P50A). At CARRIED: 3 an issue must exit OPEN by FIX, ACCEPT or REJECT — there is no fourth carry.
EOF
}

if [ ! -f "$register" ]; then
  if [ $CHECK -eq 1 ]; then
    [ $mkdir_adb -eq 1 ] && echo "WOULD CREATE $PROJECT/adb/"
    echo "WOULD CREATE $register"
  else
    mkdir -p "$PROJECT/adb"
    write_register "$register"
    note_changed "adb/08-OPEN-ISSUES.md"
  fi
fi

# If a root OPEN-ISSUES.md still claims to be canonical and 08 is empty of bodies,
# leave migration to adopt-project (it has the full file context). This script
# never deletes the root file on its own.

# --- 4. Slash commands into the project ---
list_cmd_links() {
  (cd "$PROJECT" && find .cursor/commands .claude/commands .codex/prompts -name 'adb-*.md' 2>/dev/null | sed 's|^\./||' | sort || true)
}

if [ $CHECK -eq 1 ]; then
  (cd "$PROJECT" && "$INSTALLER" --check) || true
else
  before="$(list_cmd_links)"
  (cd "$PROJECT" && "$INSTALLER") >/dev/null
  after="$(list_cmd_links)"
  if [ "$before" != "$after" ]; then
    printf '%s\n' "$after" | while IFS= read -r rel; do
      [ -n "$rel" ] || continue
      note_changed "$rel"
    done
  fi
fi

echo "ADB setup into project: $PROJECT"
echo "METHOD-VERSION target: $stamp"
