---
name: personal-triaging-ios-macos-issues
description: Triages iOS or macOS Flutter issues. Use this skill when asked to triage open iOS or macOS Flutter issues.
---

## Triage Workflow

Copy this checklist and track your progress as you complete each step:
Task Progress:
- [ ] Step 1: Determine target team
- [ ] Step 2: Fetch issue data
- [ ] Step 3: Parse team issues
- [ ] Step 4: Parse FYI issues

## Step 1: Determine target team
Pause and ask the user which team they want to triage issues for. The options are:
* `ios`
* `macos`
Set `[TEAM]` to the selected option for the rest of the workflow.

## Step 2: Fetch issue data
Run the following utility scripts exactly as written (replacing `[TEAM]` with the selection from Step 1):

```bash
dart scripts/triage.dart labels
dart scripts/triage.dart issues 'team-[TEAM]' '-label:triaged-[TEAM] -label:"will need additional triage" -label:"waiting for customer response" sort:updated-asc'
dart scripts/triage.dart issues 'fyi-[TEAM]'  '-label:triaged-[TEAM] -label:"will need additional triage" -label:"waiting for customer response" sort:updated-asc'
```

Constraint: Do not execute any other gh commands.

## Step 3: Parse Team Issues

Read the `.agents/skills/personal-ios-triage/temp/team-[TEAM].json` file. Evaluate each issue and formulate a markdown table using the `Report Structure Template` pattern defined below.

Save the table to a local markdown file named `.agents/skills/personal-ios-triage/temp/team-[TEAM].md`.

## Step 4: Parse FYI Issues

Read the `.agents/skills/personal-ios-triage/temp/fyi-[TEAM].json` file. Evaluate each issue and formulate a markdown table using the `Report Structure Template` pattern defined below.

Save the table to a local markdown file named `.agents/skills/personal-ios-triage/temp/fyi-[TEAM].md`.

## Report Structure Template

ALWAYS use this exact template structure for your output table:

| Issue Link | Quick Summary | Age | Upvotes | Reproducible | Suggested Priority | Priority Reasoning | Missing Labels |
| ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |

Definitions for table evaluation:
* Issue Link: copy and paste the markdown link to the issue.
* Quick Summary: a 1 sentence summary of the issue
* Age: Mark in terms of months, weeks, or years (e.g. 1m ago or 2.5y ago)
* Upvotes: Total number of THUMBS_UP reactions.
* Reproducible: "Yes" if any comments mention being able to reproduce it or if it has the "has reproducible steps" label. "No" if any comments mention being unable to reproduce. Otherwise, "Unknown".
* Suggested Priority: Must be one of the following:
  * P0: Critical issues such as a build break or regression.
  * P1: High-priority issues at the top of the work list.
  * P2: Important issues not at the top of the work list.
  * P3: Issues that are less important to the Flutter project.
* Priority Reasoning: Why you selected that priority.
* Missing Labels: Any labels from `.agents/skills/personal-ios-triage/temp/labels.json` that are relevant but not assigned to the issue.