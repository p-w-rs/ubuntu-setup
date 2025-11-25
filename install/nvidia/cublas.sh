#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: cuda

# Install cuBLAS (CUDA Basic Linear Algebra Subroutines)
# High-performance BLAS implementation for NVIDIA GPUs

set -e

# CUDA version from environment or default
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"
CUDA_VERSION_FORMATTED="${CUDA_VERSION}-0"

echo "Installing cuBLAS..."

# Update package list
echo "Updating package list..."
apt update

# Install cuBLAS development libraries
echo "Installing cuBLAS libraries..."
apt install -y \
    libcublas-$CUDA_VERSION_FORMATTED \
    libcublas-dev-$CUDA_VERSION_FORMATTED

echo ""
echo "✓ cuBLAS installed successfully!"
echo ""
echo "Library location: /usr/local/cuda/lib64/"
echo "Headers location: /usr/local/cuda/include/"
