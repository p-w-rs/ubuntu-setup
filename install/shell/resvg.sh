#!/bin/bash
# DEPENDS_ON:

# Install resvg
# Fast SVG renderer and converter

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing resvg"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install resvg
echo "→ Installing resvg..."
sudo apt install -y librsvg2-bin > /dev/null 2>&1

echo ""
echo "✓ resvg installed successfully!"
echo ""
echo "Usage: resvg [options] <input.svg> <output.png>"
echo "Examples:"
echo "  resvg input.svg output.png              # Render SVG to PNG"
echo "  resvg --width 1000 input.svg output.png # Set width"
echo "  resvg --background white input.svg output.png  # Set background"
echo ""
