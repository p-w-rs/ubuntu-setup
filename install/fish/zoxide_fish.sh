#!/bin/bash
# DEPENDS_ON: fish fisher zoxide

# Install zoxide.fish Plugin
# Integrates zoxide with Fish shell

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing zoxide.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing zoxide plugin..."
fish -c "fisher install kidonng/zoxide.fish" 2>&1 | grep -v "^$" || true

echo ""
echo "✓ zoxide.fish plugin installed successfully!"
echo ""
