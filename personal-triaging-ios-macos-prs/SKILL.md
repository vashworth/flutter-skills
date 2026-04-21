---
name: personal-triaging-ios-macos-prs
description: Triages iOS or macOS Flutter PRs. Use this skill when asked to triage open iOS or macOS Flutter PRs.
---

## Triage Workflow

Copy this checklist and track your progress as you complete each step:
Task Progress:
- [ ] Step 1: Determine target team
- [ ] Step 2: Fetch PR data
- [ ] Step 3: Parse team PRs

## Step 1: Determine target team
Pause and ask the user which team they want to triage issues for. The options are:
* `ios`
* `macos`
Set `[TEAM]` to the selected option for the rest of the workflow.

## Step 2: Fetch issue data
Run the following utility scripts exactly as written (replacing `[TEAM]` with the selection from Step 1):

```bash
dart scripts/triage.dart labels
dart scripts/triage.dart prs [TEAM] flutter
dart scripts/triage.dart prs [TEAM] flutter
```

Constraint: Do not execute any other gh commands.

## Step 3: Parse flutter/flutter Pull Requests

Read the `.agents/skills/personal-ios-triage/temp/prs_[TEAM]_flutter.json` files. Evaluate each PR and formulate a markdown table using the `Report Structure Template` pattern defined below.

Save the table to a local markdown file named `.agents/skills/personal-ios-triage/temp/prs_[TEAM]_flutter.md`.

## Step 4: Parse flutter/packages Pull Requests

Read the `.agents/skills/personal-ios-triage/temp/prs_[TEAM]_packages.json` files. Evaluate each PR and formulate a markdown table using the `Report Structure Template` pattern defined below.

Save the table to a local markdown file named `.agents/skills/personal-ios-triage/temp/prs_[TEAM]_packages.md`.

## Report Structure Template

ALWAYS use this exact template structure for your output table:

| PR Link | Quick Summary | Author | Assigned Reviewers | Last Reviewed On | State | Missing CICD |
| ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |

Definitions for table evaluation:
* PR Link: copy and paste the markdown link to the PR.
* Quick Summary: a 1 sentence summary of the PR.
* Author: The author's login username.
* Assigned Reviewers: The review authors (excluding "gemini-code-assist" and the PR author).
* Last Reviewed On: Date of last review.
* State:
  * "Approved": If a single "Approved" review comment exists.
  * "Waiting for changes": If there is a review but no commits since then.
  * "Waiting for review": All others
* Missing CICD: "Yes" if the "CICD" label is not present.