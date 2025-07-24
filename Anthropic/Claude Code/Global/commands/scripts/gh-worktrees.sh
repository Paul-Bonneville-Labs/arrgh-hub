#!/bin/bash

# Git Worktree Manager
# Manages git worktrees in a .worktrees folder

set -e

# Colors for output (only if terminal supports it)
if [[ -t 1 ]] && [[ "${TERM-}" != "dumb" ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

# Function to print colored output
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_info() {
    echo -e "${BLUE}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}$1${NC}"
}

# Function to find git root directory
find_git_root() {
    local current_dir="$(pwd)"
    while [[ "$current_dir" != "/" ]]; do
        if [[ -d "$current_dir/.git" ]]; then
            echo "$current_dir"
            return 0
        fi
        current_dir="$(dirname "$current_dir")"
    done
    return 1
}

# Function to validate folder name
validate_folder_name() {
    local name="$1"
    
    # Check if empty
    if [[ -z "$name" ]]; then
        echo "Name cannot be empty"
        return 1
    fi
    
    # Check for invalid characters (spaces, slashes, special chars)
    if [[ "$name" =~ [[:space:]/\\:*?\"\<\>|] ]]; then
        echo "Name cannot contain spaces, slashes, or special characters (:*?\"<>|\\)"
        return 1
    fi
    
    # Check if it starts with a dot or dash
    if [[ "$name" =~ ^[.-] ]]; then
        echo "Name cannot start with a dot or dash"
        return 1
    fi
    
    # Check length (reasonable limit)
    if [[ ${#name} -gt 50 ]]; then
        echo "Name is too long (max 50 characters)"
        return 1
    fi
    
    return 0
}

# Function to list existing worktrees
list_worktrees() {
    local git_root="$1"
    local worktrees_dir="$git_root/.worktrees"
    
    if [[ ! -d "$worktrees_dir" ]]; then
        return 1
    fi
    
    # List directories in .worktrees (excluding hidden files)
    find "$worktrees_dir" -maxdepth 1 -type d -not -path "$worktrees_dir" -exec basename {} \; 2>/dev/null | sort
}

# Function to create a new worktree
create_worktree() {
    local git_root="$1"
    local worktrees_dir="$git_root/.worktrees"
    
    # Create .worktrees directory if it doesn't exist
    mkdir -p "$worktrees_dir"
    
    while true; do
        echo
        read -p "Enter name for new worktree: " worktree_name
        
        if validate_folder_name "$worktree_name"; then
            local worktree_path="$worktrees_dir/$worktree_name"
            
            # Check if worktree already exists
            if [[ -d "$worktree_path" ]]; then
                print_error "Worktree '$worktree_name' already exists"
                continue
            fi
            
            # Create the worktree
            print_info "Creating worktree '$worktree_name'..."
            if git worktree add "$worktree_path" 2>/dev/null; then
                print_success "Worktree '$worktree_name' created successfully"
                print_info "Changing to worktree directory..."
                cd "$worktree_path"
                return 0
            else
                print_error "Failed to create worktree '$worktree_name'"
                continue
            fi
        else
            print_error "$(validate_folder_name "$worktree_name")"
        fi
    done
}

# Function to open a worktree
open_worktree() {
    local git_root="$1"
    local worktree_name="$2"
    local worktree_path="$git_root/.worktrees/$worktree_name"
    
    if [[ ! -d "$worktree_path" ]]; then
        print_error "Worktree '$worktree_name' does not exist"
        return 1
    fi
    
    print_info "Opening worktree '$worktree_name'..."
    cd "$worktree_path"
    
    # Check if claude is available
    # Note: This refers to the Claude Code CLI application (https://github.com/anthropics/claude-code)
    if command -v claude &> /dev/null; then
        print_info "Launching Claude Code..."
        exec claude
    else
        print_warning "Claude Code not found in PATH. You are now in the worktree directory."
    fi
}

# Function to finish (remove) a worktree
finish_worktree() {
    local git_root="$1"
    local worktree_name="$2"
    local worktree_path="$git_root/.worktrees/$worktree_name"
    
    if [[ ! -d "$worktree_path" ]]; then
        print_error "Worktree '$worktree_name' does not exist"
        return 1
    fi
    
    echo
    print_warning "This will remove the worktree '$worktree_name' and all its changes."
    read -p "Are you sure? (y/N): " confirm
    
    case "$confirm" in
        [yY]|[yY][eE][sS])
            print_info "Removing worktree '$worktree_name'..."
            if git worktree remove "$worktree_path" --force 2>/dev/null; then
                print_success "Worktree '$worktree_name' removed successfully"
            else
                print_error "Failed to remove worktree '$worktree_name'"
                return 1
            fi
            ;;
        *)
            print_info "Operation cancelled"
            ;;
    esac
}

# Function to handle worktree action selection
handle_worktree_action() {
    local git_root="$1"
    local worktree_name="$2"
    
    echo
    print_info "Selected worktree: $worktree_name"
    echo "1) Open (cd + claude code)"
    echo "2) Finish (remove worktree)"
    echo "3) Back to main menu"
    echo
    read -p "Choose an action [1-3]: " action_choice
    
    case "$action_choice" in
        1)
            open_worktree "$git_root" "$worktree_name"
            exit 0
            ;;
        2)
            finish_worktree "$git_root" "$worktree_name"
            ;;
        3)
            return 0
            ;;
        *)
            print_error "Invalid choice"
            ;;
    esac
}

# Main function
main() {
    # Check if we're in a git repository
    if ! git_root=$(find_git_root); then
        print_error "Not in a git repository"
        exit 1
    fi
    
    print_info "Git Worktree Manager"
    print_info "Repository: $git_root"
    
    while true; do
        echo
        echo "===================="
        
        # List existing worktrees
        worktrees=($(list_worktrees "$git_root"))
        
        if [[ ${#worktrees[@]} -eq 0 ]]; then
            echo "No worktrees found in .worktrees/"
        else
            echo "Existing worktrees:"
            for i in "${!worktrees[@]}"; do
                echo "$((i+1))) ${worktrees[i]}"
            done
            echo
        fi
        
        # Show options
        local create_option=$((${#worktrees[@]} + 1))
        local exit_option=$((${#worktrees[@]} + 2))
        
        echo "$create_option) Create new worktree"
        echo "$exit_option) Exit"
        echo
        read -p "Choose an option: " choice
        
        # Handle choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [[ $choice -ge 1 ]] && [[ $choice -le ${#worktrees[@]} ]]; then
            # Selected existing worktree
            selected_worktree="${worktrees[$((choice-1))]}"
            handle_worktree_action "$git_root" "$selected_worktree"
        elif [[ "$choice" == "$create_option" ]]; then
            # Create new worktree
            if create_worktree "$git_root"; then
                exit 0
            fi
        elif [[ "$choice" == "$exit_option" ]]; then
            # Exit
            print_info "Goodbye!"
            exit 0
        else
            print_error "Invalid choice"
        fi
    done
}

# Run main function
main "$@"