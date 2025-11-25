#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install FFmpeg
# Multimedia framework for video/audio processing

set -e

echo "Installing FFmpeg..."

# Update package list
echo "Updating package list..."
apt update

# Install FFmpeg
echo "Installing FFmpeg..."
apt install -y ffmpeg

echo ""
echo "✓ FFmpeg installed successfully!"
echo ""
echo "Verify installation: ffmpeg -version"
echo ""
echo "Common usage examples:"
echo "  ffmpeg -i input.mp4 output.avi          # Convert video"
echo "  ffmpeg -i input.mp4 -vn output.mp3      # Extract audio"
echo "  ffmpeg -i input.mp4 -ss 00:00:10 -t 5 output.mp4  # Cut 5 seconds from 10s mark"
