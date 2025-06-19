# ai-common

A personal repository for Claude Code global configuration backup, custom commands, and AI development utilities.

## Overview

This repository serves as a version-controlled backup system for Claude Code global configurations and custom commands. It demonstrates a robust approach to maintaining personal AI tooling settings across projects while enabling sharing and collaboration.

## Repository Structure

```
ai-common/
├── README.md                           # This documentation
├── CLAUDE.md                          # Project-specific Claude guidance
├── Anthropic/Claude/Global/           # Global Claude configuration backup
│   ├── CLAUDE.md                      # Global Claude guidance & protocols
│   ├── commands/                      # Custom slash commands
│   │   └── ingest-web.md             # Web resource summarization command
│   └── config/                        # Personal configuration files
│       └── settings.local.json       # Claude permissions and settings
├── arrgh.code-workspace              # Multi-project workspace configuration
└── ingest-web-resource.md            # Original web ingestion prompt template
```

## Key Features

### 🔄 Symbolic Link Backup System
- **Global CLAUDE.md**: `~/.claude/CLAUDE.md` → `Anthropic/Claude/Global/CLAUDE.md`
- **Settings**: `~/.claude/settings.local.json` → `Anthropic/Claude/Global/config/settings.local.json`
- **Commands**: `~/.claude/commands/` → `Anthropic/Claude/Global/commands/`

This approach ensures:
- Version control of personal Claude configurations
- Single source of truth in the repository
- Automatic sync across all projects
- Backup and restore capabilities

### 🛠️ Custom Commands

#### `/ingest-web` Command
Fetches web resources and creates standardized markdown summaries.

**Usage:**
```bash
/ingest-web https://example.com/article
/ingest-web https://example.com/article custom-filename
```

**Output Format:**
```markdown
---
RESOURCE
[URL]

UPDATE HISTORY:
| Date | Changes |
|------|---------|
| YYYY-MM-DD | Initial creation |

SUMMARY:
- Key fact 1
- Key fact 2
- Important recommendations
---
```

### 📋 Global Configuration
- **Branch Management Protocol**: Enforced git workflow with feature branches
- **Planning Session Exports**: Automated documentation of planning sessions
- **GitHub CLI Permissions**: Pre-configured scopes for full project management
- **Personal Access Token Guidance**: Stable authentication setup

## Setup Instructions

### For Personal Use
1. Clone this repository
2. Create symbolic links to your global Claude directory:
   ```bash
   # Backup existing files
   mv ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup
   mv ~/.claude/settings.local.json ~/.claude/settings.local.json.backup
   
   # Create symbolic links
   ln -s /path/to/ai-common/Anthropic/Claude/Global/CLAUDE.md ~/.claude/CLAUDE.md
   ln -s /path/to/ai-common/Anthropic/Claude/Global/config/settings.local.json ~/.claude/settings.local.json
   ln -s /path/to/ai-common/Anthropic/Claude/Global/commands ~/.claude/commands
   ```

### For Team Sharing
- Custom commands in `Anthropic/Claude/Global/commands/` can be shared
- Project-specific configurations remain in root `CLAUDE.md`
- Adapt symbolic link paths for your environment

## Related Projects

This repository is part of a larger development workspace including:
- **arrgh-ios**: iOS application development
- **arrgh-fastapi**: FastAPI backend services  
- **arrgh-n8n**: Workflow automation
- **arrgh-excalidraw**: Diagramming and visualization tools

## Maintenance

### Updating Global Configuration
1. Edit files in `Anthropic/Claude/Global/`
2. Changes automatically reflect in `~/.claude/` via symbolic links
3. Commit changes to preserve configuration evolution

### Adding New Commands
1. Create new `.md` file in `Anthropic/Claude/Global/commands/`
2. Command becomes available as `/command-name`
3. Use `$ARGUMENTS` placeholder for dynamic input

## Best Practices

- Keep global guidance in `Anthropic/Claude/Global/CLAUDE.md`
- Maintain project-specific guidance in root `CLAUDE.md`
- Version control all configuration changes
- Document custom commands with usage examples
- Regularly review and update permissions in `settings.local.json`

