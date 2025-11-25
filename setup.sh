#!/bin/bash

# Top-level setup script for Debian-based systems
# Runs all installation scripts, then all configuration scripts
# Usage: ./setup.sh [--nvidia] [--cuda-version X] [--cudnn-version Y]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "╔════════════════════════════════════════════╗"
echo "║   Debian System Setup Script               ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Check if running as regular user
if [ "$EUID" -eq 0 ]; then
    echo "Error: Do not run this script with sudo"
    echo "The script will ask for sudo when needed"
    exit 1
fi

# Verify this is a Debian-based system
if ! command -v apt &> /dev/null; then
    echo "Error: apt not found. This script is for Debian-based systems only."
    exit 1
fi

# Step 1: Run all installation scripts
echo "STEP 1: Running installation scripts..."
echo "========================================"
echo ""

if [ -f "$SCRIPT_DIR/install.sh" ]; then
    chmod +x "$SCRIPT_DIR/install.sh"
    # Pass all arguments through to install.sh
    "$SCRIPT_DIR/install.sh" "$@"
else
    echo "Warning: install.sh not found, skipping installations"
fi

echo ""
echo "========================================"
echo "STEP 2: Running configuration scripts..."
echo "========================================"
echo ""

# Step 2: Run all configuration scripts
if [ -f "$SCRIPT_DIR/configure.sh" ]; then
    chmod +x "$SCRIPT_DIR/configure.sh"
    "$SCRIPT_DIR/configure.sh"
else
    echo "Warning: configure.sh not found, skipping configurations"
fi

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   Setup Complete!                          ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "Your system has been configured."
echo "You may need to restart your shell or reboot for all changes to take effect."
