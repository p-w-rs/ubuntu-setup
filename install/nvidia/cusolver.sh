# REQUIRES_SUDO: yes
# DEPENDS_ON: cuda

# Install cuSOLVER (CUDA Linear Algebra Solver library)
# GPU-accelerated linear algebra solvers and eigenvalue problems

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing cuSOLVER"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# CUDA version from environment or default
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"
CUDA_VERSION_FORMATTED="${CUDA_VERSION}-0"

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install cuSOLVER development libraries
echo "→ Installing cuSOLVER libraries..."
apt install -y \
    libcusolver-$CUDA_VERSION_FORMATTED \
    libcusolver-dev-$CUDA_VERSION_FORMATTED > /dev/null 2>&1

echo ""
echo "✓ cuSOLVER installed successfully!"
echo ""
echo "Library location: /usr/local/cuda/lib64/"
echo "Headers location: /usr/local/cuda/include/"
echo ""
