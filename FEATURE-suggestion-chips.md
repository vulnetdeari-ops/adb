# Feature: Decision suggestion chips in Paseo

**Status:** requested upstream  
**Date:** 2026-08-26

## Goal
Perplexity-style tappable suggestion chips under agent messages for Decision Questions.

## Done locally (rules)
- Global `AGENTS.md`: Decision Questions use short labels, not A/B/C.
- ADB `SKILL.md` / German reading copy: same format.

## Upstream
https://github.com/getpaseo/paseo/issues/3915

## Interim UX
Agents show:

**Vorschläge:**
• **Label** — one line  
• **Entscheide für mich**

Bubby answers by typing the label until Paseo can render real chips.
