# 28 — Package command is a 1266-line god class

**Priority:** P2 (god class)

## Problem

`lib/expressir/commands/package.rb` — 1266 lines, 30 methods. Contains
display logic (tree, info, text/json/yaml output), package building,
validation output, colorization, and element introspection.

## Fix

Extract `PackageDisplay` module for tree/info/search output methods
(lines 700-1141).

## Acceptance

- Package command file under 600 lines.
- All package specs pass.
