---
description: Update README.md and CLAUDE.md with current repository content and functionality
---

## Your task

Scan the repository and update both README.md and CLAUDE.md with current, accurate information about the available commands, repository structure, as well as general information about the purpose and use of the repo in general.

### Steps to follow:

1. **Scan for custom commands**: Look in `Anthropic/Claude Code/Global/commands/` for all `.md` files to get the current list of available commands.

2. **Extract command descriptions**: For each command file, read the description from:
   - YAML frontmatter `description:` field (primary source)
   - File content for additional usage details and bullet points
   - Avoid extracting template placeholders like `[Main purpose]` or `{name}`

3. **Update README.md**:
   - Update the directory tree in the "Repository Structure" section to include all current command files and scripts
   - Update the "Custom Commands" section with current commands and their descriptions
   - Keep descriptions concise (one line each) for the README

4. **Update CLAUDE.md**:
   - Update the "Custom Commands Available" section with current commands
   - Use richer descriptions that include usage examples and bullet points where available
   - Format each command as: `### `/command-name`` followed by description and details

5. **Avoid duplications**: 
   - Completely replace the target sections rather than appending
   - Ensure no duplicate headings or content
   - Maintain clean section boundaries

### Important:
- Do NOT create any new files
- Do NOT modify command files themselves
- Only update the two documentation files (README.md and CLAUDE.md)
