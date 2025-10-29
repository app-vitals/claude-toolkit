---
description: Update review for a PR with latest changes
---

# Pull Request Review Update

Update the review for pull request: $ARGUMENTS

## Context

You previously reviewed this PR in this conversation. Reference that review to provide an incremental update focusing on what has changed.

## Process

1. **Fetch latest PR information** using `gh` CLI:
   - Get current PR details and metadata
   - View the latest diff and changed files
   - Extract the PR number from the URL or arguments
   - Check GitHub Actions status for latest run
   - Review any new comments and discussions since the original review

2. **Identify what changed**:
   - Compare the current state with your previous review
   - Look for new commits added since the original review
   - Use `gh pr view {number} --json commits` to see commit history
   - Check out the branch with `gh pr checkout` to examine the latest code

3. **Primary focus - Verify comment resolution**:
   - Go through EACH issue, concern, and suggestion from your original review
   - Check if it has been addressed in the updated code
   - Mark each item as:
     - ✅ **Addressed** - Fixed/implemented as suggested
     - ⚠️ **Partially addressed** - Some progress but incomplete
     - ❌ **Not addressed** - Still needs attention
   - Provide specific evidence (file/line references) for your assessment

4. **Secondary focus - Review new additions**:
   - Identify any new features, functions, or code blocks added since the original review
   - These may be addressing feedback OR new work added to the PR
   - Provide full review of new additions as if reviewing fresh code:
     - Assess code quality and best practices
     - Identify potential issues or bugs
     - Check for test coverage of new code
     - Note any security or performance concerns

5. **Save the updated review**:
   - Write the update to `PR_REVIEW_{number}_UPDATE.md` (e.g., `PR_REVIEW_458_UPDATE.md`)
   - Use markdown formatting with clear sections:
     - **Comment Resolution Status** (checklist of original feedback)
     - **New Code Review** (review of additions since original)
     - **Overall Assessment** (ready to merge? what's blocking?)
     - **GitHub Actions Status** (current CI/CD state)

Use the `gh` command-line tool throughout for GitHub API interactions.
