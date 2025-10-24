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

# Install CLI wrappers
mkdir -p ~/.local/bin

if [ -d "$SCRIPT_DIR/bin" ]; then
  for wrapper in "$SCRIPT_DIR/bin"/*; do
    if [ -f "$wrapper" ]; then
      wrapper_name=$(basename "$wrapper")
      chmod +x "$wrapper"
      ln -sf "$wrapper" ~/.local/bin/"$wrapper_name"
      echo -e "${GREEN}✓${NC} Linked $wrapper_name to ~/.local/bin"
    fi
  done
fi

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo ""
  echo -e "${YELLOW}Note: Add ~/.local/bin to your PATH${NC}"
  echo "  Add to ~/.zshrc or ~/.bashrc:"
  echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo ""
if [ $INSTALLED_COUNT -eq 0 ]; then
  echo -e "${YELLOW}No commands found to install${NC}"
else
  echo -e "${GREEN}Installed $INSTALLED_COUNT command(s) successfully!${NC}"
fi
