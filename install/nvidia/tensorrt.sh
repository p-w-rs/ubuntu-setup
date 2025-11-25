#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: cudnn

# Install TensorRT
# NVIDIA's high-performance deep learning inference optimizer and runtime

set -e

echo "Installing TensorRT..."

# Update package list
echo "Updating package list..."
apt update

# Install TensorRT
echo "Installing TensorRT packages..."
apt install -y tensorrt

# Install additional TensorRT components
echo "Installing TensorRT development packages..."
apt install -y \
    libnvinfer-dev \
    libnvinfer-plugin-dev \
    libnvparsers-dev \
    libnvonnxparsers-dev \
    python3-libnvinfer \
    python3-libnvinfer-dev || true

echo ""
echo "✓ TensorRT installed successfully!"
echo ""
echo "Library location: /usr/lib/x86_64-linux-gnu/"
echo "Headers location: /usr/include/x86_64-linux-gnu/"
echo ""
echo "Verify installation: Check for libnvinfer in /usr/lib/"
