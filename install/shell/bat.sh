# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install bat
# A cat clone with syntax highlighting and Git integration

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing bat"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install bat
echo "→ Installing bat..."
apt install -y bat > /dev/null 2>&1

# Create symlink for bat command (Debian names it 'batcat')
echo "→ Creating bat symlink..."
mkdir -p "$HOME/.local/bin"
ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"

echo ""
echo "✓ bat installed successfully!"
echo ""
echo "Symlink created: ~/.local/bin/bat -> /usr/bin/batcat"
echo ""
echo "Usage: bat [options] <file>"
echo "Examples:"
echo "  bat file.txt          # View with syntax highlighting"
echo "  bat -A file.txt       # Show all characters"
echo "  bat --style=plain     # Disable decorations"
echo ""
