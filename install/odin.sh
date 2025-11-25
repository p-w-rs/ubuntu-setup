# REQUIRES_SUDO: yes
# DEPENDS_ON: llvm gcc essential

# Install Odin programming language
# Builds in ~/.local and symlinks to /usr/local/bin
# Requires LLVM and GCC to be installed first

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Odin Programming Language"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Ensure ~/.local directory exists
mkdir -p "$HOME/.local"

# Clone Odin repository to ~/.local
ODIN_DIR="$HOME/.local/Odin"
if [ ! -d "$ODIN_DIR" ]; then
    echo "→ Cloning Odin repository to ~/.local/Odin..."
    git clone https://github.com/odin-lang/Odin "$ODIN_DIR" 2>&1 | grep -v "^$" || true
else
    echo "→ Odin repository already exists, updating..."
    cd "$ODIN_DIR"
    git pull > /dev/null 2>&1
fi

cd "$ODIN_DIR"

# Build Odin
echo "→ Building Odin..."
make release-native > /dev/null 2>&1

# Create symlink in /usr/local/bin
echo "→ Creating symlink in /usr/local/bin..."
ln -sf "$ODIN_DIR/odin" /usr/local/bin/odin

echo ""
echo "✓ Odin installed successfully!"
echo ""
echo "Installation location: $ODIN_DIR"
echo "Binary symlinked to: /usr/local/bin/odin"
echo ""
echo "Verify installation: odin version"
echo ""
