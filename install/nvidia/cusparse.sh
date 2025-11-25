#!/bin/bash
# DEPENDS_ON: cuda

# Install cuSPARSE (CUDA Sparse Matrix library)
# GPU-accelerated operations on sparse matrices

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing cuSPARSE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# CUDA version from environment or default
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"
CUDA_VERSION_FORMATTED="${CUDA_VERSION}-0"

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install cuSPARSE development libraries
echo "→ Installing cuSPARSE libraries..."
sudo apt install -y \
    libcusparse-$CUDA_VERSION_FORMATTED \
    libcusparse-dev-$CUDA_VERSION_FORMATTED > /dev/null 2>&1

echo ""
echo "✓ cuSPARSE installed successfully!"
echo ""
echo "Library location: /usr/local/cuda/lib64/"
echo "Headers location: /usr/local/cuda/include/"
echo ""
