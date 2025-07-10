---
description: Fetch and summarize web resources into markdown files
---

Fetch and summarize the web resource from: $ARGUMENTS

Create a markdown file with a descriptive filename based on the content. Follow these steps:

1. **Parse Arguments**
   - Extract the URL from $ARGUMENTS (required first argument)
   - Extract optional filename if provided (second argument)

2. **Fetch Web Content**
   - Use the WebFetch tool to retrieve content from the provided URL
   - Request a comprehensive summary focusing on:
     - Main topic and purpose
     - Key facts and information
     - Important recommendations or conclusions
     - Technical details if relevant

3. **Generate Filename**
   - If filename not provided, create one based on:
     - Page title or main topic
     - Use kebab-case format (e.g., "web-security-best-practices.md")
     - Keep it concise but descriptive
   - If filename is provided, use it with .md extension

4. **Create Summary File**
   Use this exact format:

```markdown
---
RESOURCE
[Insert the full URL here]

UPDATE HISTORY:
| Date | Changes |
|------|---------|
| [Today's date in YYYY-MM-DD format] | Initial creation |

SUMMARY:
[Create a comprehensive bulleted list of key facts and recommendations, such as:]
- [Main purpose or topic of the resource]
- [Key finding or recommendation #1]
- [Key finding or recommendation #2]
- [Important technical details]
- [Best practices mentioned]
- [Any warnings or caveats]
- [Actionable takeaways]
---
```

5. **File Creation**
   - Save the file in the current working directory
   - Inform the user of the created filename
   - If file already exists, ask for confirmation before overwriting

## Error Handling
- If URL is invalid or unreachable, inform the user
- If WebFetch fails, provide helpful error message
- If no URL provided, show usage example

## Example Output
User: `ingest-web https://example.com/security-guide`

Creates: `security-guide.md` with formatted summary content