# REQUIRES_SUDO: yes
# DEPENDS_ON: odin essential

# Install OLS (Odin Language Server)
# Language server for Odin programming language

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing OLS (Odin Language Server)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get the original user
ORIGINAL_USER="${SUDO_USER:-$USER}"
ORIGINAL_HOME=$(eval echo ~$ORIGINAL_USER)

# Ensure ~/.local directory exists
sudo -u $ORIGINAL_USER mkdir -p "$ORIGINAL_HOME/.local"

# Clone OLS repository to ~/.local
OLS_DIR="$ORIGINAL_HOME/.local/ols"
if [ ! -d "$OLS_DIR" ]; then
    echo "→ Cloning OLS repository to ~/.local/ols..."
    sudo -u $ORIGINAL_USER git clone https://github.com/DanielGavin/ols "$OLS_DIR" 2>&1 | grep -v "^$" || true
else
    echo "→ OLS repository already exists, updating..."
    cd "$OLS_DIR"
    sudo -u $ORIGINAL_USER git pull > /dev/null 2>&1
fi

cd "$OLS_DIR"

# Build OLS
echo "→ Building OLS..."
sudo -u $ORIGINAL_USER ./build.sh > /dev/null 2>&1

# Create symlink in /usr/local/bin
echo "→ Creating symlink in /usr/local/bin..."
ln -sf "$OLS_DIR/ols" /usr/local/bin/ols

echo ""
echo "✓ OLS installed successfully!"
echo ""
echo "Installation location: $OLS_DIR"
echo "Binary symlinked to: /usr/local/bin/ols"
echo ""
echo "Usage: ols"
echo ""
echo "Configure your editor to use OLS as the language server for Odin files"
echo ""
