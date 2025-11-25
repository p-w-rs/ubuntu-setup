#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: nvidia-driver gcc

# Install CUDA Toolkit
# Provides CUDA compiler, libraries, and development tools

set -e

# CUDA version from environment or default
CUDA_VERSION="${NVIDIA_CUDA_VERSION:-13}"
CUDA_VERSION_FORMATTED="${CUDA_VERSION}-0"  # Format: major-minor (e.g., 13-0)

echo "Installing CUDA Toolkit $CUDA_VERSION..."

# Update package list
echo "Updating package list..."
apt update

# Install CUDA toolkit
echo "Installing CUDA toolkit..."
apt install -y cuda-toolkit-$CUDA_VERSION_FORMATTED

# Set up environment variables
echo "Setting up environment variables..."
CUDA_HOME="/usr/local/cuda-${CUDA_VERSION}.0"

# Add to system-wide profile
cat > /etc/profile.d/cuda.sh <<EOF
# CUDA environment variables
export CUDA_HOME=$CUDA_HOME
export PATH=\$CUDA_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$CUDA_HOME/lib64:\$LD_LIBRARY_PATH
EOF

chmod +x /etc/profile.d/cuda.sh

# Create symlink for generic /usr/local/cuda
ln -sf $CUDA_HOME /usr/local/cuda

echo ""
echo "✓ CUDA Toolkit installed successfully!"
echo ""
echo "Installation location: $CUDA_HOME"
echo "Symlinked to: /usr/local/cuda"
echo ""
echo "Restart your shell or run: source /etc/profile.d/cuda.sh"
echo "Verify installation with: nvcc --version"
