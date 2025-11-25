#!/bin/bash
# DEPENDS_ON: fish fisher nerdfonts ghostty

# Install Tide Prompt
# The ultimate Fish prompt with beautiful themes

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Tide Prompt"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing Tide prompt..."
fish -c "fisher install IlanCosman/tide@v6" 2>&1 | grep -v "^$" || true

echo ""
echo "✓ Tide prompt installed successfully!"
echo ""
echo "Configure Tide by running: tide configure"
echo ""
