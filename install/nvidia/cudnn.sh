# REQUIRES_SUDO: yes
# DEPENDS_ON: cuda

# Install cuDNN (CUDA Deep Neural Network library)
# Provides GPU-accelerated primitives for deep learning

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing cuDNN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Versions from environment or defaults
CUDNN_VERSION="${NVIDIA_CUDNN_VERSION:-9}"
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"

echo "→ cuDNN Version: $CUDNN_VERSION"
echo "→ CUDA Version: $CUDA_VERSION"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install cuDNN
echo "→ Installing cuDNN libraries..."
apt install -y cudnn${CUDNN_VERSION}-cuda-${CUDA_VERSION} > /dev/null 2>&1

echo ""
echo "✓ cuDNN installed successfully!"
echo ""
echo "Library location: /usr/local/cuda/lib64/"
echo "Headers location: /usr/local/cuda/include/"
echo ""
