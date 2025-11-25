#!/bin/bash
# DEPENDS_ON:

# Install fd
# Fast and user-friendly alternative to find

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing fd"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install fd (package name is fd-find on Debian)
echo "→ Installing fd..."
sudo apt install -y fd-find > /dev/null 2>&1

# Create symlink for 'fd' command (Debian names it 'fdfind')
echo "→ Creating fd symlink..."
sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd

echo ""
echo "✓ fd installed successfully!"
echo ""
echo "Usage: fd [options] <pattern> [path...]"
echo "Examples:"
echo "  fd pattern              # Search for pattern"
echo "  fd -e txt               # Find all .txt files"
echo "  fd -H pattern           # Include hidden files"
echo "  fd -t f pattern         # Only files (not directories)"
echo ""
