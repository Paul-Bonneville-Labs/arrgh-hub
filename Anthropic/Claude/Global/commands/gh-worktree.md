---
description: Create a new git worktree in a sibling directory
---

Create a new git worktree in a sibling directory with the name derived from: $ARGUMENTS

1. **Parse Arguments**
   - Extract the worktree name from $ARGUMENTS (required first argument)
   - If no argument provided, show usage: "Usage: /gh-worktree <name>"
   - Validate the name contains only alphanumeric characters and hyphens

2. **Determine Current Project Structure**
   - Get the current working directory using `pwd`
   - Extract the current project name (last component of the path)
   - Get the parent directory path
   - Generate new worktree directory name: `{current-project}-{worktree-name}`

3. **Check for Conflicts**
   - Verify the target directory doesn't already exist
   - Check if a branch with the same name already exists
   - If conflicts exist, inform user and exit

4. **Create Branch and Worktree**
   - Option A: Use the helper script (recommended for consistency):
     `~/.claude/commands/scripts/gh-worktree.sh {worktree-name}`
   - Option B: Manual creation:
     - Create a new branch named `feature/{worktree-name}` from current branch
     - Create the git worktree in the target directory using:
       `git worktree add ../{target-directory} -b feature/{worktree-name}`

5. **Switch to New Worktree**
   - Change directory to the new worktree location: `cd ../{target-directory}`
   - Confirm the switch was successful
   - Display the new working directory and branch

6. **Completion Summary**
   - Show the created worktree path
   - Display the new branch name
   - Provide instructions for returning to original worktree

## Error Handling

- **Missing argument**: Display usage message and exit
- **Invalid characters**: Only allow alphanumeric characters and hyphens
- **Directory exists**: Inform user if target directory already exists
- **Branch exists**: Handle existing branch names gracefully
- **Git errors**: Catch and display git command failures
- **Permission errors**: Handle directory creation permission issues

## Example Usage

```bash
# Current directory: /Users/paulbonneville/Developer/arrgh-fastapi
/gh-worktree new-feature

# Creates:
# - New branch: feature/new-feature
# - New worktree: /Users/paulbonneville/Developer/arrgh-fastapi-new-feature
# - Switches to new worktree directory
```

## Notes

- The original worktree remains unchanged
- To return to original worktree, use `cd` back to original directory
- To remove worktree later, use `git worktree remove <path>`
- Each worktree maintains its own working directory and branch state