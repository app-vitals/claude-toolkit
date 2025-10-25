# Vision: Execution Efficiency Assistant

## Overview

Transform Compass from a general-purpose CLI assistant into a specialized **Execution Efficiency Assistant** that helps optimize daily task execution and long-term goal achievement.

## Core Philosophy

- **Simple and lightweight**: Maintain Unix philosophy principles
- **Context-aware**: Build rich, human-readable context from conversations and integrations
- **Context as narrative**: Structured markdown that preserves relationships and strategic thinking
- **Token efficient**: Distill conversations to context, keep sessions fresh
- **Actionable**: Focus on helping determine *what's next* rather than just completing tasks
- **Iterative**: Start simple, add complexity incrementally

## Two Primary Use Cases

### 1. Daily Execution Efficiency

Help determine the highest-priority next action based on comprehensive context:

**Context Sources:**
- Calendar events and time availability (via MCP)
- Linear issues and project boards (via MCP - integrated)
- Trello boards and cards (via MCP - integrated)
- Toggl time tracking entries (via MCP - integrated)
- Recent work context (files edited, commits, PRs)
- Project timelines and deadlines
- Communication context (Slack threads, email priorities)

**Core Capabilities:**
- Ask: "What should I work on next?"
- Get intelligent prioritization considering:
  - Upcoming meetings and time blocks
  - Project deadlines and dependencies
  - Current sprint/iteration goals
  - Blocking vs. blocked work
  - Energy levels and task complexity matching
- Receive actionable recommendations with reasoning
- Quick context switching support

**Example Interactions:**
```
User: "What should I work on next?"

Agent: "Based on your context:
- You have 2 hours before your 2pm standup (calendar)
- Your Toggl tracker shows 3.5 hours on the API refactor today
- Linear sprint ends in 2 days with 3 tickets remaining
- Trello card "Deploy v2.0" is marked urgent

Recommendation: Focus on Linear ticket ENG-456 (auth bug - high priority, 90 min est.)

Reasoning:
- You've already invested time in API refactor (Toggl context)
- Sprint deadline is approaching (Linear context)
- Auth bug fits your remaining time block
- Deployment can wait until after sprint closes (Trello context)"
```

### 2. Long-term Execution Efficiency

Help set, track, and make incremental progress toward strategic goals:

**Goal Categories:**
- Content creation and sharing (blog posts, social media, talks)
- Revenue milestones and financial targets
- Company growth metrics (users, team size, market presence)
- Personal development and learning objectives
- Vision and strategy execution

**Core Capabilities:**
- Goal setting and decomposition into milestones
- Progress tracking and visualization
- Proactive nudging: "You haven't shared content in 2 weeks"
- Opportunity identification: "Your recent work on X would make a great blog post"
- Incremental progress suggestions that fit into daily workflow
- Success pattern recognition and reinforcement

**Example Interactions:**
```
User: "Help me make progress on content goals"

Agent: "Your goal: Share 2 technical posts per month
Status: 1/2 for October, 7 days remaining

Recent context suggests an opportunity:
- You just completed the webhook retry system (merged yesterday)
- This solves a common distributed systems problem
- You have 90 minutes free tomorrow morning

Suggestion: Draft a post on 'Building Resilient Webhooks'
- Outline: 30 min
- Draft: 45 min
- Polish: 15 min (can defer)

This leverages fresh work and fits your available time."
```

## Key Design Principles

### 1. Context is King

Rich, human-readable context enables intelligent recommendations:

**Context as Structured Narrative:**
- Context stored as markdown in `context/` directories (visible, editable)
- Preserves relationships between concepts, not just atomic facts
- Hierarchical organization (business.md, strategy.md, goals.md)
- Project-scoped: different context for different projects
- Version-controllable: can commit context to git

**Distillation Workflow:**
- Conversations naturally accumulate in message history
- User triggers `/distill` at natural breakpoints (after decisions, end of session)
- Agent reviews full conversation, updates context files interactively
- Archives complete session for reference
- Clears messages for fresh start
- 3-4x token reduction vs. continuous message growth

**Goals with Temporal Tracking:**
```markdown
- [ ] Launch v2.0 by Q1 2026
  - Started: September 2025
  - Deadline: March 2026
  - Elapsed: 2 months / 6 months (33%)
  - Progress: 4/10 features complete (40%)
  - Remaining: 6 features in 4 months
```

**Context Sources:**
- Manual distillation of conversations (primary)
- MCP integrations (Toggl, Linear, Trello, Calendar)
- File operations and command executions
- Strategic decisions and their reasoning

### 2. Proactive but Not Intrusive

Balance assistance with autonomy:
- Suggest, don't dictate
- Explain reasoning transparently
- Learn from user choices and feedback
- Respect focus time and flow states

### 3. Incremental Progress Over Perfection

Bias toward small, consistent actions:
- Break large goals into tiny next steps
- Celebrate micro-progress
- Find 15-minute opportunities for long-term goals
- Reduce activation energy for important-but-not-urgent work

### 4. Maintain Core Strengths

Keep what works from Claude Code:
- **File operations**: Reading, creating, editing files remains core
- **Command execution**: Still runs commands when needed
- **Interactive CLI**: Familiar interface with enhancements
- **Tool-based architecture**: Extend with new integrations
- **Lightweight**: Fast startup, minimal overhead

## Technical Approach

### Built on Claude Code

Compass is a configuration layer for Claude Code, not a separate CLI:

**What Claude Code Provides:**
- Complete CLI with history, tab completion, and session management
- All file operation tools (Read, Write, Edit, Bash, Grep, Glob, etc.)
- Tool execution with user confirmation
- MCP integration for external services
- Conversation management and persistence

**What Compass Adds:**
- Custom output style for execution efficiency focus
- `/distill` slash command for context management
- Simple CLI wrapper for convenience (`compass` vs `claude-code --output-style compass`)

### Context System

**On-Demand Context Loading:**
- Context index (`context/index.md`) describes available context files
- Claude loads specific context files as needed using Read tool
- No upfront context injection - scales to large context libraries
- Agent decides what context to load based on conversation

**Context Files:**
- `context/business.md` - Clients, team, revenue, operations
- `context/strategy.md` - Strategic positioning and decisions
- `context/goals.md` - Goals with temporal tracking
- `context/decisions.md` - Decision archive with reasoning
- Extensible - add any markdown file to context directory

**Distillation Workflow:**
- `/distill` slash command triggers review of conversation
- Claude uses Read/Edit/Write tools to update context files
- User confirms each change (Claude Code's built-in confirmation)
- Session archived to `context-archive/YYYY-MM-DD-topic.md`
- User runs `/clear` to reset conversation with context preserved

**Project-Scoped:**
- Each project has its own `context/` directory
- Different directory = different context automatically
- Context files are version-controllable with git
- No global context (each project is independent)

### MCP Integration

- Leverage Claude Code's built-in MCP support
- Connect to time tracking (Toggl), task boards (Linear, Trello), calendars
- MCP tools available to Claude alongside native tools
- Configurable per-project or globally

### Distribution

**Simple CLI Wrapper:**
```bash
compass              # Start Claude Code with Compass output style
compass install      # Install Compass configuration for Claude Code
```

## Implementation Philosophy

### Start Simple, Iterate

**Phase 1: Context Representation**
- Structured markdown context in `context/` directories
- Interactive `/distill` workflow with file tools
- Session archiving for reference
- Goals with temporal tracking
- Token-efficient conversation sessions

**Phase 2: Context Intelligence**
- Optimize context loading (full → sections → semantic search)
- Enhanced distillation prompts
- Smart distillation timing suggestions
- Context organization patterns

**Phase 3: Integration Enrichment**
- Calendar integration for time-awareness
- Additional MCP integrations as needed
- Richer goal progress tracking
- Proactive suggestions based on context

**Phase 4: Advanced**
- Predictive recommendations
- Pattern recognition across projects
- Cross-project context insights

### Iteration Cadence

- Ship small, functional increments
- Validate with real usage daily
- Adjust based on what actually helps
- Remove what doesn't add value

## Success Metrics

### Daily Efficiency Use Case
- Time saved on task selection
- Reduction in context-switching overhead
- User confidence in priorities
- Frequency of "this was the right call" moments

### Long-term Efficiency Use Case
- Goal completion rate
- Consistency of progress (weekly touch points)
- Opportunistic progress captures
- User satisfaction with goal achievement

## Future Possibilities

Ideas for later exploration:
- Team coordination mode (helping entire teams prioritize)
- Learning mode (analyze patterns in effective execution)
- Integration with pomodoro/time-blocking
- Voice interface for quick check-ins
- Mobile companion for on-the-go context
- Visualization dashboard for progress

## Key Innovation: Distillation Workflow

The distillation workflow is what makes context-aware AI sustainable:

**The Problem:**
- Conversations accumulate message history linearly
- Token costs grow with every interaction
- Long message histories = expensive API calls
- Atomic fact extraction creates noise, not signal
- Strategic thinking and relationships get lost

**The Solution:**
- Conversations build naturally in message history
- User distills at decision points (`/distill`)
- Agent reviews FULL conversation for narrative and insights
- Updates structured markdown context interactively (using Read/Edit/Write tools)
- Archives complete session for reference
- Clears messages for fresh start

**The Result:**
- 3-4x token reduction (5KB context vs 20KB+ messages)
- Preserves strategic thinking and relationships
- Human-readable, editable context files
- Project-scoped (different context per project)
- Version-controllable with git
- Agent maintains continuity across sessions

**Example Distillation:**
```
22KB conversation → 5KB structured context + archived session
Next session starts with 5KB context instead of 22KB history
Sustainable for long-term projects
```

## Anti-Goals

What this is NOT:
- Not a project management tool (we integrate with those)
- Not a replacement for planning (we help execute plans)
- Not a task tracker (we help pick from existing tasks)
- Not a heavy desktop app (stays lightweight CLI)
- Not AI doing work for you (AI helping you decide work)
- Not automatic context extraction (user-controlled distillation)

---

## Summary

The Execution Efficiency Assistant transforms Compass into a context-aware decision support tool that helps answer "what should I do next?" for both immediate tasks and long-term goals.

**Key innovation:** Interactive distillation workflow that converts rich conversations into structured, human-readable context while maintaining token efficiency. Context is stored as markdown in visible `context/` directories, preserving strategic thinking and relationships between concepts.

The assistant becomes your executive function partner: building context through natural conversation, distilling insights at decision points, tracking goals with temporal awareness, and helping you maintain momentum on what matters most—all while staying lightweight and sustainable for long-term use.
