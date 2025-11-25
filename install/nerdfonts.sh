#!/bin/bash
# REQUIRES_SUDO: no
# DEPENDS_ON: fontconfig

# Install Nerd Fonts
# Patched fonts with icons and glyphs for developers

set -e

echo "Installing Nerd Fonts..."

# Nerd Fonts version
NERD_FONTS_VERSION="v3.3.0"

# Font directory
FONT_DIR="$HOME/.local/share/fonts/NerdFonts"
mkdir -p "$FONT_DIR"

# List of popular Nerd Fonts to install
# Comment out fonts you don't want, or add more from https://github.com/ryanoasis/nerd-fonts/releases
FONTS=(
    "FiraCode"
    "JetBrainsMono"
    "Hack"
    "Meslo"
    "RobotoMono"
    "SourceCodePro"
    "UbuntuMono"
    "CascadiaCode"
    "Iosevka"
    "Mononoki"
)

echo "Downloading and installing Nerd Fonts..."
echo "This may take a few minutes..."
echo ""

# Download and install each font
for font in "${FONTS[@]}"; do
    echo "Installing $font..."

    # Download font zip
    wget -q --show-progress \
        "https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONTS_VERSION}/${font}.zip" \
        -O "/tmp/${font}.zip"

    # Extract to font directory
    unzip -q -o "/tmp/${font}.zip" -d "$FONT_DIR/${font}"

    # Clean up
    rm "/tmp/${font}.zip"

    echo "  ✓ $font installed"
done

# Update font cache
echo ""
echo "Updating font cache..."
fc-cache -fv "$FONT_DIR" > /dev/null 2>&1

echo ""
echo "✓ Nerd Fonts installed successfully!"
echo ""
echo "Installed fonts:"
for font in "${FONTS[@]}"; do
    echo "  • $font Nerd Font"
done
echo ""
echo "Font location: $FONT_DIR"
echo ""
echo "Restart your terminal or applications to use the new fonts"
echo ""
echo "To install additional fonts, visit:"
echo "  https://github.com/ryanoasis/nerd-fonts/releases"
