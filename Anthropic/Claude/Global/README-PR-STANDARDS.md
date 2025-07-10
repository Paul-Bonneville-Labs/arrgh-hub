# PR Standards System

A comprehensive, industry-standard approach to pull request creation and management, optimized for AI coding assistants.

---

## 📁 File Structure

```
Anthropic/Claude/Global/
├── PR-STANDARDS.md              # Complete reference documentation
├── CLAUDE-CODE-PR-PROMPT.md     # Concise system prompt for AI assistants
├── README-PR-STANDARDS.md       # This file
└── config/
    └── pr-standards.json        # Machine-readable configuration

.github/
└── pull_request_template.md     # GitHub PR template
```

---

## 🎯 Purpose & Benefits

### For AI Coding Assistants (Claude Code)
- **Consistent PR Creation**: Standardized format every time
- **Quality Assurance**: Built-in checklists and requirements
- **Automation Integration**: Ready for GitHub Actions and tooling
- **Industry Compliance**: Follows Conventional Commits specification

### For Development Teams  
- **Faster Reviews**: Clear, structured information
- **Better Documentation**: Comprehensive change tracking
- **Automated Workflows**: Label assignment, size validation
- **Knowledge Sharing**: Examples and best practices included

---

## 🚀 Quick Start

### For Claude Code Integration

1. **Reference in CLAUDE.md**: Already updated to point to these standards
2. **System Prompt**: Use `CLAUDE-CODE-PR-PROMPT.md` content in your prompts
3. **Validation**: Claude will automatically follow the format

### Example Claude Code Usage
```bash
# Claude will automatically apply PR standards when creating PRs
claude "Create a PR for the new authentication feature"
```

### For Manual Use
1. **Follow Title Format**: `feat(auth): add OAuth2 integration`
2. **Use GitHub Template**: Will auto-populate when creating PR
3. **Complete Checklist**: Ensure all required sections are filled

---

## 📋 Standards Overview

### Title Format (Conventional Commits)
```
<type>[optional scope]: <description>

Examples:
feat: add user authentication
fix(api): resolve memory leak in parser
docs(readme): update installation instructions
```

### Required Description Sections
- ✅ **Summary** - What and why
- ✅ **Changes Made** - Key modifications  
- ✅ **Related Issues** - Link with `Closes #123`
- ✅ **Testing** - Steps and coverage
- ✅ **PR Checklist** - Quality gates

### Optional Sections
- Screenshots/Visuals
- Breaking Changes
- Performance Impact
- Security Considerations
- Additional Notes

---

## 🔧 Integration Options

### Option 1: Claude Code (Recommended)
- **Auto-applies** standards when creating PRs
- **Validates** title format
- **Includes** all required sections
- **Links** issues automatically

### Option 2: GitHub Template
- **Manual** PR creation uses template
- **Guided** completion of sections
- **Consistent** structure across team

### Option 3: GitHub Actions (Advanced)
- **Validates** PR titles and content
- **Auto-labels** based on type
- **Enforces** size guidelines
- **Checks** template compliance

---

## 🤖 GitHub Actions Automation

This system includes comprehensive GitHub Actions workflows that automatically enforce and enhance your PR standards:

### 📁 Workflow Files
```
.github/
├── workflows/
│   ├── pr-validation.yml       # Validates PRs on creation/edit
│   └── pr-approved.yml         # Handles post-approval actions
├── pull_request_template.md    # GitHub PR template
└── pr-automation-config.yml    # Configuration file
```

### ⚙️ Automation Features

#### PR Validation Workflow
**Triggers**: PR opened, edited, or synchronized
- ✅ **Title Validation**: Enforces Conventional Commits format
- 📏 **Size Analysis**: Warns on large PRs, fails on extremely large ones
- 🏷️ **Auto-labeling**: `feat` → `enhancement`, `fix` → `bug`, etc.
- 📋 **Description Check**: Ensures required sections are present
- 🔒 **Security Scanning**: Detects security-related changes
- ⚡ **Breaking Changes**: Identifies and labels breaking changes
- 📊 **Metrics Report**: Provides detailed PR statistics

#### Post-Approval Workflow  
**Triggers**: PR approved or merged
- 🔄 **Smart Auto-merge**: Merges safe PRs (docs, tests, chores)
- 📝 **Release Notes**: Auto-generates pending release notes
- 🚨 **Breaking Change Alerts**: Creates issues for breaking changes
- 🙏 **Contributor Thanks**: Personalized thank you messages
- 🧹 **Branch Cleanup**: Deletes feature branches after merge
- 📈 **Statistics**: Updates project contribution metrics

### 🎛️ Configuration Options
All behavior controlled by `.github/pr-automation-config.yml`:

```yaml
# Size thresholds
size_limits:
  small: { max_lines: 400, max_files: 10 }
  medium: { max_lines: 800, max_files: 15 }
  
# Auto-merge settings  
auto_merge:
  enabled: true
  safe_types: [docs, test, style, chore]
  
# Notification preferences
notifications:
  thank_contributors: true
  size_warnings: true
  metrics_reporting: true
```

### 🚦 What Happens When...

| Event | Automated Actions |
|-------|-------------------|
| **PR Created** | Validate title, check size, apply labels, verify description |
| **PR Approved** | Consider auto-merge for safe changes |
| **PR Merged** | Thank contributor, update release notes, cleanup branch |
| **Breaking Change** | Create release planning issue, special labeling |
| **Large PR** | Post size warning with guidelines |
| **Missing Sections** | Comment with required template sections |

### 🔧 Customization
- **Edit config file** to adjust thresholds and behaviors
- **Disable features** by setting `enabled: false`
- **Add custom labels** in the configuration
- **Modify size limits** based on your team's preferences

---

## 📊 Customization

### Modify Standards
Edit `PR-STANDARDS.md` to adjust:
- Commit types and descriptions
- Required/optional sections
- Size guidelines
- Automation rules

### Update Configuration
Edit `config/pr-standards.json` for:
- Machine-readable rules
- Integration settings
- Validation parameters
- Label mappings

### Adapt for Projects
Create project-specific versions by:
1. Copying to project root
2. Modifying for project needs
3. Updating local CLAUDE.md references

---

## 🎓 Examples

### Good PR Title
```
feat(auth): add OAuth2 Google integration
```

### Complete PR Description
```markdown
## Summary
Implements OAuth2 authentication with Google provider to replace basic auth system.

## Changes Made
- Added OAuth2Service with Google provider
- Updated login UI with Google sign-in button
- Implemented JWT token management
- Added user profile persistence

## Related Issues
- Closes #123 (OAuth2 authentication)
- Relates to #145 (Security improvements epic)

## Testing
### Steps to Test
1. Start app with `npm run dev`
2. Click "Sign in with Google"
3. Complete OAuth flow
4. Verify user profile loads

### Test Coverage
- [x] Unit tests for OAuth2Service
- [x] Integration tests for auth endpoints  
- [x] Manual testing in Chrome/Firefox
- [x] Error scenarios tested

## Screenshots
[Login page with Google button]
[User dashboard after login]

## PR Checklist
- [x] Code follows project style guidelines
- [x] Self-review completed
- [x] Tests added/updated and passing
- [x] Documentation updated
- [x] No breaking changes
- [x] Related issues linked
- [x] Security implications considered

## Additional Notes
- Requires GOOGLE_CLIENT_ID environment variable
- Users will need to re-authenticate on first login
```

---

## 🔄 Maintenance

### Regular Updates
- **Monthly**: Review usage and feedback
- **Quarterly**: Update standards based on team needs
- **Annually**: Align with industry best practices

### Version Control
- All changes via PR to this documentation
- Version tracked in `config/pr-standards.json`
- Breaking changes clearly documented

### Team Adoption
- Training materials available in examples
- Onboarding includes PR standards review
- Regular retrospectives on PR quality

---

## 🆘 Troubleshooting

### Claude Code Not Following Standards
1. Check CLAUDE.md references are correct
2. Verify prompt includes required sections
3. Update Claude with latest standards

### GitHub Template Not Working
1. Confirm `.github/pull_request_template.md` exists
2. Check template syntax
3. Verify repository settings allow templates

### Automation Issues
1. Review GitHub Actions configuration
2. Check repository permissions
3. Validate JSON configuration syntax

---

## 📚 Additional Resources

- **Conventional Commits**: https://www.conventionalcommits.org/
- **GitHub PR Best Practices**: See research in PR-STANDARDS.md
- **Claude Code Documentation**: Links in main CLAUDE.md
- **Team Adoption Guide**: Examples in PR-STANDARDS.md

---

*This system creates a professional, consistent, and automated approach to PR management that scales with your team and integrates seamlessly with AI coding assistants.* 