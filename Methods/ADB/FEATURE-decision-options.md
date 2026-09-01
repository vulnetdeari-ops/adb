# Feature: decision options

**Status:** ADOPTED — short chips, not A/B/C. Last chip is always decide-for-me.
**Date:** 2026-08-26 (updated 2026-09-01)

## Goal
Tappable options under agent messages for Start and Decision Questions, so the owner can click instead of type a letter.

## Rule (authoritative)

Source of truth: project `AGENTS.md` → Talk. Start chips: `START.md`.

- Offer **chips**, not A/B/C.
- Chip text: 1–4 words (not a sentence). Extra explanation stays in the question.
- Last chip is always decide-for-me (`Entscheide du` / equivalent).
- Cursor: native `AskQuestion` chips when that tool exists (one question per call).
- If the tool is missing: one row of the same labels in backticks. Still no letters.
- A leftover typed letter maps in listed order.

Long Perplexity-style chip sentences stay forbidden (L-007). The owner asked for chips instead of ABC (L-019).
