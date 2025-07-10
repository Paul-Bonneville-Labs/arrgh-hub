#!/bin/bash

# Branch Status Script
# Checks current branch, uncommitted changes, and associated PRs

set -e

echo "=== Branch Status ==="
echo

# Get current branch
current_branch=$(git branch --show-current)
echo "Current branch: $current_branch"

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "Uncommitted changes: Yes"
    echo "  Modified files:"
    git status --porcelain | sed 's/^/    /'
else
    echo "Uncommitted changes: None (clean working directory)"
fi

# Check for associated PR
echo
echo "Checking for associated PR..."
pr_info=$(gh pr list --head "$current_branch" --json number,title,url 2>/dev/null || echo "[]")

if [ "$pr_info" = "[]" ] || [ -z "$pr_info" ]; then
    echo "Associated PR: No open PR for this branch"
else
    echo "Associated PR:"
    echo "$pr_info" | jq -r '.[] | "  #\(.number): \(.title)\n  URL: \(.url)"'
fi

echo
echo "=== End Branch Status ==="