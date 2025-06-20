# ⚠️ CRITICAL: Git Branch Management Protocol ⚠️

  **MANDATORY CHECKS BEFORE ANY CODE OR FILE CHANGES**

  Before making ANY edits, commits, or file modifications, you MUST follow this protocol:

  ## 1. Branch Status Check
  ```bash
  git branch --show-current
  ```

  ## 2. Branch Decision Logic

  If on "main" branch:

  - STOP - Never make changes directly to main
  - Create a new feature branch immediately
  - Branch naming convention: [type]/[short-description]
    - feature/ - New functionality
    - fix/ - Bug fixes
    - update/ - Documentation or config updates
    - refactor/ - Code improvements
  - ALWAYS confirm branch name with user before creating

  If on existing branch:

  - Evaluate alignment: Do proposed changes fit the branch's current focus?
  - If aligned: Proceed with changes
  - If misaligned: Ask user if you should:
    - Create a new branch for the new work, or
    - Continue on current branch (with user approval)

  ## 3. Required User Confirmation

  Before creating any new branch, you MUST ask:
  "I need to create a new branch for this work. I propose to call it [branch-name]. Is this 
  acceptable, or would you prefer a different name?"

  ## 4. Branch Creation Process

  git checkout -b [approved-branch-name]

  ## 5. Work Completion

  - Keep related changes together on the same branch
  - Create focused, cohesive commits
  - When work is complete, create PR for review/merge
  - When user says "ship it", commit the code to the appropriate branch and create a PR

  ## NEVER BYPASS THIS PROTOCOL - Always check branch status first!

  This rule ensures:
  - No accidental changes to main branch
  - Descriptive, purposeful branch names
  - User approval for branch creation
  - Focused, aligned work on each branch
  - Proper git workflow hygiene

# ⚠️ CRITICAL: Planning Session Export Protocol (ALWAYS CHECK) ⚠️

**MANDATORY STEP WHEN EXITING PLAN MODE**

As soon as the user approves a plan and before proceeding with any plan implementation or coding:
1. Create `docs-ai/planning/` folder if it doesn't exist
2. Export planning session to: `docs-ai/planning/YYYY-MM-DD_HH-MM_[descriptive-keywords].md`
3. Use format: ISO date, time, and 2-4 keywords describing the planning topic
4. Include complete planning context, decisions, and next steps
5. Structure as searchable markdown with clear sections

**Required Content:**
- Problem statement and context
- Options evaluated with pros/cons
- Selected approach and reasoning
- Implementation steps and decisions
- Outcomes and success metrics
- Key files modified
- Lessons learned

**Template Reference:** Check existing files in `docs-ai/planning/` for format examples

# GitHub CLI Permissions

This project requires specific GitHub CLI permissions for Claude Code to manage issues, projects, and CI/CD workflows.

## Required Scopes
```bash
# Essential scopes for full project management
repo                    # Full repository access (read/write code, issues, PRs)
project                 # GitHub Projects v2 access (create/edit project items)
workflow                # GitHub Actions access (view/trigger workflows)
read:org                # Organization access (for org-level projects)
```

## Quick Permission Restoration
If Claude Code loses permissions, run these commands to restore access:

```bash
# Standard refresh with all required scopes
gh auth refresh -s repo -s project -s workflow -s read:org

# Alternative: Interactive refresh (will prompt for scopes)
gh auth refresh

# Verify current permissions
gh auth status
```

## Troubleshooting GitHub CLI Issues

**Permission Denied Errors:**
```bash
# Check current scopes
gh auth status

# Refresh with missing scopes
gh auth refresh -s [missing-scope]
```

**Project Access Issues:**
```bash
# Verify project exists and is accessible
gh project list --owner [username]

# View project details
gh project view [number] --owner [username]
```

**Common Commands for Project Management:**
```bash
# Create issue and add to project
gh issue create --title "Issue Title" --body "Description" --project "Project Name"

# Add existing issue to project
gh project item-add [project-number] --owner [username] --url [issue-url]

# List project items
gh project item-list [project-number] --owner [username]
```

## Personal Access Token Alternative

For more stable, long-term access, consider using a Personal Access Token (PAT):

1. **Create PAT**: GitHub Settings → Developer settings → Personal access tokens
2. **Required Scopes**: `repo`, `project`, `workflow`, `read:org`
3. **Configure CLI**: `gh auth login --with-token < token.txt`
4. **Expiration**: Set to 90 days or 1 year for stability

**PAT Management:**
- Store token securely
- Set calendar reminder before expiration
- Keep backup refresh commands available

## Quick Reference
```bash
# Emergency permission restore
gh auth refresh -s repo -s project -s workflow -s read:org

# For new token setup or renewal
gh auth login --with-token

# Check everything is working
gh auth status && gh project list --owner pbonneville

# Test project access
gh project view 1 --owner pbonneville
```

# Command Shortcuts and Special Instructions

## Git and Workflow Shortcuts

- When user says "ship", it means:
  - Commit the current work via git
  - Open a Pull Request for the current branch
  - If no relevant branch exists, propose creating a new branch and get user verification