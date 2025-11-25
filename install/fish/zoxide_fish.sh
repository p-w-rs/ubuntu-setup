#!/bin/bash
# REQUIRES_SUDO: no
# DEPENDS_ON: fish fisher fish_cfg zoxide

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing zoxide.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing zoxide plugin..."
fish -c "fisher install kidonng/zoxide.fish" 2>&1 | grep -v "^$" || true

echo ""
echo "✓ zoxide.fish plugin installed successfully!"
echo ""
