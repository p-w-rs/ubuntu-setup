#!/bin/bash
# DEPENDS_ON: essential fzf

# Install zoxide
# Smarter cd command that learns your habits

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing zoxide"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Install using the official installation script
echo "→ Downloading and installing zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo ""
echo "✓ zoxide installed successfully!"
echo ""
echo "To enable zoxide, add this to your shell config:"
echo ""
echo "For bash (~/.bashrc):"
echo "  eval \"\$(zoxide init bash)\""
echo ""
echo "For fish (~/.config/fish/config.fish):"
echo "  zoxide init fish | source"
echo ""
echo "For zsh (~/.zshrc):"
echo "  eval \"\$(zoxide init zsh)\""
echo ""
echo "Usage: z [directory]"
echo "Examples:"
echo "  z documents    # Jump to most frecent match"
echo "  zi documents   # Interactive selection with fzf"
echo ""
