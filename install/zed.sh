# REQUIRES_SUDO: no
# DEPENDS_ON:

# Install Zed
# High-performance multiplayer code editor

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Zed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Run the official Zed installation script
echo "→ Running Zed installation script..."
curl -f https://zed.dev/install.sh | sh

echo ""
echo "✓ Zed installed successfully!"
echo ""
echo "Start Zed with: zed"
echo ""
echo "Configuration location: ~/.config/zed/"
echo ""
