---
description: Merge the current PR, delete local branch, and return to main
allowed-tools: Bash(Anthropic/Claude Code/Global/commands/scripts/gh-pr-merge.sh)
---

## Your task
!`Anthropic/Claude Code/Global/commands/scripts/gh-pr-merge.sh`

This command will:
1. Find and merge the open PR for the current branch
2. Switch back to main branch
3. Pull latest changes
4. Delete the merged local branch

**Requirements:**
- Must have an open PR for the current branch
- Cannot be run from main branch
- Requires GitHub CLI (gh) to be authenticated

Format your output with clear status messages for each step.