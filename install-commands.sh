#!/usr/bin/env bash
# ADB — install slash commands into THIS project, never into the user home.
#
# Canonical files live in commands/. Each project harness directory gets a
# symlink (or a copy with --copy). That keeps one source of truth and keeps
# /adb-* out of unrelated projects (P1).
#
# Usage:
#   ./install-commands.sh                 install into the current directory
#   ./install-commands.sh --check         report only
#   ./install-commands.sh --copy          copy instead of symlink
#   ./install-commands.sh --remove        remove from the current directory
#   ./install-commands.sh --remove-global remove leftover home-level installs
#
# Idempotent. Safe to re-run.

set -euo pipefail

ADB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ADB_ROOT/commands"

PROJECT_SUBDIRS=(
  ".claude/commands"
  ".codex/prompts"
  ".cursor/commands"
)

GLOBAL_DIRS=(
  "$HOME/.claude/commands"
  "$HOME/.codex/prompts"
  "$HOME/.cursor/commands"
)

MODE="link"
ACTION="install"
CHECK=0
ROOT="$PWD"

for arg in "$@"; do
  case "$arg" in
    --check) CHECK=1 ;;
    --copy) MODE="copy" ;;
    --remove) ACTION="remove" ;;
    --remove-global) ACTION="remove-global" ;;
    *) echo "unknown argument: $arg" >&2; exit 2 ;;
  esac
done

[ -d "$SRC" ] || { echo "no commands/ directory at $SRC" >&2; exit 1; }

shopt -s nullglob
FILES=("$SRC"/adb-*.md)
shopt -u nullglob
[ ${#FILES[@]} -gt 0 ] || { echo "no adb-*.md files in $SRC" >&2; exit 1; }

is_ours() {
  local dst="$1" src="$2"
  if [ -L "$dst" ]; then
    local target
    target="$(readlink "$dst")"
    [ "$target" = "$src" ] && return 0
    [ "$target" = "../../commands/$(basename "$src")" ] && return 0
    return 1
  fi
  [ -f "$dst" ] && cmp -s "$src" "$dst"
}

link_target_for() {
  local src="$1"
  if [ "$ROOT" = "$ADB_ROOT" ]; then
    printf '%s' "../../commands/$(basename "$src")"
  else
    printf '%s' "$src"
  fi
}

remove_ours_from() {
  local dir="$1"
  local n=0
  [ -d "$dir" ] || { echo 0; return 0; }
  local src name dst
  for src in "${FILES[@]}"; do
    name="$(basename "$src")"
    dst="$dir/$name"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
      if is_ours "$dst" "$src"; then
        if [ $CHECK -eq 1 ]; then
          echo "WOULD REMOVE $dst" >&2
        else
          rm -f "$dst"
          echo "removed $dst" >&2
        fi
        n=$((n + 1))
      fi
    fi
  done
  local backup
  for backup in "$dir"/adb-*.md.pre-adb.*; do
    [ -e "$backup" ] || continue
    if [ $CHECK -eq 1 ]; then
      echo "WOULD REMOVE $backup" >&2
    else
      rm -f "$backup"
      echo "removed $backup" >&2
    fi
    n=$((n + 1))
  done
  echo "$n"
}

changed=0
problems=0

echo "source:  $SRC"
echo "action:  $ACTION$([ $CHECK -eq 1 ] && echo ' (check only)')"
if [ "$ACTION" != "remove-global" ]; then
  echo "project: $ROOT"
fi
echo

if [ "$ACTION" = "remove-global" ]; then
  for dir in "${GLOBAL_DIRS[@]}"; do
    n="$(remove_ours_from "$dir")"
    changed=$((changed + n))
  done
  echo
  if [ $CHECK -eq 1 ]; then
    [ $changed -eq 0 ] && echo "no leftover home-level ADB commands" || echo "$changed leftover(s) — re-run without --check"
    exit 0
  fi
  echo "done. $changed home-level file(s) removed."
  exit 0
fi

if [ "$ACTION" = "remove" ]; then
  for sub in "${PROJECT_SUBDIRS[@]}"; do
    n="$(remove_ours_from "$ROOT/$sub")"
    changed=$((changed + n))
  done
  echo
  if [ $CHECK -eq 1 ]; then
    [ $changed -eq 0 ] && echo "nothing to remove" || echo "$changed would be removed"
    exit 0
  fi
  echo "done. $changed project file(s) removed."
  exit 0
fi

echo "mode:    $MODE"
echo

for sub in "${PROJECT_SUBDIRS[@]}"; do
  dir="$ROOT/$sub"
  harness="$(echo "$sub" | cut -d/ -f1)"

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
    want="$(link_target_for "$src")"

    if [ "$MODE" = "link" ] && [ -L "$dst" ] && [ "$(readlink "$dst")" = "$want" ]; then
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

    if [ -f "$dst" ] && [ ! -L "$dst" ] && ! cmp -s "$src" "$dst"; then
      backup="$dst.pre-adb.$(date +%Y%m%d%H%M%S)"
      mv "$dst" "$backup"
      echo "$harness/$name: existing file kept as $(basename "$backup")"
    fi

    rm -f "$dst"
    if [ "$MODE" = "link" ]; then
      ln -s "$want" "$dst"
    else
      cp "$src" "$dst"
    fi
    echo "$harness/$name: ok"
    changed=$((changed + 1))
  done
done

echo
echo "verify:"
for sub in "${PROJECT_SUBDIRS[@]}"; do
  dir="$ROOT/$sub"
  harness="$(echo "$sub" | cut -d/ -f1)"
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
echo "done. $changed change(s). Edit commands/ in the ADB repo; this project follows."
