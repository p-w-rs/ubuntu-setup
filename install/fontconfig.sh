#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: essential

# Install Fontconfig
# Font configuration and customization library

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Fontconfig"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install fontconfig
echo "→ Installing fontconfig..."
apt install -y fontconfig > /dev/null 2>&1

echo ""
echo "✓ Fontconfig installed successfully!"
echo ""
echo "Font directories:"
echo "  System: /usr/share/fonts/"
echo "  User:   ~/.local/share/fonts/"
echo ""
echo "Update font cache with: fc-cache -fv"
echo ""
