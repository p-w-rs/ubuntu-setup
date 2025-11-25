#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install fd
# Fast and user-friendly alternative to find

set -e

echo "Installing fd..."

# Update package list
echo "Updating package list..."
apt update

# Install fd (package name is fd-find on Debian)
echo "Installing fd..."
apt install -y fd-find

# Create symlink for 'fd' command (Debian names it 'fdfind')
echo "Creating fd symlink..."
ln -sf /usr/bin/fdfind /usr/local/bin/fd

echo ""
echo "✓ fd installed successfully!"
echo ""
echo "Usage: fd [options] <pattern> [path...]"
echo "Examples:"
echo "  fd pattern              # Search for pattern"
echo "  fd -e txt               # Find all .txt files"
echo "  fd -H pattern           # Include hidden files"
echo "  fd -t f pattern         # Only files (not directories)"
