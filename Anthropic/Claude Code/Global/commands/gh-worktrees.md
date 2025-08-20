---
description: Create and manage git worktrees in .worktrees/ directory
---

Create or list git worktrees based on arguments provided: $ARGUMENTS

**Usage:**
- `/gh-worktrees` - List existing worktrees and current repository status
- `/gh-worktrees <name>` - Create new worktree with given name

## Implementation

### If No Arguments (List Mode):
1. **Check Repository Status**
   - Show current working directory and git repository
   - Display current branch and any uncommitted changes
   - List existing worktrees in `.worktrees/` directory if they exist

2. **Show Available Options**
   - Display recent branches that could be used for new worktrees
   - Show git worktree list output for context
   - Provide usage instructions for creating new worktrees

### If Arguments Provided (Create Mode):
1. **Sanitize and Validate Worktree Name**
   - Extract worktree name from $ARGUMENTS (first argument or full phrase)
   - Sanitize the name automatically:
     - Convert to lowercase
     - Replace spaces with hyphens
     - Replace underscores with hyphens
     - Remove special characters except hyphens
     - Remove leading/trailing hyphens
   - Validate sanitized name is not empty and doesn't start with dots
   - Show the sanitized name to user for confirmation
   - If name becomes invalid after sanitization, show error and usage example

2. **Prepare Worktree Creation**
   - Create `.worktrees/` directory if it doesn't exist: `mkdir -p .worktrees`
   - Check if `.worktrees/{sanitized-name}` directory already exists
   - Check if branch `feature/{sanitized-name}` already exists
   - If conflicts exist, inform user and exit with suggestions

3. **Create Branch and Worktree (Simplified Approach)**
   - Create git worktree and branch in one command: `git worktree add .worktrees/{sanitized-name} -b feature/{sanitized-name}`
   - This avoids "already checked out" errors by creating both simultaneously
   - Verify creation was successful

4. **Switch to New Worktree**
   - Change to new worktree directory: `cd .worktrees/{sanitized-name}`
   - Display success message with new location and branch
   - Show git status of new worktree
   - Provide instructions for returning to main worktree

## Error Handling
- **Invalid name**: Show validation rules and usage example with sanitization examples
- **Directory conflicts**: Suggest alternative names or cleanup commands
- **Branch conflicts**: Offer to checkout existing branch or suggest new name
- **Already checked out error**: Use the simplified single-command approach to avoid this issue
- **Git failures**: Display git error and suggest troubleshooting steps
- **Permission errors**: Guide user on directory permissions
- **Name sanitization edge cases**: Handle empty results, show before/after transformation

## Examples

```bash
# List existing worktrees
/gh-worktrees
# Output: Shows current repo status and existing .worktrees/ contents

# Create new worktree for feature development
/gh-worktrees auth-improvements
# Creates: .worktrees/auth-improvements with branch feature/auth-improvements
# Switches to: .worktrees/auth-improvements directory

# Name sanitization examples
/gh-worktrees "Move to Material UI"
# Sanitized to: move-to-material-ui
# Creates: .worktrees/move-to-material-ui with branch feature/move-to-material-ui

/gh-worktrees "Fix API_Issues & Bugs"
# Sanitized to: fix-api-issues-bugs
# Creates: .worktrees/fix-api-issues-bugs with branch feature/fix-api-issues-bugs

# Invalid name example (after sanitization)
/gh-worktrees "..."
# Sanitized to: (empty)
# Output: Error message explaining naming rules and showing sanitization process
```