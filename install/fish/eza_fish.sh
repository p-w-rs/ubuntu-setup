# REQUIRES_SUDO: no
# DEPENDS_ON: fish fisher eza

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing eza.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing eza plugin..."
fisher install givensuman/fish-eza 2>&1 | grep -v "^$" || true

echo ""
echo "✓ eza.fish plugin installed successfully!"
echo ""
