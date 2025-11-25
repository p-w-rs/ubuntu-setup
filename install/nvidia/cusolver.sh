#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: cuda

# Install cuSOLVER (CUDA Linear Algebra Solver library)
# GPU-accelerated linear algebra solvers and eigenvalue problems

set -e

# CUDA version from environment or default
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"
CUDA_VERSION_FORMATTED="${CUDA_VERSION}-0"

echo "Installing cuSOLVER..."

# Update package list
echo "Updating package list..."
apt update

# Install cuSOLVER development libraries
echo "Installing cuSOLVER libraries..."
apt install -y \
    libcusolver-$CUDA_VERSION_FORMATTED \
    libcusolver-dev-$CUDA_VERSION_FORMATTED

echo ""
echo "✓ cuSOLVER installed successfully!"
echo ""
echo "Library location: /usr/local/cuda/lib64/"
echo "Headers location: /usr/local/cuda/include/"
