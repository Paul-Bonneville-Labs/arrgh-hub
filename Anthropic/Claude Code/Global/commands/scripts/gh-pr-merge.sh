#!/bin/bash

# Merge PR Script
# Merges the current PR, switches to main, and deletes the local branch

set -e

echo "=== Merge PR Workflow ==="
echo

# Get current branch
current_branch=$(git branch --show-current)
echo "Current branch: $current_branch"

# Check if we're on main
if [ "$current_branch" = "main" ]; then
    echo "❌ Error: Cannot merge PR from main branch"
    echo "Please switch to a feature branch first"
    exit 1
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "❌ Error: You have uncommitted changes"
    echo "Please commit or stash your changes before merging"
    exit 1
fi

# Check for associated PR
echo
echo "🔍 Looking for open PR for branch '$current_branch'..."
pr_info=$(gh pr list --head "$current_branch" --json number,title,url,state 2>/dev/null || echo "[]")

if [ "$pr_info" = "[]" ] || [ -z "$pr_info" ]; then
    echo "❌ Error: No open PR found for branch '$current_branch'"
    echo "Please create a PR first or check the branch name"
    exit 1
fi

# Extract PR details
pr_number=$(echo "$pr_info" | jq -r '.[0].number')
pr_title=$(echo "$pr_info" | jq -r '.[0].title')
pr_url=$(echo "$pr_info" | jq -r '.[0].url')

echo "✅ Found PR #$pr_number: $pr_title"
echo "   URL: $pr_url"
echo

# Merge the PR
echo "🚀 Merging PR #$pr_number..."
if gh pr merge "$pr_number" --merge --delete-branch --admin; then
    echo "✅ PR #$pr_number merged successfully"
else
    echo "❌ Error: Failed to merge PR #$pr_number"
    echo "Please check PR status and try again"
    exit 1
fi

echo

# Switch to main
echo "🔄 Switching to main branch..."
git checkout main

# Pull latest changes
echo "⬇️  Pulling latest changes from main..."
git pull origin main

# Delete local branch (if it still exists)
echo "🗑️  Cleaning up local branch..."
if git branch | grep -q "^[[:space:]]*$current_branch$"; then
    git branch -d "$current_branch"
    echo "✅ Deleted local branch '$current_branch'"
else
    echo "ℹ️  Local branch '$current_branch' already deleted"
fi

echo
echo "🎉 Merge workflow completed successfully!"
echo "   • PR #$pr_number merged and remote branch deleted"
echo "   • Switched back to main branch"
echo "   • Pulled latest changes"
echo "   • Local branch '$current_branch' cleaned up"
echo
echo "=== End Merge PR Workflow ==="