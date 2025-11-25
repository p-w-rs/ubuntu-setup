#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install ripgrep
# Fast recursive search tool that respects .gitignore

set -e

echo "Installing ripgrep..."

# Update package list
echo "Updating package list..."
apt update

# Install ripgrep
echo "Installing ripgrep..."
apt install -y ripgrep

echo ""
echo "✓ ripgrep installed successfully!"
echo ""
echo "Usage: rg [options] <pattern> [path...]"
echo "Examples:"
echo "  rg 'pattern'              # Search current directory"
echo "  rg 'pattern' path/        # Search specific path"
echo "  rg -i 'pattern'           # Case insensitive"
echo "  rg -t py 'pattern'        # Search only Python files"
