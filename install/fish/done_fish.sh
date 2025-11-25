#!/bin/bash
# DEPENDS_ON: fish fisher jq

# Install done.fish Plugin
# Automatically notifies you when long-running commands finish

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing done.fish Plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "→ Installing done plugin..."
fish -c "fisher install franciscolourenco/done" 2>&1 | grep -v "^$" || true

echo ""
echo "✓ done.fish plugin installed successfully!"
echo ""
