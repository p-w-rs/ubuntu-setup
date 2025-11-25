#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: cuda

# Install cuSPARSE (CUDA Sparse Matrix library)
# GPU-accelerated operations on sparse matrices

set -e

# CUDA version from environment or default
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"
CUDA_VERSION_FORMATTED="${CUDA_VERSION}-0"

echo "Installing cuSPARSE..."

# Update package list
echo "Updating package list..."
apt update

# Install cuSPARSE development libraries
echo "Installing cuSPARSE libraries..."
apt install -y \
    libcusparse-$CUDA_VERSION_FORMATTED \
    libcusparse-dev-$CUDA_VERSION_FORMATTED

echo ""
echo "✓ cuSPARSE installed successfully!"
echo ""
echo "Library location: /usr/local/cuda/lib64/"
echo "Headers location: /usr/local/cuda/include/"
