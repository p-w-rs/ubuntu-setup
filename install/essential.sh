#!/bin/bash
# DEPENDS_ON:

# Install essential system utilities
# This script runs first and provides fundamental tools needed by other scripts
# Includes: curl, wget, git, unzip, gpg, and basic system utilities

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Essential System Utilities"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list and fix any issues
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

echo "→ Fixing broken packages (if any)..."
sudo apt --fix-broken install -y > /dev/null 2>&1 || true

echo "→ Performing full system upgrade..."
sudo apt full-upgrade -y > /dev/null 2>&1

# Install essential tools
echo "→ Installing core utilities..."
sudo apt install -y \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common > /dev/null 2>&1

# Install compression/archive tools
echo "→ Installing compression tools..."
sudo apt install -y \
    unzip \
    zip \
    tar \
    gzip \
    bzip2 \
    xz-utils > /dev/null 2>&1

# Install system utilities
echo "→ Installing system utilities..."
sudo apt install -y \
    pciutils \
    usbutils \
    lsof \
    net-tools \
    dnsutils > /dev/null 2>&1

echo ""
echo "✓ Essential utilities installed successfully!"
echo ""
echo "Installed tools:"
echo "  Core utilities:"
echo "    • curl, wget (download tools)"
echo "    • git (version control)"
echo "    • ca-certificates, gnupg (security)"
echo "    • lsb-release (distribution info)"
echo ""
echo "  Compression tools:"
echo "    • unzip, zip, tar, gzip, bzip2, xz-utils"
echo ""
echo "  System utilities:"
echo "    • lspci, lsusb (hardware info)"
echo "    • lsof (file listing)"
echo "    • net-tools, dnsutils (networking)"
echo ""
