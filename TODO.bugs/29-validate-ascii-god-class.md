# 29 — ValidateAscii is a 604-line god class with inline inner classes

**Priority:** P2 (god class)

## Problem

`lib/expressir/commands/validate_ascii.rb` — 604 lines with 3 inner classes
(`CharacterDetail`, `NonAsciiViolation`, `NonAsciiViolationCollection`)
defined inline.

## Fix

Extract inner classes to `lib/expressir/express/ascii_validator/` as a
dedicated module; keep the command as a thin wrapper.

## Acceptance

- Command file under 200 lines.
- All validate_ascii specs pass.
