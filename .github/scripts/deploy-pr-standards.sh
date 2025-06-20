#!/bin/bash

# Deploy PR Standards System to Target Repository
# Usage: ./deploy-pr-standards.sh <target-repo> [options]

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Default configuration
SOURCE_REPO="pbonneville/ai-common"
BRANCH_NAME="deploy/pr-standards-$(date +%Y%m%d%H%M%S)"
DRY_RUN=false
FORCE=false
CUSTOMIZE=false

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}[DEPLOY]${NC} $1"
}

# Function to show usage
show_usage() {
    cat << EOF
Usage: $0 <target-repo> [options]

Deploy PR Standards System to a target repository.

Arguments:
  target-repo     Target repository in format 'owner/repo'

Options:
  --branch-name   Custom branch name (default: deploy/pr-standards-TIMESTAMP)
  --dry-run       Show what would be done without making changes
  --force         Overwrite existing files without prompting
  --customize     Prompt for configuration customization
  --help, -h      Show this help message

Examples:
  $0 pbonneville/arrgh-ios
  $0 pbonneville/arrgh-fastapi --customize
  $0 pbonneville/my-repo --dry-run
  $0 pbonneville/my-repo --branch-name feature/add-pr-standards
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --branch-name)
            BRANCH_NAME="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --customize)
            CUSTOMIZE=true
            shift
            ;;
        --help|-h)
            show_usage
            exit 0
            ;;
        -*)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
        *)
            if [ -z "$TARGET_REPO" ]; then
                TARGET_REPO="$1"
            else
                print_error "Unexpected argument: $1"
                show_usage
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate required arguments
if [ -z "$TARGET_REPO" ]; then
    print_error "Target repository is required"
    show_usage
    exit 1
fi

# Validate target repo format
if [[ ! "$TARGET_REPO" =~ ^[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+$ ]]; then
    print_error "Target repository must be in format 'owner/repo'"
    exit 1
fi

print_header "Deploying PR Standards System to $TARGET_REPO"

# Check if we're in the right directory
if [ ! -f "Anthropic/Claude/Global/PR-STANDARDS.md" ]; then
    print_error "Must be run from the ai-common repository root"
    print_error "PR-STANDARDS.md not found in expected location"
    exit 1
fi

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
    print_error "GitHub CLI (gh) is required but not installed"
    print_error "Install from: https://cli.github.com/"
    exit 1
fi

# Check if we're authenticated with gh
if ! gh auth status &> /dev/null; then
    print_error "Not authenticated with GitHub CLI"
    print_error "Run: gh auth login"
    exit 1
fi

# Verify access to target repository
print_status "Verifying access to target repository..."
if ! gh repo view "$TARGET_REPO" --json name &> /dev/null; then
    print_error "Cannot access repository $TARGET_REPO"
    print_error "Ensure you have access and the repository exists"
    exit 1
fi

# Create temporary directory for operations
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

print_status "Working in temporary directory: $TEMP_DIR"

# Clone target repository
print_status "Cloning target repository..."
if [ "$DRY_RUN" = true ]; then
    print_status "[DRY RUN] Would clone $TARGET_REPO"
else
    cd "$TEMP_DIR"
    gh repo clone "$TARGET_REPO" target-repo
    cd target-repo
    
    # Create new branch
    print_status "Creating branch: $BRANCH_NAME"
    git checkout -b "$BRANCH_NAME"
fi

# Define files to copy
declare -a STANDARD_FILES=(
    "Anthropic/Claude/Global/PR-STANDARDS.md"
    "Anthropic/Claude/Global/CLAUDE-CODE-PR-PROMPT.md"
    "Anthropic/Claude/Global/README-PR-STANDARDS.md"
    "Anthropic/Claude/Global/config/pr-standards.json"
    ".github/pull_request_template.md"
    ".github/pr-automation-config.yml"
    ".github/workflows-reusable/pr-validation.yml"
    ".github/workflows-reusable/pr-approved.yml"
)

declare -a WRAPPER_FILES=(
    ".github/workflows/pr-validation.yml"
    ".github/workflows/pr-approved.yml"
)

# Function to copy files
copy_file() {
    local source_file="$1"
    local target_file="$2"
    local source_path="$OLDPWD/$source_file"
    
    if [ ! -f "$source_path" ]; then
        print_warning "Source file not found: $source_file"
        return 1
    fi
    
    if [ "$DRY_RUN" = true ]; then
        print_status "[DRY RUN] Would copy $source_file to $target_file"
        return 0
    fi
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target_file")"
    
    # Check if file exists and handle overwrite
    if [ -f "$target_file" ] && [ "$FORCE" = false ]; then
        echo -n "File $target_file already exists. Overwrite? (y/N): "
        read -r response
        if [[ ! "$response" =~ ^[Yy] ]]; then
            print_status "Skipping $target_file"
            return 0
        fi
    fi
    
    cp "$source_path" "$target_file"
    print_success "Copied $source_file"
}

# Function to customize configuration
customize_config() {
    if [ "$CUSTOMIZE" = false ] || [ "$DRY_RUN" = true ]; then
        return 0
    fi
    
    print_header "Configuration Customization"
    echo "You can customize the PR standards for this repository."
    echo "Press Enter to keep defaults, or enter new values:"
    echo
    
    # PR Size limits
    echo -n "Small PR max lines (default: 400): "
    read -r small_lines
    small_lines=${small_lines:-400}
    
    echo -n "Small PR max files (default: 10): "
    read -r small_files
    small_files=${small_files:-10}
    
    echo -n "Medium PR max lines (default: 800): "
    read -r medium_lines
    medium_lines=${medium_lines:-800}
    
    echo -n "Medium PR max files (default: 15): "
    read -r medium_files
    medium_files=${medium_files:-15}
    
    # Feature toggles
    echo
    echo "Feature toggles (y/N):"
    
    echo -n "Enable auto-merge for safe PRs? (default: y): "
    read -r auto_merge
    auto_merge=${auto_merge:-y}
    
    echo -n "Enable automatic labeling? (default: y): "
    read -r auto_label
    auto_label=${auto_label:-y}
    
    echo -n "Enable release notes generation? (default: y): "
    read -r release_notes
    release_notes=${release_notes:-y}
    
    # Update configuration files with custom values
    if [ -f ".github/workflows/pr-validation.yml" ]; then
        sed -i "s/small_max_lines: 400/small_max_lines: $small_lines/" ".github/workflows/pr-validation.yml"
        sed -i "s/small_max_files: 10/small_max_files: $small_files/" ".github/workflows/pr-validation.yml"
        sed -i "s/medium_max_lines: 800/medium_max_lines: $medium_lines/" ".github/workflows/pr-validation.yml"
        sed -i "s/medium_max_files: 15/medium_max_files: $medium_files/" ".github/workflows/pr-validation.yml"
        
        if [[ "$auto_label" =~ ^[Nn] ]]; then
            sed -i "s/enable_auto_labeling: true/enable_auto_labeling: false/" ".github/workflows/pr-validation.yml"
        fi
    fi
    
    if [ -f ".github/workflows/pr-approved.yml" ]; then
        if [[ "$auto_merge" =~ ^[Nn] ]]; then
            sed -i "s/enable_auto_merge: true/enable_auto_merge: false/" ".github/workflows/pr-approved.yml"
        fi
        
        if [[ "$release_notes" =~ ^[Nn] ]]; then
            sed -i "s/enable_release_notes: true/enable_release_notes: false/" ".github/workflows/pr-approved.yml"
        fi
    fi
    
    print_success "Configuration customized!"
}

# Copy standard files
print_status "Copying standard files..."
for file in "${STANDARD_FILES[@]}"; do
    copy_file "$file" "$file"
done

# Copy wrapper workflows
print_status "Copying workflow files..."
for file in "${WRAPPER_FILES[@]}"; do
    copy_file "$file" "$file"
done

# Customize configuration
customize_config

# Show what was done
if [ "$DRY_RUN" = true ]; then
    print_header "Dry Run Summary"
    print_status "Files that would be deployed:"
    for file in "${STANDARD_FILES[@]}" "${WRAPPER_FILES[@]}"; do
        echo "  - $file"
    done
    print_status "Branch that would be created: $BRANCH_NAME"
    print_status "Run without --dry-run to actually deploy"
    exit 0
fi

# Check if any files were actually added
if [ -n "$(git status --porcelain)" ]; then
    print_status "Committing changes..."
    git add .
    
    # Create comprehensive commit message
    COMMIT_MSG="feat: add PR standards system with automated workflows

- Add comprehensive PR validation and approval workflows
- Include industry-standard PR templates and documentation
- Configure automated labeling, size checking, and release notes
- Add reusable workflow components for easy maintenance

Files added:
$(git status --porcelain | grep '^A' | sed 's/^A  /- /' || echo '- Configuration updates only')

Source: $SOURCE_REPO
Branch: $BRANCH_NAME
Deployed: $(date)"
    
    git commit -m "$COMMIT_MSG"
    
    # Push branch
    print_status "Pushing branch to remote..."
    git push -u origin "$BRANCH_NAME"
    
    # Create Pull Request
    print_status "Creating pull request..."
    
    PR_BODY="## Summary

This PR deploys the comprehensive PR standards system from \`$SOURCE_REPO\` to standardize and automate our pull request workflow.

## What's Included

### 📋 Documentation & Standards
- **PR Standards Documentation** - Complete guidelines and best practices
- **Claude Code Integration** - AI assistant prompt optimization
- **GitHub PR Template** - Consistent PR descriptions

### 🤖 Automated Workflows
- **PR Validation** - Title format, size limits, description validation
- **Auto-labeling** - Automatic labels based on PR type
- **Security Scanning** - Detect security-related changes
- **Metrics Collection** - PR size and quality metrics

### 🔄 Post-merge Automation
- **Auto-merge** - Safe PRs (docs, tests, style) merge automatically
- **Release Notes** - Automatic generation for features and fixes
- **Branch Cleanup** - Auto-delete feature branches
- **Contributor Thanks** - Personalized thank you messages

## Configuration

The system has been configured with the following settings:
- **Small PRs**: ≤400 lines, ≤10 files
- **Medium PRs**: 400-800 lines, 10-15 files
- **Large PRs**: 800+ lines, 15+ files (requires justification)

## Benefits

✅ **Consistency** - Standardized PR format across all repositories
✅ **Quality** - Automated validation catches issues early
✅ **Efficiency** - Reduced manual review overhead
✅ **Documentation** - Better release notes and change tracking
✅ **Collaboration** - Clear guidelines for contributors

## Testing

The workflows will activate on:
- Pull request creation/updates
- Pull request approvals
- Pull request merges

## Related

- Source Repository: [\`$SOURCE_REPO\`](https://github.com/$SOURCE_REPO)
- Documentation: [\`PR-STANDARDS.md\`](./Anthropic/Claude/Global/PR-STANDARDS.md)
- Configuration: [\`.github/pr-automation-config.yml\`](./.github/pr-automation-config.yml)"

    gh pr create \
        --title "feat: implement automated PR standards system" \
        --body "$PR_BODY" \
        --label "enhancement,automation,ci-cd" \
        --draft
    
    PR_URL=$(gh pr view --json url --jq .url)
    
    print_success "Deployment completed successfully!"
    print_success "Pull Request created: $PR_URL"
    print_status "Review the PR and remove draft status when ready to merge"
    
else
    print_warning "No changes detected - target repository may already have the PR standards system"
fi

print_header "Deployment Summary"
print_success "✅ PR Standards System deployed to $TARGET_REPO"
print_success "✅ Branch: $BRANCH_NAME"
if [ -n "$PR_URL" ]; then
    print_success "✅ Pull Request: $PR_URL"
fi
print_status "📚 Review the documentation in PR-STANDARDS.md"
print_status "⚙️  Customize .github/pr-automation-config.yml if needed"
print_status "🚀 The system will activate after the PR is merged" 