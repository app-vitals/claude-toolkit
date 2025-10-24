#!/usr/bin/env bash

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Installing Compass...${NC}"
echo ""

# Check for Claude
if ! command -v claude &> /dev/null; then
  echo -e "${YELLOW}Warning: Claude not found${NC}"
  echo "You'll need to install it from: https://www.anthropic.com/claude/download"
  echo ""
fi

# Create directories
mkdir -p ~/.claude/output-styles
mkdir -p ~/.claude/commands

echo -e "${GREEN}✓${NC} Created directories"

# Copy files
if [ ! -f "templates/output-style.md" ]; then
  echo -e "${RED}Error: templates/output-style.md not found${NC}"
  echo "Run this script from the compass directory"
  exit 1
fi

cp templates/output-style.md ~/.claude/output-styles/compass.md
echo -e "${GREEN}✓${NC} Installed Compass output style"

cp templates/distill.md ~/.claude/commands/distill.md
echo -e "${GREEN}✓${NC} Installed /distill command"

# Make CLI executable
chmod +x bin/compass

# Install to ~/.local/bin (user writable, no sudo needed)
mkdir -p ~/.local/bin
ln -sf "$(pwd)/bin/compass" ~/.local/bin/compass
echo -e "${GREEN}✓${NC} Linked compass to ~/.local/bin"

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo ""
  echo -e "${YELLOW}Note: Add ~/.local/bin to your PATH${NC}"
  echo "  Add to ~/.zshrc or ~/.bashrc:"
  echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo ""
echo -e "${GREEN}Compass installed successfully!${NC}"
echo ""
echo "Get started:"
echo "  cd your-project"
echo "  compass"
echo ""
echo "Run 'compass help' for more information"
