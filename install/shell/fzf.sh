#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install fzf
# Command-line fuzzy finder

set -e

echo "Installing fzf..."

# Update package list
echo "Updating package list..."
apt update

# Install fzf
echo "Installing fzf..."
apt install -y fzf

echo ""
echo "✓ fzf installed successfully!"
echo ""
echo "Usage: fzf [options]"
echo "Examples:"
echo "  ls | fzf                        # Fuzzy search files"
echo "  vim \$(fzf)                      # Open file in vim with fuzzy search"
echo "  history | fzf                   # Search command history"
echo ""
echo "Shell integration:"
echo "  Ctrl+R - Search command history"
echo "  Ctrl+T - Search files"
echo "  Alt+C  - Change directory"
