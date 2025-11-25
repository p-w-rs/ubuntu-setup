#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install xclip
# Command-line clipboard tool for X11

set -e

echo "Installing xclip..."

# Update package list
echo "Updating package list..."
apt update

# Install xclip
echo "Installing xclip..."
apt install -y xclip

echo ""
echo "✓ xclip installed successfully!"
echo ""
echo "Usage: xclip [options]"
echo "Examples:"
echo "  echo 'text' | xclip                    # Copy to clipboard"
echo "  xclip -o                               # Paste from clipboard"
echo "  cat file.txt | xclip -selection clipboard  # Copy file contents"
echo ""
echo "Note: For Wayland, use wl-clipboard instead"
