#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install NVIDIA GPU drivers
# Adds CUDA repository and installs latest compatible driver
# Works with all NVIDIA GPUs including RTX 5090 (Blackwell)

set -e

echo "Installing NVIDIA GPU drivers..."

# Detect system architecture and Debian version
ARCH=$(dpkg --print-architecture)
DISTRO="debian$(lsb_release -rs | cut -d. -f1)"

echo "Detected: $DISTRO ($ARCH)"

# Check if NVIDIA GPU is present
if ! lspci | grep -i nvidia &> /dev/null; then
    echo "Warning: No NVIDIA GPU detected. Installation will continue anyway."
fi

# Add NVIDIA CUDA repository
echo "Adding NVIDIA CUDA repository..."
wget -O /tmp/cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/$DISTRO/$ARCH/cuda-keyring_1.1-1_all.deb
dpkg -i /tmp/cuda-keyring.deb
rm /tmp/cuda-keyring.deb

# Update package list
echo "Updating package list..."
apt update

# Install CUDA drivers (includes NVIDIA driver)
echo "Installing NVIDIA drivers..."
apt install -y cuda-drivers

echo ""
echo "✓ NVIDIA drivers installed successfully!"
echo ""
echo "IMPORTANT: Reboot your system for drivers to take effect"
echo "After reboot, verify installation with: nvidia-smi"
