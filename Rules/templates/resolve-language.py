#!/usr/bin/env python3
"""Map a typed language (name or tag) to a BCP-47-ish tag + display name."""
from __future__ import annotations

import re
import sys
import unicodedata
from pathlib import Path

TAGS = Path(__file__).resolve().parent / "language-tags.txt"


def fold(s: str) -> str:
    # Keep letters from every script. ASCII-only folding wiped 日本語 / Shqip aliases
    # onto one empty key and mapped them to the last such row (Belarusian).
    s = unicodedata.normalize("NFKC", s.strip().casefold())
    s = s.replace("_", "-")
    chars = []
    for c in s:
        if c.isalnum() or c in "+-":
            chars.append(c)
        elif c.isspace():
            chars.append(" ")
    return re.sub(r"\s+", " ", "".join(chars)).strip()


def normalize_tag(raw: str) -> str:
    parts = raw.strip().replace("_", "-").split("-")
    if not parts or not parts[0]:
        return ""
    out = [parts[0].lower()]
    for p in parts[1:]:
        if len(p) == 2 and p.isalpha():
            out.append(p.upper())
        else:
            out.append(p[0].upper() + p[1:].lower() if p else p)
    return "-".join(out)


def load_table(path: Path) -> tuple[dict[str, str], dict[str, str]]:
    """tag -> display; folded alias -> tag"""
    names: dict[str, str] = {}
    aliases: dict[str, str] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        bits = line.split("\t")
        if len(bits) < 2:
            continue
        tag, display = bits[0].strip(), bits[1].strip()
        extra = bits[2] if len(bits) > 2 else ""
        names[tag] = display
        for a in [tag, display, *([x.strip() for x in extra.split(",")] if extra else [])]:
            if not a:
                continue
            key = fold(a)
            if key:
                aliases[key] = tag
    return names, aliases


TAG_RE = re.compile(r"^[A-Za-z]{2,3}(-[A-Za-z0-9]{2,8})*$")


def resolve(raw: str, names: dict[str, str], aliases: dict[str, str]) -> tuple[str, str]:
    text = " ".join(raw.split())
    if not text:
        raise ValueError("empty language")
    if TAG_RE.fullmatch(text):
        tag = normalize_tag(text)
        primary = tag.split("-")[0]
        display = names.get(tag) or names.get(primary) or tag
        return tag, display
    key = fold(text)
    if key in aliases:
        tag = aliases[key]
        return tag, names.get(tag, tag)
    # Unknown spoken name: keep it, tag und. Start still translates LESEN.html.
    return "und", text


def main() -> int:
    if len(sys.argv) < 2:
        print("usage: resolve-language.py LANGUAGE", file=sys.stderr)
        return 2
    if sys.argv[1] == "--self-test":
        names, aliases = load_table(TAGS)
        cases = [
            ("Italiano", "it", "Italiano"),
            ("日本語", "ja", "日本語"),
            ("japanese", "ja", "日本語"),
            ("shqip", "sq", "Shqip"),
            ("albanisch", "sq", "Shqip"),
            ("pt-br", "pt-BR", "Português (Brasil)"),
            ("Français", "fr", "Français"),
            ("العربية", "ar", "العربية"),
            ("High Valyrian", "und", "High Valyrian"),
            ("de", "de", "Deutsch"),
            ("en-GB", "en-GB", "English"),
        ]
        failed = 0
        for raw, want_tag, want_name in cases:
            tag, display = resolve(raw, names, aliases)
            if tag != want_tag or display != want_name:
                print(f"FAIL {raw!r} -> {tag!r} {display!r} want {want_tag!r} {want_name!r}")
                failed += 1
        if failed:
            return 1
        print(f"ok {len(cases)} language maps")
        return 0
    raw = sys.argv[1]
    names, aliases = load_table(TAGS)
    try:
        tag, display = resolve(raw, names, aliases)
    except ValueError as e:
        print(e, file=sys.stderr)
        return 2
    sys.stdout.write(f"{tag}\t{display}\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
