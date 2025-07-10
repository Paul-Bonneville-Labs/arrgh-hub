# CLAUDE.md

This file provides guidance to Claude Code when working with the arrgh-hub repository.

## Project Overview

This repository serves as a shared hub for common tools, configurations, and utilities used across all "arrgh-" projects for AI experimentation and learning. Part of the Paul Bonneville's Lab AI exploration ecosystem, it will continue to evolve as new patterns and tools emerge.

Currently focused on Claude Code configurations and utilities, including:
- Personal Claude Code settings and configurations
- Custom slash commands for reuse across projects
- Best practices and protocols for AI-assisted development
- Multi-project workspace configuration

## Project Architecture

### Configuration Backup System
This repository implements a symbolic link backup strategy:

```
~/.claude/CLAUDE.md → Anthropic/Claude/Global/CLAUDE.md
~/.claude/settings.local.json → Anthropic/Claude/Global/config/settings.local.json  
~/.claude/commands/ → Anthropic/Claude/Global/commands/
```

**Key Principle**: The repository files are the **source of truth**, with global Claude directories linking back to them.

### Directory Structure
- `Anthropic/Claude/Global/` - Contains all backed-up global Claude configurations
- `Anthropic/Claude/Global/CLAUDE.md` - Global guidance (branch protocols, planning exports, GitHub CLI)
- `Anthropic/Claude/Global/commands/` - Custom slash commands available globally
- `Anthropic/Claude/Global/config/` - Personal settings and permissions

## Development Commands

This is a configuration repository with no build/test commands. Common operations:

### Working with Configurations
```bash
# Edit global Claude guidance
edit Anthropic/Claude/Global/CLAUDE.md

# Add new custom command  
touch Anthropic/Claude/Global/commands/new-command.md

# Update permissions
edit Anthropic/Claude/Global/config/settings.local.json
```

### Symbolic Link Management
```bash
# Verify links are working
ls -la ~/.claude/

# Recreate links if needed (see README.md setup)
```

## File Handling Guidance

### When Editing Configuration Files
- **Global Guidance**: Edit `Anthropic/Claude/Global/CLAUDE.md` for cross-project protocols
- **Project Guidance**: Edit this file (`CLAUDE.md`) for project-specific guidance
- **Custom Commands**: Add to `Anthropic/Claude/Global/commands/` for reusable slash commands

### Version Control Considerations
- All files in `Anthropic/Claude/Global/` should be committed
- These represent personal AI tooling evolution
- Changes automatically sync to global Claude via symbolic links
- Sensitive data is already filtered by `.gitignore`

## Custom Commands Available

### `/gh-branch-status`
Check git branch status, uncommitted changes, and associated PRs

Displays formatted output showing:
- Current branch information
- Working directory and commit status  
- Associated pull request details

### `/gh-new-work`
Clean up current work and start a new branch for new tasks

Two-step process:
1. **Cleanup**: Check current branch for uncommitted changes, commit if appropriate, create PR if needed
2. **New Branch**: Prompt user for work description and create appropriately named branch

### `/gh-pr-merge`
Merge the current PR, delete local branch, and return to main

Complete workflow automation:
- Finds and merges open PR for current branch
- Switches back to main branch
- Pulls latest changes
- Deletes the merged local branch

**Requirements:**
- Must have an open PR for the current branch
- Cannot be run from main branch
- Requires GitHub CLI (gh) to be authenticated

### `/gh-pr-review`
Check PR status, list comments, and create plan to address feedback

Comprehensive PR analysis workflow:
- Identifies current branch's PR and displays basic information
- Fetches and organizes review comments and general comments by author, type, and location
- Categorizes feedback into: code changes, questions, suggestions, blockers, and praise
- Creates detailed action plan with specific tasks, file locations, and complexity estimates
- Presents organized summary and asks for user approval before implementation
- Handles error cases: no PR found, API issues, empty comments, parsing errors

**Usage:** `/gh-pr-review`
**Requirements:** GitHub CLI (gh) authentication and current branch with open PR

### `/gh-ship-it`
Commit uncommitted changes and create PR if needed

Workflow steps:
- If on main branch, creates new branch first (never commits to main)
- Commits any uncommitted changes
- Creates PR for the work if one doesn't exist for current branch
- Provides status updates for each step

### `/gh-worktree`
Create a new git worktree in a sibling directory

Advanced git workflow tool:
- Creates new branch with `feature/{name}` pattern
- Sets up worktree in `{project}-{name}` directory structure
- Switches to new worktree automatically
- Handles validation and error cases

**Usage:** `/gh-worktree <name>`
**Example:** From `/Developer/arrgh-fastapi`, `/gh-worktree new-feature` creates `/Developer/arrgh-fastapi-new-feature`

**Error Handling:**
- Missing argument: Display usage message
- Invalid characters: Only alphanumeric and hyphens allowed
- Directory/branch conflicts: Graceful handling
- Git operation failures: Clear error messages

### `/ingest-web`
Fetch and summarize web resources into markdown files

Takes a URL as argument and creates a comprehensive summary:
- Fetches content using WebFetch tool
- Generates descriptive filename based on content
- Creates structured markdown with metadata
- Includes update history tracking
- Handles error cases for invalid URLs

**Usage:** `/ingest-web https://example.com/resource [optional-filename]`

### `/update-docs`
Update README.md and CLAUDE.md with current repository content and functionality

Comprehensive documentation update:
- Scans repository structure for current state
- Extracts command descriptions from YAML frontmatter
- Updates directory tree in README.md
- Updates command listings in both files
- Maintains clean section boundaries without duplication

## Important Notes

- **Global vs Project**: This repo contains BOTH global configs and project-specific guidance
- **Symbolic Links**: Changes to files here immediately affect global Claude behavior
- **Workspace Integration**: Part of larger arrgh development workspace
- **No Traditional Builds**: This is a configuration and utilities repository
- **Personal Repository**: Contains user-specific settings and preferences

## Multi-Project Context

This repository is part of the arrgh workspace:
- `arrgh-ios` - iOS application
- `arrgh-fastapi` - Backend services
- `arrgh-n8n` - Workflow automation
- `arrgh-excalidraw` - Diagramming tools

When working across projects, global configurations from this repo apply automatically.
