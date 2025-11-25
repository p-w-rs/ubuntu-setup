#!/bin/bash
# DEPENDS_ON: essential

# Install NVIDIA GPU drivers
# Adds CUDA repository and installs latest compatible driver
# Works with all NVIDIA GPUs including RTX 5090 (Blackwell)
# REQUIRES: --os-type and --os-version to be specified

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing NVIDIA GPU Drivers"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get OS info from environment - NO AUTO-DETECTION
OS_TYPE="${NVIDIA_OS_TYPE:-}"
OS_VERSION="${NVIDIA_OS_VERSION:-}"

# Validate OS type and version are provided
if [ -z "$OS_TYPE" ] || [ -z "$OS_VERSION" ]; then
    echo "! Error: OS type and version must be specified for NVIDIA installation" >&2
    echo "" >&2
    echo "Usage:" >&2
    echo "  ./install.sh --nvidia --os-type <ubuntu|debian> --os-version <version>" >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "  ./install.sh --nvidia --os-type ubuntu --os-version 24" >&2
    echo "  ./install.sh --nvidia --os-type ubuntu --os-version 22" >&2
    echo "  ./install.sh --nvidia --os-type debian --os-version 12" >&2
    echo "  ./install.sh --nvidia --os-type debian --os-version 13" >&2
    echo "" >&2
    exit 1
fi

# Validate OS type
case "$OS_TYPE" in
    ubuntu|debian)
        ;;
    *)
        echo "! Error: Invalid OS type: $OS_TYPE" >&2
        echo "  Supported: ubuntu, debian" >&2
        exit 1
        ;;
esac

# Validate OS version
case "$OS_TYPE" in
    ubuntu)
        case "$OS_VERSION" in
            22|24)
                OS_VERSION="${OS_VERSION}04"  # 22 -> 2204, 24 -> 2404
                ;;
            2204|2404)
                # Already in correct format
                ;;
            *)
                echo "! Error: Invalid Ubuntu version: $OS_VERSION" >&2
                echo "  Supported: 22, 24 (or 2204, 2404)" >&2
                exit 1
                ;;
        esac
        ;;
    debian)
        case "$OS_VERSION" in
            12|13)
                # Version is fine as-is
                ;;
            *)
                echo "! Error: Invalid Debian version: $OS_VERSION" >&2
                echo "  Supported: 12, 13" >&2
                exit 1
                ;;
        esac
        ;;
esac

# Detect architecture
ARCH="x86_64" # $(dpkg --print-architecture)

echo "→ OS: $OS_TYPE $OS_VERSION"
echo "→ Architecture: $ARCH"
echo ""

# Check if NVIDIA GPU is present
if ! lspci | grep -i nvidia &> /dev/null; then
    echo "! Warning: No NVIDIA GPU detected. Installation will continue anyway." >&2
    echo ""
fi

# Construct repository URL
case "$OS_TYPE" in
    ubuntu)
        REPO_URL="https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${OS_VERSION}/${ARCH}"
        ;;
    debian)
        REPO_URL="https://developer.download.nvidia.com/compute/cuda/repos/debian${OS_VERSION}/${ARCH}"
        ;;
esac

echo "→ Using repository: $REPO_URL"
echo ""

# Add NVIDIA CUDA repository
echo "→ Adding NVIDIA CUDA repository..."
wget -q -O /tmp/cuda-keyring.deb ${REPO_URL}/cuda-keyring_1.1-1_all.deb
sudo dpkg -i /tmp/cuda-keyring.deb > /dev/null 2>&1
rm /tmp/cuda-keyring.deb

# Update package list and upgrade after adding NVIDIA repo
echo "→ Updating package list with NVIDIA repository..."
sudo apt update > /dev/null 2>&1

echo "→ Upgrading packages from new repository..."
sudo apt upgrade -y > /dev/null 2>&1

# Install CUDA drivers (includes NVIDIA driver)
echo "→ Installing NVIDIA drivers..."
sudo apt install -y cuda-drivers > /dev/null 2>&1

echo ""
echo "✓ NVIDIA drivers installed successfully!"
echo ""
echo "Configuration:"
echo "  OS: $OS_TYPE $OS_VERSION"
echo "  Architecture: $ARCH"
echo "  Repository: $REPO_URL"
echo ""
echo "IMPORTANT: Reboot your system for drivers to take effect"
echo "After reboot, verify installation with: nvidia-smi"
echo ""
