# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This repository contains tools and extensions for Claude Code:

### compass/
An execution efficiency assistant that extends Claude Code with context management and "what's next" prioritization.

**Key concepts:**
- **Context system**: Uses markdown files in `context/` directories (project-scoped)
- **Distillation workflow**: Converts conversation history to structured context files via `/distill` command
- **On-demand loading**: Claude reads `context/index.md` then loads specific files as needed
- **Temporal tracking**: Goals include start dates, deadlines, and progress percentages

**Files:**
- `bin/compass` - Main CLI wrapper that starts Claude Code with Compass output style
- `templates/output-style.md` - Custom output style defining Compass behavior
- `templates/distill.md` - Slash command for interactive context distillation
- `install.sh` - Installs Compass configuration to `~/.claude/`
- `uninstall.sh` - Removes Compass configuration

**Path resolution:** The `compass` script uses dynamic path resolution (lines 16-22) to work both when symlinked and run directly. SCRIPT_DIR is calculated relative to the actual script location.

### commands/
Standalone slash commands that add functionality to Claude Code.

**Current commands:**
- `/review-pr` - Reviews GitHub PRs using `gh` CLI, saves output to `PR_REVIEW_{number}.md`

**Extension pattern:**
- Commands are `.md` files with frontmatter (`description:`) and prompt text
- Use `$ARGUMENTS` placeholder for user input
- Install scripts copy `.md` files to `~/.claude/commands/`

## Installation Scripts

Both `compass/` and `commands/` use similar install/uninstall patterns:

**Installation:**
- Check for Claude Code availability
- Create `~/.claude/` subdirectories as needed
- Copy template files to appropriate locations
- For Compass: creates symlink in `~/.local/bin/compass`

**Uninstallation:**
- Prompts for confirmation
- Removes configuration files from `~/.claude/`
- For Compass: removes symlink from `~/.local/bin/compass`

**Important:** `compass/install.sh` uses symlink to `~/.local/bin/compass` (not `/usr/local/bin`)

## Development Workflow

When modifying Compass:
1. Edit files in `compass/` directory
2. Test by running `compass/install.sh` to update `~/.claude/` configuration
3. Test in a sample project directory

When adding new commands:
1. Create `.md` file in `commands/` directory with proper frontmatter
2. Run `commands/install.sh` to install
3. Test with `/command-name` in Claude Code

## Key Architecture Details

**Compass context system:**
- Context emerges organically (no predefined structure required)
- Common patterns: `goals.md`, `business.md`, `strategy.md`, `decisions.md`
- Session archives saved to `context-archive/YYYY-MM-DD-topic.md`
- Distillation uses Read/Edit/Write tools for interactive updates
- User confirms each file change

**Dynamic date injection:**
The `compass` script injects today's date into the output style template (lines 92-96) by replacing `{DATE}` placeholder. This enables temporal awareness for goal tracking.

## Testing

To test the full workflow:
```bash
# Install Compass
cd compass && ./install.sh

# Create test project
mkdir -p /tmp/test-compass && cd /tmp/test-compass

# Start Compass
compass

# Test distillation workflow
# 1. Have a conversation about goals/decisions
# 2. Run /distill
# 3. Verify context/ files are created
# 4. Run /clear
# 5. Start new session and verify context loads
```
