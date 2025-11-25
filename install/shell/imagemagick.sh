#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install ImageMagick
# Image creation, editing, and conversion suite

set -e

echo "Installing ImageMagick..."

# Update package list
echo "Updating package list..."
apt update

# Install imagemagick
echo "Installing imagemagick..."
apt install -y imagemagick

echo ""
echo "✓ ImageMagick installed successfully!"
echo ""
echo "Usage: convert [options] input output"
echo "Examples:"
echo "  convert input.jpg output.png          # Convert format"
echo "  convert input.jpg -resize 50% output.jpg  # Resize"
echo "  convert input.jpg -rotate 90 output.jpg   # Rotate"
echo "  identify image.jpg                    # Show image info"
