# CLAUDE.md

This file provides guidance to Claude Code when working with the ai-common repository.

## Project Overview

This repository serves as a **Claude Code global configuration backup and utilities** system. It contains:
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

### `/ingest-web`
Fetches and summarizes web resources into standardized markdown format.
- Usage: `/ingest-web <url> [optional-filename]`
- Creates formatted summary with RESOURCE, UPDATE HISTORY, and SUMMARY sections
- Generates descriptive filenames automatically

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