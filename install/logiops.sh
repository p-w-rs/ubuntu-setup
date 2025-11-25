# REQUIRES_SUDO: yes
# DEPENDS_ON: llvm gcc

# Install logiops - driver for Logitech mice and keyboards
# Requires LLVM and GCC to be installed first

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing logiops"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Install build dependencies
echo "→ Installing dependencies..."
apt install -y \
    pkg-config \
    libevdev-dev \
    libudev-dev \
    libconfig++-dev \
    libglib2.0-dev > /dev/null 2>&1

# Clone logiops repository
TEMP_DIR=$(mktemp -d)
echo "→ Cloning logiops repository..."
cd "$TEMP_DIR"
git clone https://github.com/PixlOne/logiops.git 2>&1 | grep -v "^$" || true
cd logiops

# Build logiops
echo "→ Building logiops..."
mkdir build
cd build
cmake .. > /dev/null 2>&1
make > /dev/null 2>&1

# Install
echo "→ Installing logiops..."
make install > /dev/null 2>&1

# Clean up
cd /
rm -rf "$TEMP_DIR"

echo ""
echo "✓ logiops installed successfully!"
echo ""
echo "Configure logiops by creating /etc/logid.cfg"
echo "Enable service with: sudo systemctl enable --now logid"
echo ""
