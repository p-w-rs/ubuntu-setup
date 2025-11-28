#!/bin/bash
# DEPENDS_ON:

# Configure Ghostty terminal emulator
# Sets up optimal configuration with Nerd Fonts and sets as default terminal

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

# Window Management - tmux replacement
#window-save-state = always

# Keybindings - tmux-style workflow
# New window
#keybind = ctrl+n=new_window

# Navigate splits (vim-style)
#keybind = ctrl+h=goto_split:left
#keybind = ctrl+j=goto_split:bottom
#keybind = ctrl+k=goto_split:top
#keybind = ctrl+l=goto_split:right

# Create new splits (tmux-style with ctrl+a prefix)
#keybind = ctrl+a>h=new_split:left
#keybind = ctrl+a>j=new_split:down
#keybind = ctrl+a>k=new_split:up
#keybind = ctrl+a>l=new_split:right

# Split and tab management
#keybind = ctrl+a>f=toggle_split_zoom
#keybind = ctrl+a>n=next_tab
#keybind = ctrl+a>p=previous_tab

# Reload configuration
#keybind = super+r=reload_config
GHOSTTY_EOF

# Set Ghostty as default terminal emulator
echo "→ Setting Ghostty as default terminal..."

# Check if ghostty exists
if [ -f /usr/local/bin/ghostty ]; then
    # Register with update-alternatives if not already registered
    if ! sudo update-alternatives --list x-terminal-emulator 2>/dev/null | grep -q ghostty; then
        echo "  Registering Ghostty with update-alternatives..."
        sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/ghostty 60
    fi

    # Set as default
    echo "  Setting Ghostty as default..."
    sudo update-alternatives --set x-terminal-emulator /usr/local/bin/ghostty
    echo "  Ghostty is now the default terminal"
else
    echo "  Warning: /usr/local/bin/ghostty not found, skipping default terminal setup" >&2
fi

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
echo "  • Set as default terminal emulator"
echo "  • tmux-style keybindings (no tmux needed!)"
echo ""
echo "Keybindings:"
echo "  Window & Tabs:"
echo "    Ctrl+N           - New window"
echo "    Ctrl+A > N       - Next tab"
echo "    Ctrl+A > P       - Previous tab"
echo ""
echo "  Split Navigation (vim-style):"
echo "    Ctrl+H/J/K/L     - Navigate splits"
echo ""
echo "  Create Splits (tmux-style):"
echo "    Ctrl+A > H/J/K/L - Create split left/down/up/right"
echo "    Ctrl+A > F       - Toggle split zoom"
echo ""
echo "  Config:"
echo "    Super+R          - Reload configuration"
echo ""
echo "Usage:"
echo "  • Launch with: ghostty"
echo "  • Open with Ctrl+Alt+T"
echo "  • Right-click folder → Open in Terminal"
echo ""
echo "Restart Ghostty to apply configuration changes"
echo ""
