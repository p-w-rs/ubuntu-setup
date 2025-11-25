#!/bin/bash
# DEPENDS_ON:

# Install file
# File type identification utility

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing file utility"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install file
echo "→ Installing file..."
sudo apt install -y file > /dev/null 2>&1

echo ""
echo "✓ file utility installed successfully!"
echo ""
echo "Usage: file [options] <file>"
echo "Examples:"
echo "  file document.pdf           # Identify file type"
echo "  file -b document.pdf        # Brief output"
echo "  file -i document.pdf        # MIME type"
echo "  file *                      # Check all files in directory"
echo ""
