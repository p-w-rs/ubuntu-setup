#!/bin/bash
# DEPENDS_ON: fish fisher fish_cfg fzf fd bat

# Install fzf.fish Plugin
# Provides key bindings and functions for fzf in Fish

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing fzf.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing fzf plugin..."
fish -c "fisher install PatrickF1/fzf.fish" 2>&1 | grep -v "^$" || true

echo ""
echo "✓ fzf.fish plugin installed successfully!"
echo ""
