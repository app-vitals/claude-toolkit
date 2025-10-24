#!/usr/bin/env bash

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Uninstalling Claude Code commands...${NC}"
echo ""

# Confirm
read -p "This will remove installed commands. Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Uninstall cancelled."
  exit 0
fi

# Remove commands
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REMOVED_COUNT=0

for cmd in "$SCRIPT_DIR"/*.md; do
  if [ -f "$cmd" ]; then
    filename=$(basename "$cmd")
    if [ -f ~/.claude/commands/"$filename" ]; then
      rm ~/.claude/commands/"$filename"
      echo -e "${GREEN}✓${NC} Removed /${filename%.md} command"
      ((REMOVED_COUNT++))
    fi
  fi
done

echo ""
if [ $REMOVED_COUNT -eq 0 ]; then
  echo -e "${YELLOW}No commands found to remove${NC}"
else
  echo -e "${GREEN}Removed $REMOVED_COUNT command(s)${NC}"
fi
