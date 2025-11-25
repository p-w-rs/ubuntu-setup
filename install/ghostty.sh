#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install Ghostty terminal emulator
# Uses the official installation script

set -e

echo "Installing Ghostty terminal emulator..."

# Run the official Ghostty installation script
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

echo ""
echo "✓ Ghostty terminal installed successfully!"
echo "Launch with: ghostty"
