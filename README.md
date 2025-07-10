# arrgh-hub

A shared repository for common tools, configurations, and utilities used across all "arrgh-" projects for AI experimentation and learning. Part of my [Paul Bonneville's Lab](https://github.com/Paul-Bonneville-Labs) AI exploration ecosystem. This repository will continue to evolve as new patterns and tools emerge.

## Overview

Currently focused on Claude Code configurations and utilities, but will expand to include other common tools and patterns as the AI development workflow evolves.

## Repository Structure

```
arrgh-hub/
├── README.md                     # This documentation
├── CLAUDE.md                     # Project-specific Claude guidance
├── arrgh.code-workspace          # Multi-project workspace configuration
└── Anthropic/Claude/Global/      # Global Claude configuration backup
    ├── CLAUDE.md                 # Global Claude guidance & protocols
    ├── commands/                 # Custom slash commands
    │   ├── branch-status.md
    │   ├── ingest-web.md
    │   ├── merge-pr.md
    │   ├── new-work.md
    │   ├── ship-it.md
    │   ├── update-docs.md
    │   ├── worktree.md
    │   └── scripts/              # Shell scripts for commands
    │       ├── branch-status.sh
    │       ├── create-worktree.sh
    │       ├── merge-pr.sh
    │       └── update-docs-legacy.sh
    └── config/                   # Personal configuration files
        ├── pr-standards.json     # Configuration backup
        └── settings.local.json   # Claude permissions and settings
```

## Key Features

### 🔄 Symbolic Link Backup System
Global Claude directories link to repository files:
- `~/.claude/CLAUDE.md` → `Anthropic/Claude/Global/CLAUDE.md`
- `~/.claude/settings.local.json` → `Anthropic/Claude/Global/config/settings.local.json`
- `~/.claude/commands/` → `Anthropic/Claude/Global/commands/`

### 🛠️ Custom Commands
- **`/gh-branch-status`**: Check git branch status, uncommitted changes, and associated PRs
- **`/ingest-web`**: Fetch and summarize web resources into markdown files
- **`/merge-pr`**: Merge the current PR, delete local branch, and return to main
- **`/gh-new-work`**: Clean up current work and start a new branch for new tasks
- **`/gh-ship-it`**: Commit uncommitted changes and create PR if needed
- **`/update-docs`**: Update README.md and CLAUDE.md with current repository content and functionality
- **`/gh-worktree`**: Create a new git worktree in a sibling directory
## Setup

1. Clone this repository
2. Create symbolic links to your global Claude directory:
   ```bash
   # Backup existing files
   mv ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup
   mv ~/.claude/settings.local.json ~/.claude/settings.local.json.backup
   
   # Create symbolic links
   ln -s /path/to/arrgh-hub/Anthropic/Claude/Global/CLAUDE.md ~/.claude/CLAUDE.md
   ln -s /path/to/arrgh-hub/Anthropic/Claude/Global/config/settings.local.json ~/.claude/settings.local.json
   ln -s /path/to/arrgh-hub/Anthropic/Claude/Global/commands ~/.claude/commands
   ```

## Related Projects

This repository is part of the arrgh development workspace:
- **arrgh-ios**: iOS application
- **arrgh-fastapi**: Backend services  
- **arrgh-n8n**: Workflow automation
- **arrgh-excalidraw**: Diagramming tools

