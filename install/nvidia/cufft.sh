#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: cuda

# Install cuFFT (CUDA Fast Fourier Transform library)
# GPU-accelerated FFT library for signal processing

set -e

# CUDA version from environment or default
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"
CUDA_VERSION_FORMATTED="${CUDA_VERSION}-0"

echo "Installing cuFFT..."

# Update package list
echo "Updating package list..."
apt update

# Install cuFFT development libraries
echo "Installing cuFFT libraries..."
apt install -y \
    libcufft-$CUDA_VERSION_FORMATTED \
    libcufft-dev-$CUDA_VERSION_FORMATTED

echo ""
echo "✓ cuFFT installed successfully!"
echo ""
echo "Library location: /usr/local/cuda/lib64/"
echo "Headers location: /usr/local/cuda/include/"
