# arrgh-hub

A shared repository for common tools, configurations, and utilities used across all "arrgh-" projects for AI experimentation and learning. Part of my [Paul Bonneville's Lab](https://github.com/Paul-Bonneville-Labs) AI exploration ecosystem. This repository will continue to evolve as new patterns and tools emerge.

## Overview

Currently focused on Claude Code configurations and utilities, but will expand to include other common tools and patterns as the AI development workflow evolves.

## Repository Structure

```
arrgh-hub/
├── README.md                     # This documentation
├── CLAUDE.md                     # Project-specific Claude guidance
├── Anthropic/Claude/Global/      # Global Claude configuration backup
│   ├── CLAUDE.md                 # Global Claude guidance & protocols
│   ├── commands/                 # Custom slash commands
│   │   ├── branch-status.md      # Git branch status command
│   │   ├── ingest-web.md         # Web resource summarization
│   │   ├── new-work.md          # New work setup command
│   │   ├── ship-it.md           # Deployment command
│   │   ├── worktree.md          # Git worktree management
│   │   └── scripts/             # Shell scripts for commands
│   └── config/                   # Personal configuration files
│       ├── settings.local.json  # Claude permissions and settings
│       └── pr-standards.json    # Configuration backup
└── arrgh.code-workspace         # Multi-project workspace configuration
```

## Key Features

### 🔄 Symbolic Link Backup System
Global Claude directories link to repository files:
- `~/.claude/CLAUDE.md` → `Anthropic/Claude/Global/CLAUDE.md`
- `~/.claude/settings.local.json` → `Anthropic/Claude/Global/config/settings.local.json`
- `~/.claude/commands/` → `Anthropic/Claude/Global/commands/`

### 🛠️ Custom Commands
- **`/branch-status`**: Git branch status checking
- **`/ingest-web`**: Web resource summarization
- **`/new-work`**: New work session setup
- **`/ship-it`**: Deployment workflow
- **`/worktree`**: Git worktree management

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

