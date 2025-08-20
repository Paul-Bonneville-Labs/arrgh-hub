#!/bin/bash

# Git Lines Per Day Analysis Script
# Analyzes lines of code added per day across GitHub organization repositories

set -e

# Configuration
ORG_NAME="Paul-Bonneville-Labs"

# Get number of days from argument or default to 7
if [ -n "$1" ] && [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -gt 0 ]; then
    DAYS_BACK="$1"
else
    DAYS_BACK=7
fi

echo "=== Git Lines Per Day Analysis ==="
echo "Organization: $ORG_NAME"
echo "Analysis period: Last $DAYS_BACK days"
echo

# Get date range
if [[ "$OSTYPE" == "darwin"* ]]; then
    SINCE_DATE=$(date -v-${DAYS_BACK}d +%Y-%m-%dT%H:%M:%SZ)
else
    SINCE_DATE=$(date -d "${DAYS_BACK} days ago" +%Y-%m-%dT%H:%M:%SZ)
fi

echo "Getting commits since: $SINCE_DATE"
echo

# Create temporary files
TEMP_DIR=$(mktemp -d)
COMMITS_CSV="$TEMP_DIR/all_commits.csv"
echo "repo,date,additions,message" > "$COMMITS_CSV"

# Get list of repositories
echo "📋 Getting repository list..."
REPOS=$(gh api "orgs/$ORG_NAME/repos" --paginate --jq '.[].name' 2>/dev/null | tr '\n' ' ')

if [ -z "$REPOS" ]; then
    echo "❌ No repositories found or no access to organization: $ORG_NAME"
    exit 1
fi

echo "Found repositories: $REPOS"
echo

# Process each repository
for repo in $REPOS; do
    echo "🔍 Processing repository: $repo"
    
    # Test access first
    if ! gh api "repos/$ORG_NAME/$repo" --jq '.name' >/dev/null 2>&1; then
        echo "  ✗ No access to $repo"
        continue
    fi
    
    echo "  ✓ Access granted to $repo"
    
    # Get commits since the specified date
    gh api "repos/$ORG_NAME/$repo/commits" --paginate 2>/dev/null | \
    jq ".[] | select(.commit.author.date >= \"$SINCE_DATE\")" 2>/dev/null | \
    jq -r '.sha + " " + .commit.author.date[0:10] + " " + (.commit.message | split("\n")[0] | gsub(","; ";"))' 2>/dev/null | \
    while read -r sha date message; do
        if [ -n "$sha" ] && [ "$sha" != "null" ]; then
            # Get individual commit stats
            stats=$(gh api "repos/$ORG_NAME/$repo/commits/$sha" --jq '.stats.additions // 0' 2>/dev/null)
            if [ -n "$stats" ] && [ "$stats" != "null" ] && [ "$stats" != "0" ]; then
                echo "$repo,$date,$stats,$message" >> "$COMMITS_CSV"
                echo "    $date: +$stats lines"
            fi
        fi
    done
    echo
done

# Process results with Python
python3 << EOF
days_back = $DAYS_BACK
import csv
from collections import defaultdict
import os

# Data structure: {date: {repo: total_lines}}
daily_repo_stats = defaultdict(lambda: defaultdict(int))
daily_totals = defaultdict(int)

# Read the CSV data
csv_file = '$COMMITS_CSV'
if not os.path.exists(csv_file):
    print("❌ No data file found")
    exit(1)

try:
    with open(csv_file, 'r') as f:
        reader = csv.DictReader(f)
        has_data = False
        for row in reader:
            if row['repo'] and row['date'] and row['additions']:
                repo = row['repo']
                date = row['date']
                additions = int(row['additions'])
                
                daily_repo_stats[date][repo] += additions
                daily_totals[date] += additions
                has_data = True

    if not has_data:
        print(f"📊 No commits with line additions found in the last {days_back} days.")
        exit(0)

    print('📈 Daily Line Additions Tree View')
    print('=' * 50)
    print()

    # Sort dates chronologically
    for date in sorted(daily_repo_stats.keys()):
        total = daily_totals[date]
        print(f'📅 {date} (+{total:,} lines total)')
        
        # Sort repos by lines added (descending)
        repos_sorted = sorted(daily_repo_stats[date].items(), key=lambda x: x[1], reverse=True)
        
        for i, (repo, lines) in enumerate(repos_sorted):
            if i == len(repos_sorted) - 1:  # Last item
                print(f'    └── {repo}: +{lines:,} lines')
            else:
                print(f'    ├── {repo}: +{lines:,} lines')
        print()

    # Summary
    total_all_days = sum(daily_totals.values())
    print(f'📊 **Total across all days: +{total_all_days:,} lines**')
    print()
    
    # Repo breakdown
    repo_totals = defaultdict(int)
    for date_stats in daily_repo_stats.values():
        for repo, lines in date_stats.items():
            repo_totals[repo] += lines
    
    if repo_totals:
        print('🏆 Repository Totals:')
        for repo, total in sorted(repo_totals.items(), key=lambda x: x[1], reverse=True):
            print(f'  • {repo}: +{total:,} lines')

except Exception as e:
    print(f'❌ Error processing data: {e}')
    print('Debug: CSV file contents:')
    with open(csv_file, 'r') as f:
        content = f.read().strip()
        if content:
            print(content[:500] + ('...' if len(content) > 500 else ''))
        else:
            print('(empty file)')
EOF

# Cleanup
rm -rf "$TEMP_DIR"

echo
echo "=== End Analysis ==="