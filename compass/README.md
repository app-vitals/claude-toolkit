# Compass

> **Execution efficiency assistant for Claude Code**

Compass helps you answer "what should I work on next?" through context-aware AI guidance and intelligent prioritization.

## What is Compass?

Compass is a lightweight configuration layer for [Claude Code](https://www.anthropic.com/claude/download) that adds:

- **Execution efficiency focus** - Optimized for "what's next" prioritization
- **Organic context management** - Context emerges naturally through `/distill` command
- **On-demand context loading** - Scales to large context libraries
- **Project-scoped context** - Different context per project automatically

## Installation

### Homebrew (Coming Soon)

```bash
brew install yourusername/tap/compass
```

### Manual Installation

```bash
git clone https://github.com/yourusername/compass.git
cd compass
./install.sh
```

### Requirements

- [Claude Code](https://www.anthropic.com/claude/download)
- macOS or Linux
- Bash

## Quick Start

```bash
# In any project directory
cd your-project
compass

# Have a conversation
> I need to launch our beta by end of month. We have 3 customers lined up
> and need to finish the onboarding flow and fix 2 critical bugs.
> what should I work on next?

# Distill conversation to context
> /distill
> /clear

# Next time you start
compass
> what should I work on next?
# Claude loads context and makes informed recommendations
```

## How It Works

### 1. Just Start

```bash
cd your-project
compass
```

No setup needed. Start having conversations about your work.

### 2. Distill to Context

After a productive conversation:

```bash
> /distill
```

Claude will:
- Review the entire conversation
- Create `context/` directory if it doesn't exist
- Create/update context files based on what you discussed
- Create `context/index.md` to describe the files
- Archive the session to `context-archive/`

You confirm each change. Claude decides what files make sense based on your conversation.

### 3. Clear for Fresh Start

```bash
> /clear
```

Conversation history cleared, context preserved.

### 4. Next Session Uses Context

```bash
compass
> what should I work on next?
```

Claude checks for context, loads relevant files, provides informed recommendations.

## Context Structure

Context emerges organically. Common patterns:

```
your-project/
├── context/
│   ├── index.md       # Created by Claude (describes other files)
│   ├── goals.md       # If you discussed goals/deadlines
│   ├── business.md    # If you discussed clients/team/revenue
│   ├── strategy.md    # If you discussed strategy/positioning
│   └── decisions.md   # If you made important decisions
└── context-archive/
    └── 2025-10-24-beta-launch-planning.md
```

**No required structure.** Files are created based on what you actually discuss.

### Example: goals.md

```markdown
## Immediate Goals

- [ ] Launch beta to 10 customers
  - Started: 2025-10-01
  - Deadline: 2025-10-31
  - Progress: 3 customers lined up, onboarding flow 60% done
  - Blockers: 2 critical bugs (#127, #134)
  - Next: Fix auth bug #127 (blocks deployment)
```

Claude creates structure that makes sense for your context.

## Multiple Projects

Each project directory has its own context:

```bash
cd ~/src/my-startup
compass
> what should I work on next?
# Uses my-startup context

cd ~/src/client-project
compass
> what should I work on next?
# Uses client-project context
```

Context is automatically scoped to the current directory.

## The Distillation Workflow

**Why distillation?**

Conversations accumulate message history → expensive token costs → context gets lost

**Distillation solves this:**

1. **Review** - Claude reviews full conversation for insights
2. **Structure** - Organizes information into context files
3. **Preserve** - Maintains narrative and strategic thinking (not just facts)
4. **Archive** - Complete session saved for reference
5. **Reset** - Clear for fresh start with context preserved

**Result:** 3-4x token reduction while preserving strategic thinking.

### Example Flow

```
Session 1:
> We're pivoting to enterprise market...
[... 30 message conversation ...]
> /distill

Claude creates:
- context/index.md
- context/strategy.md (pivot decision)
- context/goals.md (new revenue targets)
- context-archive/2025-10-24-enterprise-pivot.md
> /clear

Session 2:
> what should I work on next?
[Claude reads context/goals.md]
[Claude reads context/strategy.md]

Compass: Based on your enterprise pivot (from strategy.md),
you need SSO and RBAC features (from goals.md). With your
enterprise demo in 2 weeks, I recommend starting with SSO...
```

## Commands

```bash
compass              # Start Compass
compass install      # Install Compass configuration
compass version      # Show version
compass help         # Show help
```

## CLI vs Claude Code

| Aspect | Claude Code | Compass |
|--------|-------------|---------|
| Focus | Software engineering | Execution efficiency |
| Context | Static CLAUDE.md | Organic distillation |
| Structure | Predefined | Emerges naturally |
| Prioritization | General | "What's next" optimized |

## What Makes Compass Different

### vs. Custom Agents

- **No code to maintain** - Just configuration files
- **Leverage Claude Code** - Battle-tested tools and CLI
- **Automatic updates** - Benefit from Claude Code improvements

### vs. Manual Context Management

- **Interactive distillation** - Claude structures context for you
- **On-demand loading** - Scalable to large context
- **Temporal tracking** - Built-in goal tracking with dates/progress

### Key Innovation

**On-demand context loading** - Instead of injecting all context upfront, Claude checks what exists and loads files as needed. Scales infinitely.

**Organic structure** - No prescribed templates. Context adapts to each user's natural organization style.

## Advanced

### Version Control

Context files are markdown:

```bash
git add context/
git commit -m "Update goals after planning session"
```

### MCP Integration

Compass inherits Claude Code's MCP support:

```json
// .mcp.json
{
  "toggl": {
    "command": "mcp-toggl-server",
    "env": {"TOGGL_API_KEY": "your_key"}
  }
}
```

Claude can pull external data for richer recommendations.

### Manual Context Editing

Edit context files directly anytime:

```bash
vim context/goals.md
```

Claude uses updated context in next session.

## Troubleshooting

**Claude Code not found:**
```bash
# Install from https://www.anthropic.com/claude/download
```

**Context not loading:**
```bash
# Check context exists
ls context/

# If empty, run /distill after a conversation
```

**Reinstall Compass:**
```bash
compass install
```

## Development

```bash
git clone https://github.com/yourusername/compass.git
cd compass
./install.sh

# Test
cd /tmp/test-project
compass
```

## Contributing

Contributions welcome! See `CONTRIBUTING.md`.

## License

MIT License - see `LICENSE` file

## Links

- [Vision](./vision.md) - Full project vision
- [Plan](./plan.md) - Implementation roadmap
- [Claude Code](https://www.anthropic.com/claude/download)
- [GitHub](https://github.com/yourusername/compass)

---

**Built with Claude Code** | [Report Issues](https://github.com/yourusername/compass/issues)
