#!/bin/bash
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

# Create symlink in $HOME/.local/bin
echo "→ Creating symlink in $HOME/.local/bin..."
ln -sf "$HOME/.juliaup/bin/juliaup" $HOME/.local/bin/juliaup
ln -sf "$HOME/.juliaup/bin/julialauncher" $HOME/.local/bin/julialauncher
ln -sf "$HOME/.juliaup/bin/julia" $HOME/.local/bin/julia

echo ""
echo "✓ Julia installed successfully!"
echo ""
echo "Installation location: $HOME/.juliaup"
echo "Binary symlinked to: $HOME/.local/bin/odin"
echo ""
echo "Start Julia with: julia"
echo ""
