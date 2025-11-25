#!/bin/bash
# DEPENDS_ON: cuda

# Install cuFFT (CUDA Fast Fourier Transform library)
# GPU-accelerated FFT library for signal processing

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing cuFFT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# CUDA version from environment or default
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"
CUDA_VERSION_FORMATTED="${CUDA_VERSION}-0"

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install cuFFT development libraries
echo "→ Installing cuFFT libraries..."
sudo apt install -y \
    libcufft-$CUDA_VERSION_FORMATTED \
    libcufft-dev-$CUDA_VERSION_FORMATTED > /dev/null 2>&1

echo ""
echo "✓ cuFFT installed successfully!"
echo ""
echo "Library location: /usr/local/cuda/lib64/"
echo "Headers location: /usr/local/cuda/include/"
echo ""
