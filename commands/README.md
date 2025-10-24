# Claude Code Commands

Standalone slash commands for Claude Code that extend its functionality.

## Available Commands

### /review-pr

Review a GitHub pull request with comprehensive analysis.

**Usage:**
```
/review-pr https://github.com/owner/repo/pull/123
```

**What it does:**
- Fetches PR information using `gh` CLI
- Checks out the branch locally for context
- Provides comprehensive code review
- Saves review to `PR_REVIEW_{number}.md` for discussion and iteration

**Requirements:**
- [GitHub CLI (`gh`)](https://cli.github.com/) installed and authenticated

## Installation

Install all commands:

```bash
cd commands
./install.sh
```

This will copy all command files to `~/.claude/commands/`.

## Uninstallation

Remove installed commands:

```bash
cd commands
./uninstall.sh
```

## Creating New Commands

1. Create a new `.md` file in this directory (e.g., `my-command.md`)
2. Add frontmatter with description:
   ```markdown
   ---
   description: Brief description of what this command does
   ---
   ```
3. Write the command prompt using `$ARGUMENTS` for user input
4. Run `./install.sh` to install the new command

The command will be available as `/my-command` in Claude Code.

## Learn More

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Slash Commands Guide](https://docs.claude.com/claude-code/slash-commands)
