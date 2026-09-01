#!/usr/bin/env bash
# Factory rules — optional home links to this repo's AGENTS.md.
# Product projects get copies via setup-into-project.sh; they do not need these links.
#
# Usage:
#   ./install-skills.sh          create/update home symlinks
#   ./install-skills.sh --check  report only
#   ./install-skills.sh --remove remove the home symlinks this script owns
#
# Idempotent. Safe to re-run.

set -euo pipefail

RULES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$RULES_ROOT/AGENTS.md"

CHECK=0
ACTION="install"

for arg in "$@"; do
  case "$arg" in
    --check) CHECK=1 ;;
    --remove) ACTION="remove" ;;
    -*) echo "unknown argument: $arg" >&2; exit 2 ;;
    *) echo "unexpected argument: $arg" >&2; exit 2 ;;
  esac
done

[ -f "$SRC" ] || { echo "AGENTS.md missing: $SRC" >&2; exit 1; }

# dest|parent-dir
LINKS=(
  "$HOME/.codex/AGENTS.md|$HOME/.codex"
  "$HOME/.cursor/rules/00-global.mdc|$HOME/.cursor/rules"
  "$HOME/.claude/CLAUDE.md|$HOME/.claude"
  "$HOME/.gemini/GEMINI.md|$HOME/.gemini"
  "$HOME/.agents/AGENTS.md|$HOME/.agents"
)

is_ours() {
  local dst="$1"
  [ -L "$dst" ] || return 1
  [ "$(readlink "$dst")" = "$SRC" ]
}

changed=0

echo "source: $SRC"
echo "action: $ACTION$([ $CHECK -eq 1 ] && echo ' (check only)')"
echo

if [ "$ACTION" = "remove" ]; then
  for entry in "${LINKS[@]}"; do
    dst="${entry%%|*}"
    if is_ours "$dst"; then
      if [ $CHECK -eq 1 ]; then
        echo "WOULD REMOVE $dst"
      else
        rm -f "$dst"
        echo "removed $dst"
      fi
      changed=$((changed + 1))
    fi
  done
  echo
  if [ $CHECK -eq 1 ]; then
    [ $changed -eq 0 ] && echo "no harness links to remove" || echo "$changed would be removed"
    exit 0
  fi
  echo "done. $changed link(s) removed."
  exit 0
fi

for entry in "${LINKS[@]}"; do
  dst="${entry%%|*}"
  parent="${entry##*|}"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$SRC" ]; then
    continue
  fi

  if [ $CHECK -eq 1 ]; then
    echo "WOULD LINK $dst -> $SRC"
    changed=$((changed + 1))
    continue
  fi

  mkdir -p "$parent"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    backup="$dst.pre-factory.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$backup"
    echo "existing file kept as $backup"
  fi
  rm -f "$dst"
  ln -s "$SRC" "$dst"
  echo "ok  $dst"
  changed=$((changed + 1))
done

echo
if [ $CHECK -eq 1 ]; then
  [ $changed -eq 0 ] && echo "up to date, nothing to do" || echo "$changed change(s) pending — re-run without --check"
  exit 0
fi
echo "done. $changed change(s). Edit Rules/AGENTS.md; harnesses follow the symlink."
