---
description: Check PR status, list comments, and create plan to address feedback
---

Check the status of the current branch's PR for comments and feedback, then create an action plan.

## Your task

1. **Identify Current PR**
   - Use `gh pr view` to get the current branch's PR details
   - If no PR exists for current branch, inform user and exit
   - Display basic PR information (title, status, URL)

2. **Fetch PR Comments**
   - Use `gh api repos/:owner/:repo/pulls/{pr_number}/comments` to get review comments
   - Use `gh api repos/:owner/:repo/issues/{pr_number}/comments` to get general comments
   - Parse and organize comments by:
     - Author
     - Comment type (review comment vs general comment)
     - File/line location (for review comments)
     - Timestamp

3. **Analyze Comments**
   - Categorize feedback types:
     - **Code changes requested**: Specific code modifications needed
     - **Questions**: Clarification requests from reviewers
     - **Suggestions**: Optional improvements or alternatives
     - **Blockers**: Issues that must be resolved before merge
     - **Praise/Acknowledgments**: Positive feedback (note but don't require action)

4. **Create Action Plan**
   - For each actionable comment, create a specific task:
     - File location (if applicable)
     - Required change description
     - Estimated complexity (simple/moderate/complex)
     - Dependencies between tasks

5. **Present Summary**
   Format output as:
   ```
   ======================================
   PR REVIEW STATUS
   ======================================
   
   PR: #{number} - {title}
   URL: {pr_url}
   Status: {status}
   
   COMMENTS SUMMARY:
   - {X} review comments
   - {X} general comments
   - {X} actionable items
   
   ACTIONABLE FEEDBACK:
   
   [For each actionable comment:]
   📍 {file}:{line} (Author: {author})
   {comment_text}
   
   ACTION PLAN:
   
   [Organized list of specific tasks:]
   1. {task_description} - {complexity}
      Location: {file}:{line}
      
   2. {task_description} - {complexity}
      Location: {file}:{line}
   
   QUESTIONS FOR CLARIFICATION:
   [Any unclear feedback that needs discussion]
   
   ======================================
   ```

6. **Ask for Approval**
   - Present the action plan to the user
   - Ask: "Should I proceed with implementing this plan to address the PR feedback?"
   - Wait for user confirmation before making any code changes
   - If user approves, offer to implement changes systematically

## Error Handling

- **No PR found**: "No open PR found for current branch. Create a PR first or switch to a branch with an open PR."
- **API errors**: Handle GitHub API rate limits and authentication issues
- **Empty comments**: "No comments found on this PR. PR is ready for review or merge."
- **Parsing errors**: Gracefully handle malformed comment data

## Example Usage

```bash
# User runs the command
/gh-pr-review

# Output shows PR status, comments, and action plan
# Claude asks: "Should I proceed with implementing this plan?"
# User responds with confirmation to proceed or requests modifications
```

## Notes

- This command only analyzes and plans - it doesn't make changes automatically
- Requires GitHub CLI (gh) authentication
- Works with the current branch's associated PR
- Provides clear separation between analysis and implementation phases