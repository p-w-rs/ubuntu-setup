#!/bin/bash

# Top-level setup script for Debian-based systems
# Runs all installation scripts, then all configuration scripts
# Usage: ./setup.sh [--nvidia --os-type TYPE --os-version VER] [--cuda-version X] [--cudnn-version Y]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   Debian System Setup Script               ║"
echo "║   Automated Installation & Configuration   ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Check if running as regular user
if [ "$EUID" -eq 0 ]; then
    echo "! Error: Do not run this script with sudo" >&2
    echo "  Scripts will request sudo when needed" >&2
    exit 1
fi

# Verify this is a Debian-based system
if ! command -v apt &> /dev/null; then
    echo "! Error: apt not found. This script is for Debian-based systems only." >&2
    exit 1
fi

# Step 1: Run all installation scripts
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  STEP 1: Installation Phase"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ -f "$SCRIPT_DIR/install.sh" ]; then
    chmod +x "$SCRIPT_DIR/install.sh"
    # Pass all arguments through to install.sh
    "$SCRIPT_DIR/install.sh" "$@"
else
    echo "⚠  Warning: install.sh not found, skipping installations" >&2
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  STEP 2: Configuration Phase"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Step 2: Run all configuration scripts
if [ -f "$SCRIPT_DIR/configure.sh" ]; then
    chmod +x "$SCRIPT_DIR/configure.sh"
    "$SCRIPT_DIR/configure.sh"
else
    echo "⚠  Warning: configure.sh not found, skipping configurations" >&2
fi

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   Setup Complete!                          ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "✓ Your system has been configured."
echo ""
echo "Next steps:"
echo "  1. Set Fish as your default shell:"
echo "     chsh -s /usr/bin/fish"
echo ""
echo "  2. Log out and log back in"
echo ""
echo "  3. Configure Tide prompt:"
echo "     tide configure"
echo ""
echo "  4. Add your API keys to:"
echo "     ~/.config/fish/conf.d/90-api-keys.fish"
echo ""

# Check if NVIDIA was installed by looking at exported variables
if [ -n "$NVIDIA_CUDA_VERSION" ]; then
    echo "  5. ⚠  REBOOT to activate NVIDIA drivers"
    echo "     After reboot, verify with: nvidia-smi"
    echo ""
fi
