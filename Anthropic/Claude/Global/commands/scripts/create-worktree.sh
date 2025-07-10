#!/bin/bash

# Create Worktree Script
# Usage: ./create-worktree.sh <worktree-name>
# Creates a new git worktree in a sibling directory with consistent naming

set -e  # Exit on any error

# Function to display usage
usage() {
    echo "Usage: $0 <worktree-name>"
    echo "Example: $0 new-feature"
    echo ""
    echo "Creates a new git worktree in a sibling directory:"
    echo "  - New branch: feature/<worktree-name>"
    echo "  - New directory: <current-project>-<worktree-name>"
    exit 1
}

# Function to validate worktree name
validate_name() {
    local name="$1"
    if [[ ! "$name" =~ ^[a-zA-Z0-9-]+$ ]]; then
        echo "Error: Worktree name must contain only alphanumeric characters and hyphens"
        echo "Invalid name: $name"
        exit 1
    fi
}

# Function to check if directory exists
check_directory_exists() {
    local dir_path="$1"
    if [[ -d "$dir_path" ]]; then
        echo "Error: Directory already exists: $dir_path"
        exit 1
    fi
}

# Function to check if branch exists
check_branch_exists() {
    local branch_name="$1"
    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
        echo "Error: Branch already exists: $branch_name"
        echo "Use 'git branch -d $branch_name' to delete it first, or choose a different name"
        exit 1
    fi
}

# Main function
main() {
    # Check if argument is provided or if help is requested
    if [[ $# -eq 0 ]] || [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
        usage
    fi

    local worktree_name="$1"
    
    # Validate the worktree name
    validate_name "$worktree_name"
    
    # Get current directory and project info
    local current_dir=$(pwd)
    local project_name=$(basename "$current_dir")
    local parent_dir=$(dirname "$current_dir")
    
    # Generate paths and names
    local new_worktree_dir="$parent_dir/$project_name-$worktree_name"
    local branch_name="feature/$worktree_name"
    
    echo "Creating worktree:"
    echo "  Current project: $project_name"
    echo "  New worktree: $new_worktree_dir"
    echo "  New branch: $branch_name"
    echo ""
    
    # Check for conflicts
    check_directory_exists "$new_worktree_dir"
    check_branch_exists "$branch_name"
    
    # Create the worktree
    echo "Creating git worktree..."
    git worktree add "$new_worktree_dir" -b "$branch_name"
    
    # Success message
    echo ""
    echo "✅ Worktree created successfully!"
    echo "  Directory: $new_worktree_dir"
    echo "  Branch: $branch_name"
    echo ""
    echo "To switch to the new worktree:"
    echo "  cd $new_worktree_dir"
    echo ""
    echo "To remove the worktree later:"
    echo "  git worktree remove $new_worktree_dir"
}

# Run main function with all arguments
main "$@"