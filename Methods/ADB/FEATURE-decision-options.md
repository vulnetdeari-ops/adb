# Feature: decision options

**Status:** ADOPTED — chips when clickable, else A/B/C. Last option is always decide-for-me.
**Date:** 2026-08-26 (updated 2026-09-03)

## Goal
Tappable options under agent messages when the harness supports them; lettered A/B/C when it does not — so the owner can always answer without inventing options.

## Rule (authoritative)

Source of truth: project `AGENTS.md` → Talk. Start options: `START.md`.

- Offer **chips when clickable, else A/B/C** — never both at once.
- Label text: 1–4 words (not a sentence). Extra explanation stays in the question.
- Last option is always decide-for-me (`Entscheide du` / equivalent).
- Cursor: native `AskQuestion` chips when that tool exists (one question per call). Do not also print letters.
- If the tool is missing: lettered options (`A` `B` `C` …) with the same short labels.
- Click, matching label, or letter all count; letters map in listed order.

Long Perplexity-style chip sentences stay forbidden (L-007). L-019 wanted chips; L-022 adds A/B/C only when chips are not clickable.
