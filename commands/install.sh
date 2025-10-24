#!/usr/bin/env bash

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Installing Claude Code commands...${NC}"
echo ""

# Check for Claude
if ! command -v claude &> /dev/null; then
  echo -e "${YELLOW}Warning: Claude not found${NC}"
  echo "You'll need to install it from: https://www.anthropic.com/claude/download"
  echo ""
fi

# Create directory
mkdir -p ~/.claude/commands

echo -e "${GREEN}✓${NC} Created commands directory"

# Install commands
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALLED_COUNT=0

for cmd in "$SCRIPT_DIR"/*.md; do
  if [ -f "$cmd" ]; then
    filename=$(basename "$cmd")
    cp "$cmd" ~/.claude/commands/
    echo -e "${GREEN}✓${NC} Installed /${filename%.md} command"
    ((INSTALLED_COUNT++))
  fi
done

echo ""
if [ $INSTALLED_COUNT -eq 0 ]; then
  echo -e "${YELLOW}No commands found to install${NC}"
else
  echo -e "${GREEN}Installed $INSTALLED_COUNT command(s) successfully!${NC}"
fi
