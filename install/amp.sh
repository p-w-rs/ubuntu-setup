#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install Amp
# A text editor for your terminal
# Note: Installs Rust/Cargo temporarily, then removes them after installation

set -e

echo "Installing Amp..."

# Check if we're running as root (we need to switch users)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run with sudo"
    exit 1
fi

# Get the original user (the one who called sudo)
ORIGINAL_USER="${SUDO_USER:-$USER}"
ORIGINAL_HOME=$(eval echo ~$ORIGINAL_USER)

echo "Installing Rust/Cargo temporarily..."
# Install Rust as the original user
sudo -u $ORIGINAL_USER bash -c 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y'

# Source cargo env
export PATH="$ORIGINAL_HOME/.cargo/bin:$PATH"

echo "Building Amp with Cargo..."
# Install amp as the original user
sudo -u $ORIGINAL_USER bash -c "source $ORIGINAL_HOME/.cargo/env && cargo install amp"

# Copy amp binary to system location
echo "Installing Amp to /usr/local/bin..."
cp "$ORIGINAL_HOME/.cargo/bin/amp" /usr/local/bin/amp
chmod +x /usr/local/bin/amp

# Remove Rust/Cargo completely
echo "Removing Rust/Cargo..."
rm -rf "$ORIGINAL_HOME/.cargo"
rm -rf "$ORIGINAL_HOME/.rustup"

echo ""
echo "✓ Amp installed successfully!"
echo ""
echo "Usage: amp [file]"
echo ""
echo "Getting started:"
echo "  amp file.txt          # Edit a file"
echo "  amp                   # Open Amp"
echo ""
echo "Configuration: ~/.config/amp/"
echo ""
echo "Note: Rust/Cargo have been removed from the system"
