---
description: Review a GitHub pull request using gh cli
---

# Pull Request Review

Help me review this pull request: $ARGUMENTS

## Process

1. **Fetch PR information** using `gh` CLI:
   - Get PR details, description, and metadata
   - View the diff and changed files
   - Extract the PR number from the URL or arguments

2. **Checkout the branch locally** for deeper context:
   - Use `gh pr checkout` to check out the PR branch
   - Read relevant files to understand the changes in context

3. **Provide comprehensive review**:
   - Summarize what the PR does
   - Assess code quality and best practices
   - Identify potential issues or bugs
   - Suggest improvements
   - Check for test coverage
   - Note any security or performance concerns

4. **Save the review**:
   - Write the complete review to `PR_REVIEW_{number}.md` (e.g., `PR_REVIEW_458.md`)
   - Use markdown formatting with clear sections
   - This allows for discussion and iteration on the review

Use the `gh` command-line tool throughout for GitHub API interactions.
