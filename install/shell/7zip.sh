# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install 7-Zip
# High compression file archiver

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing 7-Zip"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install 7zip
echo "→ Installing 7zip..."
apt install -y p7zip-full p7zip-rar > /dev/null 2>&1

echo ""
echo "✓ 7-Zip installed successfully!"
echo ""
echo "Usage: 7z [command] [options] [archive] [files...]"
echo "Common commands:"
echo "  7z a archive.7z files/    # Create archive"
echo "  7z x archive.7z           # Extract archive"
echo "  7z l archive.7z           # List contents"
echo ""
