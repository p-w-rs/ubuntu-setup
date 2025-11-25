#!/bin/bash
# DEPENDS_ON: fish fisher fish_cfg

# Install autopair.fish Plugin
# Auto-complete matching pairs like (), [], {}, "", ''

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing autopair.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing autopair plugin..."
fish -c "fisher install jorgebucaran/autopair.fish" 2>&1 | grep -v "^$" || true

echo ""
echo "✓ autopair.fish plugin installed successfully!"
echo ""
