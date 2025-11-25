#!/bin/bash
# DEPENDS_ON: essential

# Install uv - modern Python package and project manager
# Installs per-user (not system-wide)

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing uv Python Package Manager"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Run the official uv installation script
echo "→ Running uv installation script..."
curl -LsSf https://astral.sh/uv/install.sh | sh

echo ""
echo "✓ uv installed successfully!"
echo ""
echo "Start using uv with: uv --help"
echo ""
