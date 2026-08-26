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
#   5. Ensure METHOD.md contains METHOD: ADB when missing
#
# The stamp must never claim a version the file body does not have (P1A). When an
# existing ADB.md body differs from SKILL.md, this script reports STALE and skips
# stamping. Use --refresh to overwrite the body, which is a deliberate act because
# a project may stay on an older method version on purpose.
#
# Usage:
#   ./setup-into-project.sh /path/to/project
#   ./setup-into-project.sh --check /path/to/project
#   ./setup-into-project.sh --refresh /path/to/project
#
# Exit 0 on success. Prints changed paths, one per line, prefixed with CHANGED:
# so callers can stage them.

set -euo pipefail

ADB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL="$ADB_ROOT/SKILL.md"
INSTALLER="$ADB_ROOT/install-commands.sh"

CHECK=0
REFRESH=0
PROJECT=""

for arg in "$@"; do
  case "$arg" in
    --check) CHECK=1 ;;
    --refresh) REFRESH=1 ;;
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

[ -n "$PROJECT" ] || { echo "usage: $0 [--check] [--refresh] /path/to/project" >&2; exit 2; }
[ -d "$PROJECT" ] || { echo "not a directory: $PROJECT" >&2; exit 1; }
[ -f "$SKILL" ] || { echo "SKILL.md missing: $SKILL" >&2; exit 1; }
[ -x "$INSTALLER" ] || { echo "install-commands.sh missing or not executable: $INSTALLER" >&2; exit 1; }

PROJECT="$(cd "$PROJECT" && pwd -P)"
sha="$(git -C "$ADB_ROOT" rev-parse --short HEAD 2>/dev/null || echo unknown)"
# An uncommitted or staged SKILL.md would be copied while the stamp names HEAD,
# so the stamp would point at a different body (P1A). Mark it instead of lying.
if ! git -C "$ADB_ROOT" diff HEAD --quiet -- SKILL.md 2>/dev/null; then
  sha="${sha}-dirty"
fi
day="$(date +%Y-%m-%d)"
stamp="METHOD-VERSION: ${sha} ${day}"

note_changed() {
  printf 'CHANGED: %s\n' "$1"
}

# --- 1. ADB.md ---
adb_md="$PROJECT/ADB.md"
FRESH_COPY=0
if [ ! -f "$adb_md" ]; then
  if [ $CHECK -eq 1 ]; then
    echo "WOULD CREATE $adb_md (stamped $stamp)"
  else
    cp "$SKILL" "$adb_md"
    note_changed "ADB.md"
    FRESH_COPY=1
  fi
fi

# --- 1A. Body drift (P1A: a stamp must not outrank the body it labels) ---
# Compare bodies only. Remove the header stamp (never examples in the body).
# After removal, swallow one optional blank line left by older stampers.
strip_stamp() {
  awk '
    BEGIN { fm=0; fm_closed=0; removed=0; past_h1=0 }
    /^# / { past_h1=1 }
    past_h1 { print; next }
    NR==1 && $0=="---" { fm=1; print; next }
    NR==1 && $0 ~ /^METHOD-VERSION:/ { removed=1; next }
    fm==1 {
      print
      if ($0=="---") { fm=0; fm_closed=1 }
      next
    }
    fm_closed && !removed && $0 ~ /^METHOD-VERSION:/ { removed=1; next }
    fm_closed && removed && $0 ~ /^METHOD-VERSION:/ { next }
    { print }
  ' "$1"
}

STALE=0
if [ -f "$adb_md" ]; then
  _skill_body="$(mktemp)"
  _adb_body="$(mktemp)"
  strip_stamp "$SKILL" > "$_skill_body"
  strip_stamp "$adb_md" > "$_adb_body"
  if ! diff -q "$_skill_body" "$_adb_body" >/dev/null; then
    STALE=1
  fi
  rm -f "$_skill_body" "$_adb_body"
fi

if [ $STALE -eq 1 ] && [ $REFRESH -eq 1 ]; then
  if [ $CHECK -eq 1 ]; then
    echo "WOULD REFRESH $adb_md (body differs from SKILL.md)"
  else
    cp "$SKILL" "$adb_md"
    note_changed "ADB.md"
    FRESH_COPY=1
  fi
  STALE=0
fi

# --- 2. METHOD-VERSION stamp (P1A) ---
# Only the header stamp is touched. The format example in the body (indented in
# SKILL.md) must survive. Never place a stamp above frontmatter (L-004).
remove_stamp_above_frontmatter() {
  local file="$1"
  local tmp first second
  tmp="$(mktemp)"
  first="$(head -1 "$file" 2>/dev/null || true)"
  second="$(sed -n '2p' "$file" 2>/dev/null || true)"
  if [[ "$first" =~ ^METHOD-VERSION: ]] && [ "$second" = "---" ]; then
    tail -n +2 "$file" > "$tmp"
    mv "$tmp" "$file"
    return 0
  fi
  return 1
}

stamp_adb_md() {
  local file="$1"
  local tmp
  tmp="$(mktemp)"

  if [ ! -s "$file" ]; then
    echo "WARN: $file is empty — cannot stamp (P1A)." >&2
    rm -f "$tmp"
    return 1
  fi

  if head -1 "$file" | grep -qx '---'; then
    if ! awk 'BEGIN{fm=0} /^---/{fm++} fm==2{exit 0} END{exit 1}' "$file"; then
      echo "WARN: $file has frontmatter without a closing --- — cannot stamp (P1A)." >&2
      rm -f "$tmp"
      return 1
    fi
  fi

  if [ $CHECK -eq 0 ]; then
    remove_stamp_above_frontmatter "$file" || true
  fi

  awk -v stamp="$stamp" '
    BEGIN { fm=0; fm_closed=0; stamp_done=0; past_h1=0 }
    /^# / { past_h1=1 }
    past_h1 { print; next }
    NR==1 && $0=="---" { fm=1; print; next }
    NR==1 && $0 ~ /^METHOD-VERSION:/ { print stamp; stamp_done=1; next }
    NR==1 { print stamp; stamp_done=1; print; next }
    fm==1 {
      print
      if ($0=="---") {
        fm=0
        fm_closed=1
        print stamp
        stamp_done=1
      }
      next
    }
    fm_closed && !stamp_done && $0 ~ /^METHOD-VERSION:/ { print stamp; stamp_done=1; next }
    fm_closed && stamp_done && $0 ~ /^METHOD-VERSION:/ { next }
    { print }
    END {
      if (!stamp_done && !past_h1) {
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

if [ -f "$adb_md" ] && [ $STALE -eq 0 ]; then
  if stamp_adb_md "$adb_md"; then
    if [ $CHECK -eq 1 ]; then
      echo "WOULD STAMP $adb_md ($stamp)"
    elif [ $FRESH_COPY -eq 0 ]; then
      note_changed "ADB.md"
    fi
  fi
elif [ $STALE -eq 1 ]; then
  echo "STALE: $adb_md body differs from the canonical SKILL.md."
  echo "STALE: not stamping — a stamp would claim a version this file does not have (P1A)."
  echo "STALE: run with --refresh to update the body, or record a decision to stay on the older version."
fi

# --- 2B. METHOD.md ---
method_md="$PROJECT/METHOD.md"
if [ ! -f "$method_md" ]; then
  if [ $CHECK -eq 1 ]; then
    echo "WOULD CREATE $method_md (METHOD: ADB)"
  else
    printf '%s\n' 'METHOD: ADB' > "$method_md"
    note_changed "METHOD.md"
  fi
elif ! grep -qx 'METHOD: ADB' "$method_md" 2>/dev/null; then
  echo "WARN: $method_md exists but does not contain METHOD: ADB — not overwriting." >&2
fi

# --- 3. Issue register: adb/08-OPEN-ISSUES.md ---
mkdir_adb=0
[ -d "$PROJECT/adb" ] || mkdir_adb=1
register="$PROJECT/adb/08-OPEN-ISSUES.md"

write_register() {
  cat > "$1" <<'EOF'
# Open Issues

CANONICAL: This file (`adb/08-OPEN-ISSUES.md`) when the Source of Truth is not collapsed. When collapsed, issues live in `adb/07-STATUS.md` under `## Open issues` instead — do not duplicate both.

Record real unresolved complaints, bugs, regressions, UX or design defects, data problems, specification conflicts, and failing critical behavior here. Remove an entry only after its fix is tested and verified.

Never record secrets, private data, or actionable vulnerability details in this tracked file. Use an explicitly private channel for sensitive security reports.

OPEN: 0 · READY FOR VERIFY: 0 · CRITICAL: 0 · HIGH: 0 · MEDIUM: 0 · LOW: 0 · CLOSED: 0

Closed issues stay in this file and stay traceable (P49). Do not close by deleting the entry.

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
  (cd "$PROJECT" && find .cursor/commands .claude/commands .codex/prompts -name 'adb*.md' 2>/dev/null | sed 's|^\./||' | sort || true)
}

list_cmd_link_targets() {
  (cd "$PROJECT" && find .cursor/commands .claude/commands .codex/prompts -name 'adb*.md' -type l 2>/dev/null \
    | while IFS= read -r rel; do
        [ -n "$rel" ] || continue
        printf '%s -> %s\n' "$rel" "$(readlink "$rel" 2>/dev/null || echo '?')"
      done | sort || true)
}

# A stale ADB.md means the project is deliberately or accidentally on an older
# method. Installing current commands next to it would produce exactly the drift
# P1A exists to prevent: commands citing points the project's ADB.md lacks.
if [ $STALE -eq 1 ]; then
  echo "STALE: skipping slash commands — current commands would cite points this ADB.md does not have."
  echo "STALE: run with --refresh to update both together."
elif [ $CHECK -eq 1 ]; then
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
echo "METHOD-VERSION target: $stamp"
