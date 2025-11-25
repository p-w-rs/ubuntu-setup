#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: essential

# Install Fish shell
# A smart and user-friendly command line shell

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Fish Shell"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install Fish
echo "→ Installing Fish..."
apt install -y fish > /dev/null 2>&1

echo ""
echo "✓ Fish shell installed successfully!"
echo ""
echo "Start Fish with: fish"
echo ""
echo "To set Fish as your default shell, run:"
echo "  chsh -s /usr/bin/fish"
echo ""
echo "Note: You may need to log out and back in for the change to take effect"
echo ""
