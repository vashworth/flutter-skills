---
name: personal-finding-tests
description: Locates relevant test files for the codebase. Use when a user asks to find tests for a particular file, feature, or component.
---

## Step 1: Determine Search Scope
Identify what you are looking for:
- Tests for a specific file or class.
- Tests for a feature or keyword (e.g., `platform_view`, `flavor`).
- Tests for a specific platform (iOS, Android, Web, etc).

## Step 2: Identify Test Locations

Target the appropriate directories based on the component:
- `packages/flutter/test/` -> Framework Tests (Unit & Widget)
- `packages/flutter_tools/test/` -> Tool Tests (Unit & Integration)
- `dev/devicelab/bin/tasks/` -> DeviceLab Tests (Integration)
- `engine/src/` -> Engine Tests

Review [TBD] for a detailed breakdown.

## Step 3: Transition to Execution
If the user requests you to run the tests after finding them, refer to the `personal-running-tests` skill to determine how to execute them.
