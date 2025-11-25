# REQUIRES_SUDO: no
# DEPENDS_ON: fish fisher nerdfonts ghostty ghostty_cfg fish_cfg

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Tide Prompt"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing Tide prompt..."
fisher install IlanCosman/tide@v6 2>&1 | grep -v "^$" || true

echo ""
echo "✓ Tide prompt installed successfully!"
echo ""
echo "Configure Tide by running: tide configure"
echo ""
