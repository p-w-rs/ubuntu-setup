#!/bin/bash
# DEPENDS_ON: cuda cudnn

# Install TensorRT
# NVIDIA's high-performance deep learning inference optimizer and runtime

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing TensorRT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install TensorRT
echo "→ Installing TensorRT packages..."
sudo apt install -y tensorrt > /dev/null 2>&1

# Install additional TensorRT components
echo "→ Installing TensorRT development packages..."
sudo apt install -y \
    libnvinfer-dev \
    libnvinfer-plugin-dev \
    libnvparsers-dev \
    libnvonnxparsers-dev \
    python3-libnvinfer \
    python3-libnvinfer-dev > /dev/null 2>&1 || true

echo ""
echo "✓ TensorRT installed successfully!"
echo ""
echo "Library location: /usr/lib/x86_64-linux-gnu/"
echo "Headers location: /usr/include/x86_64-linux-gnu/"
echo ""
echo "Verify installation: Check for libnvinfer in /usr/lib/"
echo ""
