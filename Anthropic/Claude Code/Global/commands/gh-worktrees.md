---
description: Git worktree manager - shows status and provides management options
---

Manage git worktrees in the `.worktrees/` folder. This command will:

1. **Show Current Worktree Status**
   - List existing worktrees in `.worktrees/` directory
   - Show current repository and branch information

2. **Provide Instructions**
   - Explain how to use the interactive script directly
   - Show available worktree management options

3. **Check for Local Script**
   - Look for project-specific `./scripts/worktree-manager.sh`
   - Provide fallback to global script if needed

2. **Script Features**
   The interactive script provides:
   - **List existing worktrees** in `.worktrees/` directory
   - **Create new worktrees** with name validation
   - **Open worktrees** (cd + launch Claude Code if available)
   - **Remove worktrees** with confirmation prompts
   - **Input validation** for worktree names
   - **Colored output** for better user experience

3. **Menu Options**
   - Select numbered worktree to open or remove
   - Create new worktree option
   - Exit option
   - Back to main menu from sub-actions

4. **Worktree Actions**
   For each existing worktree:
   - **Open**: Changes to worktree directory and launches Claude Code
   - **Finish**: Removes the worktree after confirmation
   - **Back**: Returns to main menu

## Script Capabilities

- **Automatic git root detection**: Works from any directory in the repository
- **Name validation**: Prevents invalid characters, empty names, names starting with dots/dashes
- **Conflict detection**: Checks for existing worktrees before creation  
- **Safe removal**: Confirmation prompts before deleting worktrees
- **Claude Code integration**: Automatically launches Claude Code when opening worktrees
- **Error handling**: Graceful handling of git command failures

## Workflow

1. Script shows existing worktrees in `.worktrees/` directory
2. User selects from numbered menu:
   - Select existing worktree � Choose action (open/remove)
   - Create new worktree � Enter name � Validates � Creates � Switches to new worktree
   - Exit � Terminates script

## Notes

- This is different from `/gh-worktree` which creates sibling directories
- Uses `.worktrees/` subdirectory approach for organization
- Interactive prompts handle all user input within the script
- No arguments needed - all interaction happens within the script interface
- Script will `cd` to selected worktree and may launch Claude Code, ending the session