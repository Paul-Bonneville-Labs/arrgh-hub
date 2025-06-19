When summarizing a URL resource, create a new .md file with a short file name that reflects the content. Use this format for the file's content. So each capitalized section, use the instructions found in the :
---
RESOURCE
[https://www.anthropic.com/engineering/claude-code-best-practices]

UPDATE HISTORY:
| Date       | Change Description         |
|------------|---------------------------|
| 2024-06-21 | Initial summary created    |

SUMMARY:
- Claude Code is a command line tool for agentic coding, designed to be flexible, scriptable, and safe, but requires users to develop their own best practices.
- Use `CLAUDE.md` files in your repo (root, subfolders, or home directory) to document commands, code style, workflows, and project-specific tips; these are automatically pulled into Claude's context.
- Regularly tune and iterate on your `CLAUDE.md` content for clarity and effectiveness, and consider sharing improvements with your team.
- Curate Claude's tool allowlist for safety, using session prompts, `/permissions`, or config files to control what Claude can do automatically.
- Install the `gh` CLI for seamless GitHub integration.
- Document custom tools and scripts in `CLAUDE.md` and provide usage examples so Claude can use them effectively.
- Leverage MCP and REST APIs for more complex tool integrations, and use `.mcp.json` for project-wide tool access.
- Store reusable prompt templates as slash commands in `.claude/commands` for team-wide access to common workflows.
- Use correction tools like `/undo`, `/revert`, and `/clear` to manage context and iterate on solutions.
- For large or complex tasks, use Markdown checklists or scratchpads to break down work and track progress.
- Provide data to Claude via copy-paste, piping, file reads, or bash commands for flexible context gathering.
- Use headless mode (`claude -p`) for automation in CI, pre-commit hooks, or pipelines, and stream output as needed.
- Employ multi-Claude workflows (multiple sessions, checkouts, or worktrees) for parallel development, code review, and testing.
- Clean up and manage worktrees and sessions for efficient multi-agent workflows.
- Regularly review and improve your prompts, tool configurations, and workflow documentation for best results.
--- 