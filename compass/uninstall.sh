#!/usr/bin/env bash

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Uninstalling Compass...${NC}"
echo ""

# Confirm
read -p "This will remove Compass configuration. Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Uninstall cancelled."
  exit 0
fi

# Remove files
if [ -f ~/.claude/output-styles/compass.md ]; then
  rm ~/.claude/output-styles/compass.md
  echo -e "${GREEN}✓${NC} Removed output style"
fi

if [ -f ~/.claude/commands/distill.md ]; then
  rm ~/.claude/commands/distill.md
  echo -e "${GREEN}✓${NC} Removed /distill command"
fi


# Remove symlink
if [ -L ~/.local/bin/compass ]; then
  rm ~/.local/bin/compass
  echo -e "${GREEN}✓${NC} Removed compass command"
fi

echo ""
echo -e "${GREEN}Compass uninstalled${NC}"
echo ""
echo "Note: Your project context files (context/) were not removed"
