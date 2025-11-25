#!/bin/bash
# REQUIRES_SUDO: no
# DEPENDS_ON: essential

# Install Julia programming language
# Installs per-user (not system-wide)

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Julia"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Run the official Julia installation script
echo "→ Running Julia installation script..."
curl -fsSL https://install.julialang.org | sh

echo ""
echo "✓ Julia installed successfully!"
echo ""
echo "You may need to restart your shell or add Julia to PATH"
echo "Start Julia with: julia"
echo ""
