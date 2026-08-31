#!/usr/bin/env bash
# ADB — finish project setup that new-project / adopt-project leave for ADB.
#
# Does, idempotently:
#   1. Ensure METHOD.md contains METHOD: ADB when missing; replace leftover METHOD: BMAD
#   2. Remove leftover BMAD engine files (BMAD is retired). Keep planning docs as evidence.
#   3. Install slash commands into the project (never into $HOME)
#   4. Optionally ensure adb/08-OPEN-ISSUES.md (--register only; collapsed default is STATUS)
#   5. --refresh: reinstall commands; remove leftover project ADB.md (method is SKILL.md)
#
# Does not copy SKILL.md into the project.
#
# Usage:
#   ./setup-into-project.sh /path/to/project
#   ./setup-into-project.sh --check /path/to/project
#   ./setup-into-project.sh --refresh /path/to/project
#   ./setup-into-project.sh --register /path/to/project
#
# Exit 0 on success. Prints changed paths, one per line, prefixed with CHANGED:

set -euo pipefail

ADB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER="$ADB_ROOT/install-commands.sh"

CHECK=0
REFRESH=0
REGISTER=0
PROJECT=""

for arg in "$@"; do
  case "$arg" in
    --check) CHECK=1 ;;
    --refresh) REFRESH=1 ;;
    --register) REGISTER=1 ;;
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

[ -n "$PROJECT" ] || { echo "usage: $0 [--check] [--refresh] [--register] /path/to/project" >&2; exit 2; }
[ -d "$PROJECT" ] || { echo "not a directory: $PROJECT" >&2; exit 1; }
[ -x "$INSTALLER" ] || { echo "install-commands.sh missing or not executable: $INSTALLER" >&2; exit 1; }

PROJECT="$(cd "$PROJECT" && pwd -P)"

note_changed() {
  printf 'CHANGED: %s\n' "$1"
}

# --- METHOD.md ---
method_md="$PROJECT/METHOD.md"
if [ ! -f "$method_md" ]; then
  if [ $CHECK -eq 1 ]; then
    echo "WOULD CREATE $method_md (METHOD: ADB)"
  else
    printf '%s\n' 'METHOD: ADB' > "$method_md"
    note_changed "METHOD.md"
  fi
elif grep -qiE '^METHOD:[[:space:]]*BMAD[[:space:]]*$' "$method_md" 2>/dev/null; then
  if [ $CHECK -eq 1 ]; then
    echo "WOULD REPLACE leftover METHOD: BMAD → METHOD: ADB in $method_md"
  else
    printf '%s\n' 'METHOD: ADB' > "$method_md"
    note_changed "METHOD.md"
  fi
elif ! grep -qx 'METHOD: ADB' "$method_md" 2>/dev/null; then
  echo "WARN: $method_md exists but does not contain METHOD: ADB — not overwriting." >&2
fi

# --- Leftover project ADB.md (not the method) ---
adb_md="$PROJECT/ADB.md"
if [ -f "$adb_md" ]; then
  if [ $REFRESH -eq 1 ]; then
    if [ $CHECK -eq 1 ]; then
      echo "WOULD REMOVE leftover $adb_md"
    else
      rm -f "$adb_md"
      note_changed "ADB.md"
    fi
  elif [ $CHECK -eq 1 ]; then
    echo "NOTE: leftover $adb_md — method is SKILL.md in the ADB repo; ignore or pass --refresh to remove."
  else
    echo "NOTE: leftover $adb_md — not the method. Pass --refresh to remove."
  fi
fi

# --- Leftover BMAD engine (retired). Planning docs stay as brownfield evidence. ---
remove_bmad_path() {
  local rel="$1"
  local path="$PROJECT/$rel"
  if [ ! -e "$path" ] && [ ! -L "$path" ]; then
    return 0
  fi
  if [ $CHECK -eq 1 ]; then
    echo "WOULD REMOVE leftover BMAD $path"
    return 0
  fi
  rm -rf "$path"
  note_changed "$rel"
}

is_bmad_core_config() {
  local f="$1"
  [ -f "$f" ] || return 1
  grep -qiE 'bmad-core|markdownExploder|prdFile|bmad_version|bmad-method|_bmad/' "$f"
}

for rel in _bmad .bmad bmad-agent bmad.config.yaml bmad-config.yaml bmad.config.js; do
  remove_bmad_path "$rel"
done

shopt -s nullglob
for path in "$PROJECT"/.bmad-*; do
  remove_bmad_path "${path#"$PROJECT"/}"
done
shopt -u nullglob

bmad_harness_roots=(
  ".cursor/commands"
  ".claude/commands"
  ".codex/prompts"
  ".cursor/rules"
  ".cursor/skills"
  ".claude/skills"
  ".codex/skills"
)
for root in "${bmad_harness_roots[@]}"; do
  [ -d "$PROJECT/$root" ] || continue
  while IFS= read -r -d '' path; do
    remove_bmad_path "${path#"$PROJECT"/}"
  done < <(find "$PROJECT/$root" -maxdepth 1 \( -iname '*bmad*' \) -print0)
done

if is_bmad_core_config "$PROJECT/core-config.yaml"; then
  remove_bmad_path "core-config.yaml"
fi

# --- Issue register (optional) ---
register="$PROJECT/adb/08-OPEN-ISSUES.md"

write_register() {
  cat > "$1" <<'EOF'
# Open Issues

CANONICAL: This file (`adb/08-OPEN-ISSUES.md`)

Record real unresolved complaints, bugs, regressions, UX or design defects, data problems, specification conflicts, and failing critical behavior here.

Never record secrets, private data, or actionable vulnerability details in this tracked file. Use an explicitly private channel for sensitive security reports.

OPEN: 0

Closed issues stay in this file and stay traceable (SKILL.md Issues). Mark CLOSED only after the fix is tested and verified. Do not close by deleting the entry.

CARRIED: at 3 an issue must leave OPEN by FIX, ACCEPT or REJECT (SKILL.md Issues).
EOF
}

if [ $REGISTER -eq 1 ]; then
  if [ ! -f "$register" ]; then
    if [ $CHECK -eq 1 ]; then
      echo "WOULD CREATE $PROJECT/adb/"
      echo "WOULD CREATE $register"
    else
      mkdir -p "$PROJECT/adb"
      write_register "$register"
      note_changed "adb/08-OPEN-ISSUES.md"
    fi
  fi
elif [ $CHECK -eq 1 ] && [ ! -f "$register" ]; then
  echo "NOTE: no adb/08-OPEN-ISSUES.md — expected for collapsed Source of Truth (issues in adb/07-STATUS.md). Pass --register to create the file."
fi

# --- Slash commands ---
list_cmd_links() {
  (cd "$PROJECT" && find .cursor/commands .claude/commands .codex/prompts -name 'adb*.md' 2>/dev/null | sed 's|^\./||' | sort || true)
}

list_cmd_link_targets() {
  (cd "$PROJECT" && find .cursor/commands .claude/commands .codex/prompts -name 'adb*.md' -type l 2>/dev/null \
    | while IFS= read -r rel; do
        [ -n "$rel" ] || continue
        printf '%s -> %s\n' "$rel" "$(readlink "$rel" 2>/dev/null || echo '?')"
      done | sort || true)
}

if [ $CHECK -eq 1 ]; then
  (cd "$PROJECT" && "$INSTALLER" --check) || true
else
  before_paths="$(list_cmd_links)"
  before_targets="$(list_cmd_link_targets)"
  (cd "$PROJECT" && "$INSTALLER") >/dev/null
  after_paths="$(list_cmd_links)"
  after_targets="$(list_cmd_link_targets)"
  if [ "$before_paths" != "$after_paths" ] || [ "$before_targets" != "$after_targets" ]; then
    printf '%s\n' "$after_paths" | while IFS= read -r rel; do
      [ -n "$rel" ] || continue
      note_changed "$rel"
    done
  fi
fi

echo "ADB setup into project: $PROJECT"
echo "Method: $ADB_ROOT/SKILL.md"
