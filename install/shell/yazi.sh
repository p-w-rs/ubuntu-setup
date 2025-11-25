#!/bin/bash
# DEPENDS_ON: file nerdfonts ffmpeg 7zip jq poppler-utils fd ripgrep fzf zoxide resvg imagemagick xclip wl-clipboard xsel

# Install Yazi
# Blazing fast terminal file manager with full feature set

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Yazi"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        YAZI_ARCH="x86_64-unknown-linux-gnu"
        ;;
    aarch64)
        YAZI_ARCH="aarch64-unknown-linux-gnu"
        ;;
    *)
        echo "! Error: Unsupported architecture: $ARCH" >&2
        exit 1
        ;;
esac

# Get latest version from GitHub
echo "→ Fetching latest version..."
YAZI_VERSION=$(curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest | grep -Po '"tag_name": "v\K[^"]*')

if [ -z "$YAZI_VERSION" ]; then
    echo "! Error: Could not determine latest version" >&2
    exit 1
fi

echo "  Latest version: $YAZI_VERSION"
echo ""

# Download yazi
YAZI_URL="https://github.com/sxyazi/yazi/releases/download/v${YAZI_VERSION}/yazi-${YAZI_ARCH}.zip"
echo "→ Downloading yazi..."
wget -q "$YAZI_URL" -O /tmp/yazi.zip

# Extract and install
echo "→ Installing yazi..."
unzip -q -o /tmp/yazi.zip -d /tmp/
chmod +x /tmp/yazi-${YAZI_ARCH}/yazi /tmp/yazi-${YAZI_ARCH}/ya
sudo mv /tmp/yazi-${YAZI_ARCH}/yazi /usr/local/bin/
sudo mv /tmp/yazi-${YAZI_ARCH}/ya /usr/local/bin/

# Cleanup
rm -rf /tmp/yazi.zip /tmp/yazi-${YAZI_ARCH}

echo ""
echo "✓ Yazi installed successfully with full feature support!"
echo ""
echo "Usage: yazi [path]"
echo ""
echo "Key bindings:"
echo "  j/k or arrows - Navigate"
echo "  Enter         - Open file/directory"
echo "  q             - Quit"
echo "  ?             - Show help"
echo ""
echo "All features enabled with dependencies installed"
echo ""
