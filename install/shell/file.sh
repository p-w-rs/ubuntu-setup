#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install file
# File type identification utility

set -e

echo "Installing file..."

# Update package list
echo "Updating package list..."
apt update

# Install file
echo "Installing file..."
apt install -y file

echo ""
echo "✓ file utility installed successfully!"
echo ""
echo "Usage: file [options] <file>"
echo "Examples:"
echo "  file document.pdf           # Identify file type"
echo "  file -b document.pdf        # Brief output"
echo "  file -i document.pdf        # MIME type"
echo "  file *                      # Check all files in directory"
