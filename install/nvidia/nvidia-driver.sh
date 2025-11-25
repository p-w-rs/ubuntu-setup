#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: essential

# Install NVIDIA GPU drivers
# Adds CUDA repository and installs latest compatible driver
# Works with all NVIDIA GPUs including RTX 5090 (Blackwell)

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing NVIDIA GPU Drivers"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Detect system architecture and os version
ARCH=$(dpkg --print-architecture)
DISTRO="$(lsb_release -rs | cut -d. -f1)"

echo "→ Detected: $DISTRO ($ARCH)"
echo ""

# Check if NVIDIA GPU is present
if ! lspci | grep -i nvidia &> /dev/null; then
    echo "! Warning: No NVIDIA GPU detected. Installation will continue anyway." >&2
    echo ""
fi

# Add NVIDIA CUDA repository
echo "→ Adding NVIDIA CUDA repository..."
wget -q -O /tmp/cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i /tmp/cuda-keyring.deb > /dev/null 2>&1
rm /tmp/cuda-keyring.deb

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install CUDA drivers (includes NVIDIA driver)
echo "→ Installing NVIDIA drivers..."
apt install -y cuda-drivers > /dev/null 2>&1

echo ""
echo "✓ NVIDIA drivers installed successfully!"
echo ""
echo "IMPORTANT: Reboot your system for drivers to take effect"
echo "After reboot, verify installation with: nvidia-smi"
echo ""
