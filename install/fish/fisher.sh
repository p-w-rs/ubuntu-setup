#!/bin/bash
# DEPENDS_ON: fish

# Install Fisher - Fish shell plugin manager
# Allows easy installation and management of Fish plugins

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Fisher Plugin Manager"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Install Fisher using the official installation method
echo "→ Installing Fisher..."
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher" 2>&1 | grep -v "^$" || true

echo ""
echo "✓ Fisher installed successfully!"
echo ""
echo "Usage examples:"
echo "  fisher install jethrokuan/z        # Install a plugin"
echo "  fisher list                        # List installed plugins"
echo "  fisher update                      # Update all plugins"
echo "  fisher remove jethrokuan/z         # Remove a plugin"
echo ""
echo "Browse plugins at: https://github.com/jorgebucaran/awsm.fish"
echo ""
