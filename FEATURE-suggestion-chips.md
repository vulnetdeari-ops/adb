# Feature: clickable decision options in Paseo

**Status:** requested upstream, not blocking
**Date:** 2026-08-26 (updated same day after Bubby tested the format)

## Goal
Tappable options under agent messages for Decision Questions, so Bubby can click instead of type.

## Current rule (authoritative)
**A/B/C or 1/2/3** — the user answers with a single letter or number. The last letter is always the decide-for-me option.

Source of truth: global `AGENTS.md` → Decision Questions. ADB `SKILL.md` P10/P11 and the German reading copy follow it.

Earlier drafts used Perplexity-style label chips. Bubby tested that and rejected it: typing label text is more work than a single letter, and Paseo cannot render real chips yet.

## Upstream
https://github.com/getpaseo/paseo/issues/3915

If Paseo ever renders clickable options, A/B/C lines are already a clean thing to make clickable — the rule does not need to change for that, only the rendering.
