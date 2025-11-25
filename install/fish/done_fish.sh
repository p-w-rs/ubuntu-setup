# REQUIRES_SUDO: no
# DEPENDS_ON: fish fisher jq

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing done.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing done plugin..."
fisher install franciscolourenco/done 2>&1 | grep -v "^$" || true

echo ""
echo "✓ done.fish plugin installed successfully!"
echo ""
