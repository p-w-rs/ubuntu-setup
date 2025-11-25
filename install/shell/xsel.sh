#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install xsel
# Command-line clipboard manipulation tool for X11

set -e

echo "Installing xsel..."

# Update package list
echo "Updating package list..."
apt update

# Install xsel
echo "Installing xsel..."
apt install -y xsel

echo ""
echo "✓ xsel installed successfully!"
echo ""
echo "Usage: xsel [options]"
echo "Examples:"
echo "  echo 'text' | xsel -b       # Copy to clipboard"
echo "  xsel -b                     # Paste from clipboard"
echo "  cat file.txt | xsel -b      # Copy file contents"
echo ""
echo "Note: For Wayland, use wl-clipboard instead"
