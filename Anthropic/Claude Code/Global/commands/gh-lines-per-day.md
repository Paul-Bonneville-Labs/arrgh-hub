---
description: Analyze lines of code added per day across GitHub organization repositories with tree view
argument-hint: [number of days] (optional, defaults to 7)
allowed-tools: Bash(~/.claude/commands/scripts/gh-lines-per-day.sh $ARGUMENTS)
---

## Your task
Run the git lines per day analysis script with optional days parameter:

!`~/.claude/commands/scripts/gh-lines-per-day.sh $ARGUMENTS`

**Usage:**
- `/gh-lines-per-day` - Analyze last 7 days (default)
- `/gh-lines-per-day 14` - Analyze last 14 days
- `/gh-lines-per-day 30` - Analyze last 30 days

This command analyzes the Paul-Bonneville-Labs GitHub organization and shows:
- Daily line additions in tree format
- Per-repository breakdown for each day
- Total lines added across all repositories
- Repository ranking by total contributions

Requires GitHub CLI authentication and accepts any positive integer for days.