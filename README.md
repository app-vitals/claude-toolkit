# Claude Code Toolkit

A collection of tools and commands that extend Claude Code functionality.

## What's Inside

### 🧭 [Compass](./compass)

An execution efficiency assistant focused on helping you answer "what should I work on next?"

Compass provides:
- Context management system that emerges organically from conversations
- Smart prioritization and execution guidance
- `/distill` command to capture conversation insights into structured context
- Session archiving for long-term context preservation

[Learn more →](./compass/README.md)

### ⚡ [Commands](./commands)

Standalone slash commands for Claude Code.

Available commands:
- `/review-pr` - Comprehensive GitHub PR review with local checkout

[Learn more →](./commands/README.md)

## Installation

Each tool has its own installation:

```bash
# Install Compass
cd compass
./install.sh

# Install Commands
cd commands
./install.sh
```

## Requirements

- [Claude Code](https://www.anthropic.com/claude/download) installed
- For PR review: [GitHub CLI (`gh`)](https://cli.github.com/)

## Contributing

To add new tools:
1. Create a new directory for the tool
2. Include install/uninstall scripts
3. Add documentation

To add new commands:
1. Create a `.md` file in `commands/`
2. Run `commands/install.sh`

## License

[Add your license here]
