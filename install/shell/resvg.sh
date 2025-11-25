#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install resvg
# Fast SVG renderer and converter

set -e

echo "Installing resvg..."

# Update package list
echo "Updating package list..."
apt update

# Install resvg
echo "Installing resvg..."
apt install -y resvg

echo ""
echo "✓ resvg installed successfully!"
echo ""
echo "Usage: resvg [options] <input.svg> <output.png>"
echo "Examples:"
echo "  resvg input.svg output.png              # Render SVG to PNG"
echo "  resvg --width 1000 input.svg output.png # Set width"
echo "  resvg --background white input.svg output.png  # Set background"
