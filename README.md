# arrgh-hub

A shared repository for common tools, configurations, and utilities used across all "arrgh-" projects for AI experimentation and learning. Part of my [Paul Bonneville's Lab](https://github.com/Paul-Bonneville-Labs) AI exploration ecosystem. This repository will continue to evolve as new patterns and tools emerge.

## Overview

Currently focused on Claude Code and Claude Desktop configurations and utilities, but will expand to include other common tools and patterns as the AI development workflow evolves.

## Repository Structure

```
arrgh-hub/
├── README.md                     # This documentation
├── CLAUDE.md                     # Project-specific Claude guidance
├── arrgh.code-workspace          # Multi-project workspace configuration
├── Anthropic/Claude Code/Global/ # Global Claude Code configuration backup
│   ├── CLAUDE.md                 # Global Claude guidance & protocols
│   ├── commands/                 # Custom slash commands
│   │   ├── gh-branch-status.md
│   │   ├── gh-new-work.md
│   │   ├── gh-pr-merge.md
│   │   ├── gh-pr-review.md
│   │   ├── gh-ship-it.md
│   │   ├── gh-worktree.md
│   │   ├── ingest-web.md
│   │   ├── update-docs.md
│   │   └── scripts/              # Shell scripts for commands
│   │       ├── gh-branch-status.sh
│   │       ├── gh-pr-merge.sh
│   │       └── gh-worktree.sh
│   └── config/                   # Personal configuration files
│       ├── pr-standards.json     # Configuration backup
│       └── settings.local.json   # Claude permissions and settings
└── Anthropic/Claude Desktop/     # Claude Desktop configuration backup
    └── config/                   # MCP server configurations
        └── claude_desktop_config.json  # Main Claude Desktop config (gitignored)
```

## Key Features

### 🔄 Symbolic Link Backup System
Global Claude directories link to repository files:

**Claude Code:**
- `~/.claude/CLAUDE.md` → `Anthropic/Claude Code/Global/CLAUDE.md`
- `~/.claude/settings.local.json` → `Anthropic/Claude Code/Global/config/settings.local.json`
- `~/.claude/commands/` → `Anthropic/Claude Code/Global/commands/`
- `~/.claude/.claude.json` → `Anthropic/Claude Code/Global/config/.claude.json` *(gitignored - contains sensitive data)*

**Claude Desktop:**
- `~/Library/Application Support/Claude/claude_desktop_config.json` → `Anthropic/Claude Desktop/config/claude_desktop_config.json` *(gitignored - contains API keys)*

### 🛠️ Custom Commands

This repository provides custom [Claude Code slash commands](https://docs.anthropic.com/en/docs/claude-code/slash-commands) that extend Claude's capabilities with project-specific workflows. Slash commands are reusable automation scripts that can be triggered with `/command-name` syntax during conversations with Claude Code.

**Available Commands:**
- **`/gh-branch-status`**: Check git branch status, uncommitted changes, and associated PRs
- **`/gh-new-work`**: Clean up current work and start a new branch for new tasks
- **`/gh-pr-merge`**: Merge the current PR, delete local branch, and return to main
- **`/gh-pr-review`**: Check PR status, list comments, and create plan to address feedback
- **`/gh-ship-it`**: Commit uncommitted changes and create PR if needed
- **`/gh-worktree`**: Create a new git worktree in a sibling directory
- **`/ingest-web`**: Fetch and summarize web resources into markdown files
- **`/update-docs`**: Update README.md and CLAUDE.md with current repository content and functionality
## Setup

1. Clone this repository
2. Create symbolic links to your global Claude directories:

### Claude Code Setup
```bash
# Backup existing files
mv ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup
mv ~/.claude/settings.local.json ~/.claude/settings.local.json.backup
mv ~/.claude/.claude.json ~/.claude/.claude.json.backup

# Create symbolic links
ln -s /path/to/arrgh-hub/Anthropic/Claude Code/Global/CLAUDE.md ~/.claude/CLAUDE.md
ln -s /path/to/arrgh-hub/Anthropic/Claude Code/Global/config/settings.local.json ~/.claude/settings.local.json
ln -s /path/to/arrgh-hub/Anthropic/Claude Code/Global/commands ~/.claude/commands
ln -s /path/to/arrgh-hub/Anthropic/Claude Code/Global/config/.claude.json ~/.claude/.claude.json
```

### Claude Desktop Setup
```bash
# Backup existing configuration
mv "$HOME/Library/Application Support/Claude/claude_desktop_config.json" "$HOME/Library/Application Support/Claude/claude_desktop_config.json.backup"

# Create symbolic link
ln -s /path/to/arrgh-hub/Anthropic/Claude Desktop/config/claude_desktop_config.json "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
```

3. **Security Note**: Both `.claude.json` and `claude_desktop_config.json` contain sensitive information (API keys, auth tokens, personal data) and are intentionally gitignored. While they're part of the symlink workflow for personal backup, they should never be committed to the repository.

## Related Projects

This repository is part of the arrgh development workspace:
- **arrgh-ios**: iOS application
- **arrgh-fastapi**: Backend services  
- **arrgh-n8n**: Workflow automation
- **arrgh-excalidraw**: Diagramming tools

