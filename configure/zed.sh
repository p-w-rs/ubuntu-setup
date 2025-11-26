#!/bin/bash
# DEPENDS_ON:

# Configure Zed editor
# Sets up settings with preferred font, theme, and features

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuring Zed Editor"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create zed config directory
ZED_CONFIG_DIR="$HOME/.config/zed"

echo "→ Creating Zed configuration directory..."
mkdir -p "$ZED_CONFIG_DIR"

# Create Zed settings.json file
echo "→ Creating Zed settings.json..."
cat > "$ZED_CONFIG_DIR/settings.json" << 'ZED_EOF'
{
  "base_keymap": "SublimeText",
  "icon_theme": "JetBrains New UI Icons (Dark)",
  "theme": {
    "mode": "system",
    "light": "Ayu Light",
    "dark": "Ayu Dark"
  },
  "restore_on_startup": "none",
  "collaboration_panel": { "dock": null, "button": false },
  "terminal": { "dock": null, "button": false },
  "agent": { "dock": null, "button": false, "enabled": false },

  "ui_font_family": "FiraCode Nerd Font",
  "ui_font_size": 16,
  "buffer_font_family": "FiraCode Nerd Font",
  "buffer_font_size": 15,

  "show_whitespaces": "all",
  "preferred_line_length": 120,
  "features": {
    "edit_prediction_provider": "copilot"
  },
  "edit_predictions": {
    "mode": "subtle"
  }
}
ZED_EOF

echo ""
echo "✓ Zed configured successfully!"
echo ""
echo "Configuration location: $ZED_CONFIG_DIR/settings.json"
echo ""
echo "Settings configured:"
echo "  • Base keymap: SublimeText"
echo "  • Theme: Ayu (system mode)"
echo "  • Font: FiraCode Nerd Font"
echo "  • UI font size: 16"
echo "  • Buffer font size: 15"
echo "  • Line length: 120"
echo "  • Copilot edit predictions enabled"
echo "  • Collaboration, terminal, and agent panels disabled"
echo ""
echo "Restart Zed to apply changes"
echo ""
