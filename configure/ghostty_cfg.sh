#!/bin/bash
# REQUIRES_SUDO: no
# DEPENDS_ON: ghostty nerdfonts

# Configure Ghostty terminal emulator
# Sets up optimal configuration with Nerd Fonts

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuring Ghostty Terminal"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create ghostty config directory
GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"

echo "→ Creating Ghostty configuration directory..."
mkdir -p "$GHOSTTY_CONFIG_DIR"

# Create Ghostty config file
echo "→ Creating Ghostty configuration..."
cat > "$GHOSTTY_CONFIG_DIR/config" << 'GHOSTTY_EOF'
# Ghostty Terminal Configuration

# Font Settings
font-family = FiraCode Nerd Font
font-size = 11
window-title-font-family = FiraCode Nerd Font

# Theme and Appearance
theme = Ayu
window-theme = ghostty

# Cursor Settings
cursor-style = bar
cursor-click-to-move = true

# Mouse Settings
mouse-hide-while-typing = true
mouse-shift-capture = true
focus-follows-mouse = true

# Clipboard Settings
clipboard-read = allow
clipboard-write = allow
clipboard-paste-protection = true

# Shell Integration
shell-integration = detect
shell-integration-features = cursor,sudo,title,ssh-env,ssh-terminfo
GHOSTTY_EOF

echo ""
echo "✓ Ghostty configured successfully!"
echo ""
echo "Configuration location: $GHOSTTY_CONFIG_DIR/config"
echo ""
echo "Features enabled:"
echo "  • FiraCode Nerd Font"
echo "  • Ayu theme"
echo "  • Bar cursor with click-to-move"
echo "  • Advanced clipboard management"
echo "  • Full shell integration"
echo ""
echo "Restart Ghostty to apply changes"
echo ""
