#!/usr/bin/env bash
# ADB — install the slash commands into every harness.
#
# The canonical commands live in this repository. Each harness gets a symlink,
# not a copy: one file to edit, no drift between harnesses.
#
# Usage:
#   ./install-commands.sh            install or repair
#   ./install-commands.sh --check    report only, change nothing
#   ./install-commands.sh --copy     copy instead of symlink (for harnesses that refuse links)
#
# Idempotent. Safe to re-run.

set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/commands"

TARGETS=(
  "$HOME/.claude/commands"
  "$HOME/.codex/prompts"
  "$HOME/.cursor/commands"
)

MODE="link"
CHECK=0
case "${1:-}" in
  --check) CHECK=1 ;;
  --copy)  MODE="copy" ;;
  "")      ;;
  *)       echo "unknown argument: $1" >&2; exit 2 ;;
esac

[ -d "$SRC" ] || { echo "no commands/ directory at $SRC" >&2; exit 1; }

shopt -s nullglob
FILES=("$SRC"/adb-*.md)
shopt -u nullglob
[ ${#FILES[@]} -gt 0 ] || { echo "no adb-*.md files in $SRC" >&2; exit 1; }

echo "source:  $SRC"
echo "files:   ${#FILES[@]}"
echo "mode:    $MODE$([ $CHECK -eq 1 ] && echo ' (check only)')"
echo

changed=0
problems=0

for dir in "${TARGETS[@]}"; do
  harness="$(basename "$(dirname "$dir")")"

  if [ ! -d "$(dirname "$dir")" ]; then
    echo "$harness: not installed on this machine, skipped"
    continue
  fi

  if [ ! -d "$dir" ]; then
    if [ $CHECK -eq 1 ]; then
      echo "$harness: WOULD CREATE $dir"
      changed=$((changed + 1))
      continue
    fi
    mkdir -p "$dir"
  fi

  for src in "${FILES[@]}"; do
    name="$(basename "$src")"
    dst="$dir/$name"

    if [ "$MODE" = "link" ] && [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
      continue
    fi
    if [ "$MODE" = "copy" ] && [ -f "$dst" ] && [ ! -L "$dst" ] && cmp -s "$src" "$dst"; then
      continue
    fi

    if [ $CHECK -eq 1 ]; then
      echo "$harness/$name: WOULD UPDATE"
      changed=$((changed + 1))
      continue
    fi

    # An unmanaged file with different content is never destroyed silently.
    if [ -f "$dst" ] && [ ! -L "$dst" ] && ! cmp -s "$src" "$dst"; then
      backup="$dst.pre-adb.$(date +%Y%m%d%H%M%S)"
      mv "$dst" "$backup"
      echo "$harness/$name: existing file kept as $(basename "$backup")"
    fi

    rm -f "$dst"
    if [ "$MODE" = "link" ]; then
      ln -s "$src" "$dst"
    else
      cp "$src" "$dst"
    fi
    echo "$harness/$name: ok"
    changed=$((changed + 1))
  done
done

echo
echo "verify:"
for dir in "${TARGETS[@]}"; do
  harness="$(basename "$(dirname "$dir")")"
  [ -d "$dir" ] || continue
  ok=0
  for src in "${FILES[@]}"; do
    dst="$dir/$(basename "$src")"
    if [ -r "$dst" ] && cmp -s "$src" "$dst"; then
      ok=$((ok + 1))
    else
      problems=$((problems + 1))
    fi
  done
  echo "  $harness: $ok/${#FILES[@]} readable and identical"
done

echo
if [ $CHECK -eq 1 ]; then
  [ $changed -eq 0 ] && echo "up to date, nothing to do" || echo "$changed change(s) pending — re-run without --check"
  exit 0
fi
if [ $problems -gt 0 ]; then
  echo "$problems file(s) not verified — check the output above" >&2
  exit 1
fi
echo "done. $changed change(s). Edit commands/ in this repository; every harness follows."
