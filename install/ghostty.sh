#!/bin/bash
# DEPENDS_ON: essential

# Install Ghostty terminal emulator
# Uses the official installation script

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Ghostty Terminal"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Run the official Ghostty installation script
echo "→ Running Ghostty installation script..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

echo ""
echo "✓ Ghostty terminal installed successfully!"
echo ""
echo "Launch with: ghostty"
echo ""
