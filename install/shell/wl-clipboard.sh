#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install wl-clipboard
# Command-line clipboard tool for Wayland

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing wl-clipboard"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install wl-clipboard
echo "→ Installing wl-clipboard..."
apt install -y wl-clipboard > /dev/null 2>&1

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
echo ""
