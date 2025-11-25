# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install ripgrep
# Fast recursive search tool that respects .gitignore

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing ripgrep"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install ripgrep
echo "→ Installing ripgrep..."
apt install -y ripgrep > /dev/null 2>&1

echo ""
echo "✓ ripgrep installed successfully!"
echo ""
echo "Usage: rg [options] <pattern> [path...]"
echo "Examples:"
echo "  rg 'pattern'              # Search current directory"
echo "  rg 'pattern' path/        # Search specific path"
echo "  rg -i 'pattern'           # Case insensitive"
echo "  rg -t py 'pattern'        # Search only Python files"
echo ""
