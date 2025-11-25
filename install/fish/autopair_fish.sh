# REQUIRES_SUDO: no
# DEPENDS_ON: fish fisher

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing autopair.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing autopair plugin..."
fisher install jorgebucaran/autopair.fish 2>&1 | grep -v "^$" || true

echo ""
echo "✓ autopair.fish plugin installed successfully!"
echo ""
