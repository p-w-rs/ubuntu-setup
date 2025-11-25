#!/bin/bash
# DEPENDS_ON:

# Install FFmpeg
# Multimedia framework for video/audio processing

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing FFmpeg"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install FFmpeg
echo "→ Installing FFmpeg..."
sudo apt install -y ffmpeg > /dev/null 2>&1

echo ""
echo "✓ FFmpeg installed successfully!"
echo ""
echo "Verify installation: ffmpeg -version"
echo ""
echo "Common usage examples:"
echo "  ffmpeg -i input.mp4 output.avi          # Convert video"
echo "  ffmpeg -i input.mp4 -vn output.mp3      # Extract audio"
echo "  ffmpeg -i input.mp4 -ss 00:00:10 -t 5 output.mp4  # Cut 5 seconds from 10s mark"
echo ""
