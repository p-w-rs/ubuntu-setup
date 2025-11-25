#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: essential

# Install Neovim
# Hyperextensible Vim-based text editor

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Neovim"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install Neovim
echo "→ Installing Neovim..."
apt install -y neovim > /dev/null 2>&1

echo ""
echo "✓ Neovim installed successfully!"
echo ""
echo "Usage: nvim [file]"
echo ""
echo "Configuration location: ~/.config/nvim/"
echo "Data location: ~/.local/share/nvim/"
echo ""
echo "Getting started:"
echo "  nvim                  # Start Neovim"
echo "  nvim file.txt         # Edit a file"
echo "  :Tutor                # Interactive tutorial (run inside Neovim)"
echo ""
echo "Verify installation: nvim --version"
echo ""
