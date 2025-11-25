#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install Neovim
# Hyperextensible Vim-based text editor

set -e

echo "Installing Neovim..."

# Update package list
echo "Updating package list..."
apt update

# Install Neovim
echo "Installing Neovim..."
apt install -y neovim

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
