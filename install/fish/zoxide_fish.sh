# REQUIRES_SUDO: no
# DEPENDS_ON: fish fisher zoxide

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing zoxide.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing zoxide plugin..."
fisher install kidonng/zoxide.fish 2>&1 | grep -v "^$" || true

echo ""
echo "✓ zoxide.fish plugin installed successfully!"
echo ""
