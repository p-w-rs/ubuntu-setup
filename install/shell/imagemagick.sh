#!/bin/bash
# DEPENDS_ON:

# Install ImageMagick
# Image creation, editing, and conversion suite

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing ImageMagick"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install imagemagick
echo "→ Installing ImageMagick..."
sudo apt install -y imagemagick > /dev/null 2>&1

echo ""
echo "✓ ImageMagick installed successfully!"
echo ""
echo "Usage: convert [options] input output"
echo "Examples:"
echo "  convert input.jpg output.png          # Convert format"
echo "  convert input.jpg -resize 50% output.jpg  # Resize"
echo "  convert input.jpg -rotate 90 output.jpg   # Rotate"
echo "  identify image.jpg                    # Show image info"
echo ""
