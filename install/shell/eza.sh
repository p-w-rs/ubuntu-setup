# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install eza
# Modern replacement for ls with more features and better defaults

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing eza"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install eza
echo "→ Installing eza..."
apt install -y eza > /dev/null 2>&1

echo ""
echo "✓ eza installed successfully!"
echo ""
echo "Usage: eza [options] [path]"
echo "Examples:"
echo "  eza                   # List files"
echo "  eza -l                # Long format"
echo "  eza -la               # Include hidden files"
echo "  eza --tree            # Tree view"
echo "  eza --git             # Show git status"
echo ""
