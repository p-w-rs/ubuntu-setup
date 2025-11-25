#!/bin/bash
# DEPENDS_ON:

# Install GNU Stow
# Symlink farm manager for dotfiles

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing GNU Stow"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install stow
echo "→ Installing stow..."
sudo apt install -y stow > /dev/null 2>&1

echo ""
echo "✓ GNU Stow installed successfully!"
echo ""
echo "Usage: stow [options] <package>"
echo "Examples:"
echo "  stow nvim          # Create symlinks for nvim config"
echo "  stow -D nvim       # Remove symlinks"
echo "  stow -R nvim       # Restow (remove and recreate)"
echo ""
