# Pull Request Standards & Guidelines

*System prompt material for Claude Code and team reference documentation*

---

## 🎯 Purpose

This document provides standardized guidelines for creating, reviewing, and managing pull requests. It serves as:
- **System prompt material** for AI coding assistants (Claude Code, GitHub Copilot, etc.)
- **Team reference documentation** for consistent PR practices
- **Automated tooling configuration** basis

---

## 📝 PR Title Standards

### Conventional Commits Format (REQUIRED)
```
<type>[optional scope]: <description>

Examples:
feat: add user authentication system
fix(api): resolve null pointer error in user validation
docs: update README with deployment instructions
refactor(auth): simplify JWT token validation logic
```

### Commit Types
- **feat** - New features or functionality
- **fix** - Bug fixes
- **docs** - Documentation changes only
- **style** - Code style/formatting (no logic changes)
- **refactor** - Code restructuring (no feature/bug changes)
- **test** - Adding or modifying tests
- **build** - Build system, dependencies, CI/CD changes
- **chore** - Maintenance tasks, configuration updates
- **perf** - Performance improvements
- **ci** - Continuous integration changes

### Title Requirements
- **Length**: 50 characters max for title
- **Case**: Lowercase, no period at end
- **Mood**: Use imperative present tense ("add" not "added")
- **Clarity**: Be specific and descriptive

---

## 📄 PR Description Template

### Required Sections

```markdown
## Summary
Brief overview of what this PR accomplishes and why it's needed.

## Changes Made
- Bullet point list of key changes
- Focus on what changed, not how
- Include file/component names when relevant

## Related Issues
- Closes #123
- Relates to #456
- Part of epic #789

## Testing
### Steps to Test
1. Specific step-by-step testing instructions
2. Include any setup requirements
3. Expected outcomes for each step

### Test Coverage
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed
- [ ] Edge cases considered

## Screenshots/Visuals
<!-- Include for UI changes, API responses, etc. -->

## Breaking Changes
<!-- If applicable, clearly describe any breaking changes -->
**BREAKING CHANGE**: Description of what breaks and migration steps

## Additional Notes
- Dependencies or related work
- Known limitations
- Future considerations
- Reviewer-specific guidance
```

### Optional Advanced Sections
```markdown
## Performance Impact
- Benchmark results
- Memory usage changes
- Database query impacts

## Security Considerations
- Authentication/authorization changes
- Data validation updates
- Potential security implications

## Documentation Updates
- [ ] API documentation updated
- [ ] README updated
- [ ] Architecture docs updated
- [ ] Deployment guides updated
```

---

## 🔍 PR Size Guidelines

### Ideal Size Targets
- **Lines of Code**: 200-400 LOC (excluding tests, generated code)
- **Files Changed**: 5-10 files maximum
- **Scope**: Single feature, bug fix, or logical unit of work

### Large PR Guidelines
If PR exceeds ideal size:
1. **Justify in description** why it can't be split
2. **Add extra context** and documentation
3. **Include detailed testing** instructions
4. **Consider draft PR** for early feedback
5. **Break down in checklist** format for reviewers

---

## ✅ PR Checklist Template

Include this checklist in PR descriptions:

```markdown
## PR Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Tests added/updated and passing
- [ ] Documentation updated (if needed)
- [ ] No breaking changes (or clearly documented)
- [ ] Related issues linked
- [ ] Deployment considerations noted
- [ ] Security implications considered
```

---

## 🏷️ Labeling Strategy

### Automatic Labels (via PR title)
- `feat` → `enhancement`
- `fix` → `bug`
- `docs` → `documentation`
- `test` → `testing`
- `refactor` → `refactoring`
- `build/ci` → `ci-cd`

### Manual Labels
- `breaking-change` - For breaking changes
- `needs-review` - Ready for review
- `work-in-progress` - Draft/incomplete
- `security` - Security-related changes
- `performance` - Performance improvements
- `dependencies` - Dependency updates

---

## 🔄 PR Workflow Best Practices

### Before Creating PR
1. **Self-review** code changes thoroughly
2. **Run tests** locally and ensure they pass
3. **Update documentation** as needed
4. **Rebase/squash** commits if needed for clean history
5. **Verify branch** is up to date with target branch

### Draft PRs
Use draft PRs when:
- Work is incomplete but feedback needed
- Large changes requiring early review
- Experimental features requiring discussion
- Cross-team collaboration needed

### PR Updates
When addressing review feedback:
1. **Respond to comments** before pushing changes
2. **Group related changes** in single commits
3. **Update description** if scope changes significantly
4. **Re-request review** after major changes

---

## 🤖 AI Assistant Integration

### For Claude Code
When creating PRs, always:
1. **Follow conventional commit format** for titles
2. **Use the template** provided above
3. **Include testing instructions** specific to the changes
4. **Link related issues** automatically when possible
5. **Add appropriate labels** based on change type

### System Prompt Instructions
```
When creating pull requests:
1. ALWAYS use conventional commit format for titles
2. ALWAYS include the required sections from PR template
3. ALWAYS provide specific testing instructions
4. ALWAYS link to related issues using "Closes #", "Fixes #", or "Relates to #"
5. ALWAYS add appropriate labels based on the type of change
6. ALWAYS ensure PR description explains the "why" not just the "what"
7. ALWAYS include breaking change documentation if applicable
```

---

## 🔧 Automation Integration

### GitHub Actions Integration
This standard supports:
- **PR title validation** (conventional commits)
- **Automatic labeling** based on title/content
- **Size validation** (warn if too large)
- **Template compliance** checking
- **Link validation** (issues, docs)

### Configuration Examples
```yaml
# .github/workflows/pr-validation.yml
name: PR Validation
on:
  pull_request:
    types: [opened, edited, synchronize]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - name: Validate PR Title
        uses: amannn/action-semantic-pull-request@v5
        with:
          types: |
            feat
            fix
            docs
            style
            refactor
            test
            build
            chore
            perf
            ci
```

---

## 📊 Quality Metrics

### Success Indicators
- **Review Time**: Average < 24 hours for first review
- **PR Size**: 80% of PRs under 400 LOC
- **Template Compliance**: 95% include required sections
- **Test Coverage**: No PRs merged without tests (exceptions documented)
- **Documentation**: 100% of feature PRs include doc updates

### Measurement Tools
- GitHub Insights
- PR size tracking
- Template compliance automation
- Review time analytics

---

## 🎓 Examples

### Good PR Title Examples
```
feat(auth): add OAuth2 integration with Google
fix(api): resolve race condition in user session handling
docs(deploy): add Docker deployment guide
refactor(utils): extract common validation functions
test(auth): add comprehensive unit tests for login flow
```

### Bad PR Title Examples
```
❌ Fixed bug (too vague)
❌ Updates (no context)
❌ Feature work (not descriptive)
❌ Various changes (multiple purposes)
❌ Fixed the thing that was broken (unprofessional)
```

### Good PR Description Example
```markdown
## Summary
Implements user authentication system using OAuth2 with Google and GitHub providers. This addresses the security requirement from issue #123 and enables single sign-on functionality.

## Changes Made
- Added OAuth2 service with Google/GitHub provider support
- Implemented JWT token management with refresh logic
- Created user profile management endpoints
- Added authentication middleware for protected routes
- Updated database schema with user authentication tables

## Related Issues
- Closes #123 (User authentication system)
- Relates to #145 (Single sign-on epic)

## Testing
### Steps to Test
1. Start the application with `npm run dev`
2. Navigate to `/login` page
3. Click "Sign in with Google" button
4. Complete OAuth flow in popup window
5. Verify redirect to dashboard with user profile
6. Test logout functionality

### Test Coverage
- [x] Unit tests for OAuth service (95% coverage)
- [x] Integration tests for auth endpoints
- [x] Manual testing completed on Chrome/Firefox
- [x] Edge cases: network errors, invalid tokens

## Screenshots
[Login page screenshot]
[User dashboard screenshot]

## Additional Notes
- Requires GOOGLE_CLIENT_ID and GITHUB_CLIENT_ID environment variables
- Database migrations will run automatically on deployment
- Consider rate limiting for auth endpoints in future PR
```

---

## 🔄 Continuous Improvement

### Regular Reviews
- **Monthly team retrospectives** on PR process
- **Quarterly updates** to standards based on learnings
- **Tool evaluation** for automation opportunities
- **Metrics analysis** and process optimization

### Feedback Channels
- GitHub discussions for process improvements
- Team chat channels for quick questions
- Retrospective meetings for deeper analysis
- Documentation updates via PR to this file

---

*Last Updated: 2025-01-21*
*Next Review: 2025-04-21* 