#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install Fontconfig
# Font configuration and customization library

set -e

echo "Installing Fontconfig..."

# Update package list
echo "Updating package list..."
apt update

# Install fontconfig
echo "Installing fontconfig..."
apt install -y fontconfig

echo ""
echo "✓ Fontconfig installed successfully!"
echo ""
echo "Font directories:"
echo "  System: /usr/share/fonts/"
echo "  User:   ~/.local/share/fonts/"
echo ""
echo "Update font cache with: fc-cache -fv"
