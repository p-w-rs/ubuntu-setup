#!/bin/bash
# REQUIRES_SUDO: no
# DEPENDS_ON:

# Install uv - modern Python package and project manager
# Installs per-user (not system-wide)

set -e

echo "Installing uv Python package manager..."

# Run the official uv installation script
curl -LsSf https://astral.sh/uv/install.sh | sh

echo ""
echo "✓ uv installed successfully!"
echo ""
echo "Start using uv with: uv --help"
