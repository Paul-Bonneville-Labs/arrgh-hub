# PR Standards System - Deployment Guide

*Centralized management and deployment of PR standards across multiple repositories*

---

## 🎯 Overview

This guide explains how to deploy and manage the PR Standards System across multiple repositories using the hybrid centralized approach.

### System Architecture

```
arrgh-hub (Central Repository)
├── 📋 Standards & Documentation
├── 🔧 Reusable Workflows
├── 🚀 Deployment Scripts
└── ⚙️ Configuration Templates

Target Repositories
├── 📎 Thin Wrapper Workflows
├── 🎛️ Local Configuration
└── 📖 Symlinked Documentation
```

---

## 🚀 Quick Deployment

### Option 1: Automated Script (Recommended)

```bash
# From arrgh-hub repository root
./.github/scripts/deploy-pr-standards.sh pbonneville/target-repo

# With customization prompts
./.github/scripts/deploy-pr-standards.sh pbonneville/target-repo --customize

# Dry run to see what would be deployed
./.github/scripts/deploy-pr-standards.sh pbonneville/target-repo --dry-run
```

### Option 2: Manual Deployment

1. **Clone target repository**
2. **Copy core files** from arrgh-hub
3. **Customize configuration**
4. **Create and merge PR**

---

## 📁 File Structure

### Central Repository (arrgh-hub)

```
arrgh-hub/
├── Anthropic/Claude/Global/
│   ├── PR-STANDARDS.md              # Complete documentation
│   ├── CLAUDE-CODE-PR-PROMPT.md     # AI assistant integration
│   ├── README-PR-STANDARDS.md       # Usage guide
│   └── config/
│       └── pr-standards.json        # Machine-readable config
├── .github/
│   ├── scripts/
│   │   └── deploy-pr-standards.sh   # Deployment automation
│   ├── workflows/                   # All workflows (main and reusable)
│   │   ├── reusable-pr-validation.yml
│   │   └── reusable-pr-approved.yml
│   │   # Wrapper workflows
│   │   ├── pr-validation.yml
│   │   └── pr-approved.yml
│   ├── pull_request_template.md     # Standard PR template
│   └── pr-automation-config.yml     # Configuration template
└── DEPLOYMENT-GUIDE.md              # This file
```

### Target Repository Structure

```
target-repo/
├── Anthropic/Claude/Global/         # Deployed documentation
├── .github/
│   ├── workflows/                   # All workflows
│   │   ├── pr-validation.yml       # Wrapper workflow
│   │   ├── pr-approved.yml         # Wrapper workflow
│   │   ├── reusable-pr-validation.yml  # Reusable workflow
│   │   └── reusable-pr-approved.yml    # Reusable workflow
│   ├── pull_request_template.md     # PR template
│   └── pr-automation-config.yml     # Local configuration
└── (project files...)
```

---

## ⚙️ Configuration Options

### Repository-Specific Customization

Each target repository can customize:

#### PR Size Limits
```yaml
# .github/workflows/pr-validation.yml
with:
  small_max_lines: 400    # Customize per project
  small_max_files: 10
  medium_max_lines: 800
  medium_max_files: 15
```

#### Feature Toggles
```yaml
# Enable/disable features per repository
enable_auto_labeling: true
enable_security_scanning: false    # Disable for public repos
enable_metrics_reporting: true
```

#### Auto-merge Configuration
```yaml
# .github/workflows/pr-approved.yml
with:
  enable_auto_merge: true
  auto_merge_types: 'docs,test,style,chore'
  auto_merge_method: 'squash'
```

### Global Configuration

Centrally managed in `arrgh-hub`:

#### Conventional Commit Types
```json
// Anthropic/Claude/Global/config/pr-standards.json
{
  "conventionalCommits": {
    "types": [
      {"type": "feat", "description": "New features"},
      {"type": "fix", "description": "Bug fixes"},
      // ...
    ]
  }
}
```

---

## 🔄 Deployment Workflows

### 1. New Repository Setup

```bash
# Deploy to new repository
./.github/scripts/deploy-pr-standards.sh owner/new-repo --customize

# Review the created PR
gh pr view --repo owner/new-repo

# Merge when ready
gh pr merge --repo owner/new-repo --squash
```

### 2. Existing Repository Update

```bash
# Update existing deployment
./.github/scripts/deploy-pr-standards.sh owner/existing-repo --force

# Or use dry-run to preview changes
./.github/scripts/deploy-pr-standards.sh owner/existing-repo --dry-run
```

### 3. Bulk Deployment

```bash
# Deploy to multiple repositories
repos=("owner/repo1" "owner/repo2" "owner/repo3")

for repo in "${repos[@]}"; do
  echo "Deploying to $repo..."
  ./.github/scripts/deploy-pr-standards.sh "$repo"
done
```

---

## 🔧 Maintenance & Updates

### Updating the Central System

1. **Modify reusable workflows** in `.github/workflows/` (prefixed with `reusable-`)
2. **Update documentation** in `Anthropic/Claude/Global/`
3. **Test changes** in arrgh-hub first
4. **Deploy updates** to target repositories

### Version Management

#### Semantic Versioning for Workflows
```yaml
# Tag workflow versions
git tag -a pr-standards-v1.2.0 -m "PR Standards System v1.2.0"
git push origin pr-standards-v1.2.0

# Use specific versions in target repos
uses: pbonneville/arrgh-hub/.github/workflows/reusable-pr-validation.yml@pr-standards-v1.2.0
```

#### Update Propagation
```bash
# Script to update all repositories
#!/bin/bash
repos=($(gh repo list --json name --jq '.[].name'))

for repo in "${repos[@]}"; do
  ./.github/scripts/deploy-pr-standards.sh "pbonneville/$repo" --force
done
```

---

## 📊 Monitoring & Analytics

### Deployment Status Dashboard

```bash
# Check deployment status across repositories
./.github/scripts/check-deployment-status.sh

# Example output:
# ✅ pbonneville/arrgh-ios - v1.2.0 (deployed)
# ⚠️  pbonneville/arrgh-fastapi - v1.1.0 (outdated)
# ❌ pbonneville/new-repo - not deployed
```

### Workflow Usage Metrics

Track adoption and effectiveness:
- PR validation success rates
- Auto-merge utilization
- Time to merge improvements
- Developer satisfaction surveys

---

## 🛠️ Troubleshooting

### Common Issues

#### 1. Workflow Not Triggering
```bash
# Check workflow syntax
gh workflow list --repo owner/repo

# View workflow runs
gh run list --repo owner/repo --workflow=pr-validation.yml
```

#### 2. Permission Issues
```yaml
# Ensure proper permissions in workflows
permissions:
  contents: read
  pull-requests: write
  issues: write
```

#### 3. Configuration Conflicts
```bash
# Validate configuration
yamllint .github/workflows/pr-validation.yml

# Test with minimal config
./.github/scripts/deploy-pr-standards.sh owner/repo --dry-run
```

### Debug Mode

```bash
# Enable verbose logging
export DEBUG=1
./.github/scripts/deploy-pr-standards.sh owner/repo

# Check GitHub Actions logs
gh run view --repo owner/repo
```

---

## 🔐 Security Considerations

### Repository Access
- Use fine-grained personal access tokens
- Limit script permissions to necessary repositories
- Regular token rotation

### Workflow Security
- Pin action versions to specific SHAs
- Review third-party actions regularly
- Use repository secrets for sensitive data

### Branch Protection
```bash
# Set up branch protection with PR standards
gh api repos/owner/repo/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":["PR Validation"]}'
```

---

## 📈 Best Practices

### 1. Incremental Rollout
- Start with low-risk repositories
- Gather feedback from developers
- Iterate on configuration

### 2. Team Training
- Document workflow changes
- Provide training sessions
- Create troubleshooting guides

### 3. Continuous Improvement
- Monitor workflow performance
- Collect user feedback
- Regular system updates

### 4. Documentation Maintenance
- Keep documentation current
- Include real examples
- Maintain changelog

---

## 🔮 Advanced Features

### Custom Workflow Extensions

```yaml
# Add project-specific steps
jobs:
  validate-pr:
    uses: ./.github/workflows-reusable/pr-validation.yml
    with:
      # Standard configuration
      enable_auto_labeling: true
      
  custom-validation:
    runs-on: ubuntu-latest
    needs: validate-pr
    steps:
      - name: Project-specific validation
        run: |
          # Custom validation logic
```

### Integration with External Tools

```yaml
# Integrate with project management tools
- name: Update Jira Ticket
  if: steps.pr-info.outputs.pr_merged == 'true'
  run: |
    # Update Jira ticket status
    
- name: Notify Slack
  run: |
    # Send Slack notification
```

---

## 📚 References

- [GitHub Actions Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [YAML Syntax Reference](https://yaml.org/spec/1.2.2/)

---

## 🤝 Contributing

1. **Test changes** in arrgh-hub first
2. **Update documentation** as needed
3. **Follow PR standards** (dogfooding!)
4. **Test deployment script** with `--dry-run`
5. **Update version numbers** appropriately

---

*This deployment guide is part of the centralized PR Standards System. For questions or issues, create an issue in the arrgh-hub repository.* 