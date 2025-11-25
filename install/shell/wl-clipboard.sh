#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install wl-clipboard
# Command-line clipboard tool for Wayland

set -e

echo "Installing wl-clipboard..."

# Update package list
echo "Updating package list..."
apt update

# Install wl-clipboard
echo "Installing wl-clipboard..."
apt install -y wl-clipboard

echo ""
echo "✓ wl-clipboard installed successfully!"
echo ""
echo "Usage: wl-copy and wl-paste"
echo "Examples:"
echo "  echo 'text' | wl-copy       # Copy to clipboard"
echo "  wl-paste                    # Paste from clipboard"
echo "  cat file.txt | wl-copy      # Copy file contents"
echo ""
echo "Note: For X11, use xclip or xsel instead"
