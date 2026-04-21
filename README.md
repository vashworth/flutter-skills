# Skills for the flutter/flutter repo


## [Classifying Run Test Intent](personal-classifying-run-test-intent/SKILL.md)
Classifies user intent (Read-Only vs. Write/Repair) and sets the execution protocol for running tests.

## [Finding Tests](personal-finding-tests/SKILL.md)
Locates relevant test files for the codebase.

## [Formatting After Edit](personal-formatting-after-edit/SKILL.md)
Formats files right before concluding a task.

## [Running CI Test Locally](personal-running-ci-test-locally/SKILL.md)
Identifies and runs Flutter tests from CI URLs.

## [Running Tests](personal-running-tests/SKILL.md)
Identifies and executes the appropriate tests for the codebase.

## [Triaging iOS/macOS Issues](personal-triaging-ios-macos-issues/SKILL.md)
Triages iOS or macOS Flutter issues.

## [Triaging iOS/macOS PRs](personal-triaging-ios-macos-prs/SKILL.md)
Triages iOS or macOS Flutter PRs.

## [Writing Tests](personal-writing-tests/SKILL.md)
Writes tests for modified code.

# Add skill to flutter/flutter

Within your flutter repo, create a symbolic link to the skill. See example:

```bash
# From the flutter/flutter directory
ln -s /path/to/flutter-skills/personal-classifying-run-test-intent .agents/skills/
```