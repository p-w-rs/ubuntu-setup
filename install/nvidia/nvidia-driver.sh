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
ARCH="x86_64"

echo "→ Target system:"
echo "  OS: $OS_TYPE $OS_VERSION"
echo "  Architecture: $ARCH"
echo ""

# Check if NVIDIA GPU is present
if ! lspci | grep -i nvidia &> /dev/null; then
    echo "! Warning: No NVIDIA GPU detected. Installation will continue anyway." >&2
    echo ""
fi

# Clean up any existing NVIDIA installations to prevent conflicts
echo "→ Cleaning up any existing NVIDIA installations..."

# Check if any nvidia packages are installed
NVIDIA_PACKAGES=$(dpkg -l 2>/dev/null | grep -i nvidia | grep ^ii | awk '{print $2}' || true)

if [ -n "$NVIDIA_PACKAGES" ]; then
    echo "  Found existing NVIDIA packages:"
    echo "$NVIDIA_PACKAGES" | sed 's/^/    - /'
    echo ""
    echo "  Removing existing NVIDIA packages..."

    # Remove all nvidia packages (quoted to prevent shell expansion)
    sudo apt-get remove --purge '^nvidia-.*' -y > /dev/null 2>&1 || true

    # Remove any remaining dependencies
    echo "  Cleaning up dependencies..."
    sudo apt autoremove -y > /dev/null 2>&1 || true

    echo "  ✓ Existing NVIDIA packages removed"
else
    echo "  No existing NVIDIA packages found"
fi

# Remove nouveau blacklist if it exists (NVIDIA installer will handle this)
if [ -f /etc/modprobe.d/blacklist-nvidia-nouveau.conf ]; then
    echo "  Removing old nouveau blacklist..."
    sudo rm -f /etc/modprobe.d/blacklist-nvidia-nouveau.conf
    echo "  ✓ Old nouveau blacklist removed"
fi

# Clean up any old xorg.conf that might cause conflicts
if [ -f /etc/X11/xorg.conf ]; then
    BACKUP_FILE="/etc/X11/xorg.conf.bak.$(date +%Y%m%d_%H%M%S)"
    echo "  Backing up old xorg.conf to $BACKUP_FILE..."
    sudo mv /etc/X11/xorg.conf "$BACKUP_FILE" 2>/dev/null || true
    echo "  ✓ Old xorg.conf backed up and removed"
fi

echo "  ✓ Cleanup complete"
echo ""

# Construct repository URL
case "$OS_TYPE" in
    ubuntu)
        REPO_URL="https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${OS_VERSION}/${ARCH}"
        ;;
    debian)
        REPO_URL="https://developer.download.nvidia.com/compute/cuda/repos/debian${OS_VERSION}/${ARCH}"
        ;;
esac

echo "→ Using NVIDIA repository:"
echo "  $REPO_URL"
echo ""

# Add NVIDIA CUDA repository
echo "→ Adding NVIDIA CUDA repository..."
wget -q -O /tmp/cuda-keyring.deb ${REPO_URL}/cuda-keyring_1.1-1_all.deb
sudo dpkg -i /tmp/cuda-keyring.deb > /dev/null 2>&1
rm /tmp/cuda-keyring.deb

# Update package list with NVIDIA repository
echo "→ Updating package list with NVIDIA repository..."
sudo apt update > /dev/null 2>&1

# Upgrade packages from new repository
echo "→ Upgrading packages from NVIDIA repository..."
sudo apt upgrade -y > /dev/null 2>&1

# Install CUDA drivers (includes NVIDIA driver)
echo "→ Installing NVIDIA drivers..."
sudo apt install -y nvidia-open > /dev/null 2>&1

echo ""
echo "✓ NVIDIA drivers installed successfully!"
echo ""
echo "Configuration:"
echo "  OS: $OS_TYPE $OS_VERSION"
echo "  Architecture: $ARCH"
echo "  Repository: $REPO_URL"
echo ""
echo "⚠  IMPORTANT: Reboot your system for drivers to take effect"
echo ""
echo "After reboot, verify installation with:"
echo "  nvidia-smi"
echo "  cat /proc/driver/nvidia/version"
echo ""
