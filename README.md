# ai-common

A continuously evolving AI development toolkit featuring automated PR standards and guardrails for AI-assisted coding agents, plus Claude Code global configuration management. This dynamic repository adapts to the rapidly changing landscape of AI-assisted development, capturing lessons learned, best practices, and emerging patterns as AI coding tools mature.

## Overview

This repository serves as a **comprehensive AI development toolkit** featuring:

1. **AI-Assisted Coding Guardrails**: A complete Pull Request standards and automation system designed specifically for AI coding agents like Claude Code and GitHub Copilot
2. **Global Configuration Management**: Version-controlled backup system for Claude Code configurations and custom commands  
3. **Cross-Project Tooling**: Shared utilities and workflows that enhance AI-assisted development across multiple repositories

The centerpiece is our **PR Standards System** - a set of automated guardrails that ensure AI-generated code changes maintain quality, security, and documentation standards while preventing common workflow failures.

## Repository Structure

```
ai-common/
├── README.md                           # This documentation
├── CLAUDE.md                          # Project-specific Claude guidance
├── workflow-validation-test.md        # Workflow testing documentation
├── Anthropic/Claude/Global/           # Global Claude configuration backup
│   ├── CLAUDE.md                      # Global Claude guidance & protocols
│   ├── PR-STANDARDS.md               # Complete PR standards documentation
│   ├── CLAUDE-CODE-PR-PROMPT.md      # AI assistant PR optimization prompts
│   ├── README-PR-STANDARDS.md        # Quick start guide for PR standards
│   ├── DEPLOYMENT-GUIDE.md           # System deployment instructions
│   ├── commands/                      # Custom slash commands
│   │   └── ingest-web.md             # Web resource summarization command
│   └── config/                        # Personal configuration files
│       ├── settings.local.json       # Claude permissions and settings
│       └── pr-standards.json         # Machine-readable PR config
├── .github/                           # GitHub automation & workflows
│   ├── workflows/                     # Automated workflow definitions
│   │   ├── pr-validation.yml         # Main PR validation workflow
│   │   ├── pr-approved.yml           # Post-merge automation workflow
│   │   ├── reusable-pr-validation.yml # Reusable validation components
│   │   └── reusable-pr-approved.yml  # Reusable approval components
│   ├── pull_request_template.md      # GitHub PR template
│   ├── pr-automation-config.yml      # Workflow configuration
│   └── scripts/                      # Automation scripts
│       └── deploy-pr-standards.sh    # Deploy PR standards to other repos
├── arrgh.code-workspace              # Multi-project workspace configuration
└── ingest-web-resource.md            # Original web ingestion prompt template
```

## Key Features

### 🛡️ AI-Assisted Coding Guardrails System

This repository includes a comprehensive **Pull Request Standards and Automation System** designed specifically as guardrails for AI-assisted coding agents like Claude Code, GitHub Copilot, and other AI development tools.

#### **Motivation & Concept**
As AI coding assistants become more powerful, the need for robust guardrails becomes critical. This system ensures that AI-generated code changes:
- Follow consistent quality standards
- Undergo proper validation and review
- Maintain security and reliability practices
- Are properly documented and tested

#### **System Components**

**📋 PR Standards Framework**
- **Conventional Commits**: Enforced format for consistent change tracking
- **Template Compliance**: Required sections for complete documentation  
- **Size Guidelines**: Automated detection of overly large changes
- **Security Scanning**: Detection of sensitive code modifications

**🤖 Automated Workflows**
- **PR Validation**: Title format, description completeness, file size checks
- **Auto-Labeling**: Smart label creation and application based on change type
- **Post-Merge Automation**: Branch cleanup, release notes, contributor acknowledgment
- **Error Recovery**: Graceful handling of missing labels and edge cases

**🔧 Smart Features**
- **Auto-Label Creation**: Missing labels are created automatically with appropriate colors
- **Event Detection Logic**: Robust handling of GitHub workflow events
- **Template Validation**: Ensures AI-generated PRs include all required sections
- **Graceful Fallbacks**: Workflows continue even when encountering errors

#### **Files & Structure**
```
.github/
├── workflows/
│   ├── pr-validation.yml              # Main PR validation workflow
│   ├── pr-approved.yml                # Post-merge automation
│   ├── reusable-pr-validation.yml     # Reusable validation components  
│   └── reusable-pr-approved.yml       # Reusable approval components
├── pull_request_template.md           # GitHub PR template
├── pr-automation-config.yml           # Workflow configuration
└── scripts/deploy-pr-standards.sh     # Deployment script for other repos

Anthropic/Claude/Global/
├── PR-STANDARDS.md                    # Complete documentation
├── CLAUDE-CODE-PR-PROMPT.md          # AI assistant optimization prompts
├── README-PR-STANDARDS.md            # Quick start guide
└── config/pr-standards.json          # Machine-readable configuration
```

#### **For AI Coding Agents**
The system includes specific optimizations for AI assistants:
- **Detailed system prompts** for consistent PR creation
- **Template compliance checking** to ensure AI follows documentation standards
- **Automated validation** that catches common AI coding patterns that need review
- **Error handling** that prevents workflow failures from stopping AI development

#### **Deployment to Other Repositories**
Use the included deployment script to add these guardrails to any repository:
```bash
.github/scripts/deploy-pr-standards.sh owner/target-repo --customize
```

#### **Recent Improvements (v1.1.0)**
Our latest iteration includes several critical fixes and enhancements:

**🔧 Workflow Reliability**
- ✅ **Auto-Label Creation**: Workflows now create missing labels automatically instead of failing
- ✅ **Event Detection Logic**: Fixed shell syntax errors that caused exit code 127 failures  
- ✅ **Error Recovery**: Enhanced graceful fallbacks for edge cases and missing dependencies
- ✅ **Command Validation**: Resolved "command not found" errors in GitHub Actions runners

**🤖 AI Assistant Optimizations**
- ✅ **Template Compliance**: Improved validation to ensure AI-generated PRs follow standards
- ✅ **Smart Labeling**: Labels are applied based on conventional commit types with auto-creation
- ✅ **Workflow Continuity**: Missing labels or configuration issues no longer stop workflows
- ✅ **Debugging Enhancement**: Better error reporting for troubleshooting workflow issues

**📋 Documentation Sync**
- ✅ **Configuration Alignment**: All config files now match actual workflow behavior
- ✅ **Deployment Scripts**: Fixed file paths and references for accurate deployment  
- ✅ **Version Management**: Updated to v1.1.0 with comprehensive change documentation
- ✅ **AI Context**: Enhanced documentation specifically for AI coding assistant integration

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

### Getting Started with AI Guardrails

To deploy the PR standards system to any repository:

```bash
# Clone this repository
git clone https://github.com/pbonneville/ai-common.git
cd ai-common

# Deploy to your target repository
./.github/scripts/deploy-pr-standards.sh your-username/your-repo --customize

# The script will:
# 1. Create a new branch in your target repo
# 2. Copy all PR standards files and workflows
# 3. Allow customization of size limits and features
# 4. Create a pull request for review
```

**What gets deployed:**
- ✅ Automated PR validation workflows
- ✅ Smart auto-labeling system  
- ✅ GitHub PR templates
- ✅ Security scanning automation
- ✅ Post-merge cleanup and release notes
- ✅ Complete documentation

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

