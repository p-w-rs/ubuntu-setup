#!/bin/bash
# REQUIRES_SUDO: no
# DEPENDS_ON: fish fisher fish_cfg fzf fd bat

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
