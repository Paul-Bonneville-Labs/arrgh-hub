# Claude Code PR System Prompt

*Concise PR creation guidance for AI coding assistants*

---

## MANDATORY PR CREATION PROTOCOL

When creating pull requests, you MUST:

### 1. Title Format (REQUIRED)
```
<type>[scope]: <description>
```

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `build`, `chore`, `perf`, `ci`
**Rules**: 
- Max 50 chars, lowercase, no period
- Use imperative mood ("add" not "added")
- Be specific and descriptive

### 2. Description Structure (REQUIRED)
```markdown
## Summary
[Brief overview of what and why]

## Changes Made
- [Key change 1]
- [Key change 2]
- [Key change 3]

## Related Issues
- Closes #123
- Relates to #456

## Testing
### Steps to Test
1. [Specific step]
2. [Expected outcome]
3. [Verification step]

### Test Coverage
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated  
- [ ] Manual testing completed
- [ ] Edge cases considered

## Screenshots/Visuals
[Include for UI changes]

## Breaking Changes
**BREAKING CHANGE**: [If applicable]

## PR Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Tests added/updated and passing
- [ ] Documentation updated (if needed)
- [ ] No breaking changes (or clearly documented)
- [ ] Related issues linked
- [ ] Deployment considerations noted
- [ ] Security implications considered

## Additional Notes
[Dependencies, limitations, reviewer guidance]
```

### 3. Size Guidelines
- **Target**: 200-400 lines of code
- **Max files**: 5-10 files
- **Large PRs**: Justify size and add extra context

### 4. Automation Integration
- **Auto-label** based on type (`feat` → `enhancement`)
- **Link issues** using "Closes #", "Fixes #", "Relates to #"
- **Include visuals** for UI changes
- **Document breaking changes** clearly

---

## QUICK EXAMPLES

### Good Titles
```
feat(auth): add OAuth2 Google integration
fix(api): resolve race condition in user sessions
docs(deploy): add Docker deployment guide
refactor(utils): extract validation functions
```

### Bad Titles
```
❌ Fixed bug
❌ Updates  
❌ Feature work
❌ Various changes
```

### Template Usage
Always include ALL required sections. Remove optional sections if not applicable, but NEVER skip required ones.

---

## CLAUDE CODE INTEGRATION

### System Behavior
1. **ALWAYS** validate title format before creating PR
2. **ALWAYS** include all required sections in description
3. **ALWAYS** provide specific testing instructions
4. **ALWAYS** link related issues when creating PRs
5. **ALWAYS** suggest appropriate labels based on change type
6. **NEVER** create PR without proper description template

### Error Handling
- If title doesn't match format → Ask user to correct
- If required sections missing → Add them automatically
- If no testing info → Request from user
- If breaking changes → Ensure clearly documented

---

*This prompt ensures consistent, high-quality PR creation following industry standards.* 