#!/bin/bash
# DEPENDS_ON:

# Configure Neovim as default editor
# Sets up Neovim as the default text editor for GUI file managers

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuring Neovim as Default Editor"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create applications directory
APPLICATIONS_DIR="$HOME/.local/share/applications"
echo "→ Creating applications directory..."
mkdir -p "$APPLICATIONS_DIR"

# Create nvim.desktop file
echo "→ Creating nvim.desktop file..."
cat > "$APPLICATIONS_DIR/nvim.desktop" << 'NVIM_EOF'
[Desktop Entry]
Name=Neovim
GenericName=Text Editor
Comment=Edit text files
Exec=ghostty -e nvim %F
Terminal=false
Type=Application
Keywords=Text;editor;
Icon=nvim
Categories=Utility;TextEditor;
StartupNotify=false
MimeType=text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;text/x-python;text/x-rust;text/markdown;text/x-go;text/html;text/css;text/javascript;application/json;application/xml;text/x-lua;
NVIM_EOF

# Set Neovim as default for common text types
echo "→ Setting Neovim as default for text files..."

# Main text types
xdg-mime default nvim.desktop text/plain
xdg-mime default nvim.desktop text/x-makefile
xdg-mime default nvim.desktop application/x-shellscript
xdg-mime default nvim.desktop text/markdown
xdg-mime default nvim.desktop application/json
xdg-mime default nvim.desktop application/xml

# Programming languages
xdg-mime default nvim.desktop text/x-python
xdg-mime default nvim.desktop text/x-c
xdg-mime default nvim.desktop text/x-c++
xdg-mime default nvim.desktop text/x-c++src
xdg-mime default nvim.desktop text/x-chdr
xdg-mime default nvim.desktop text/x-c++hdr
xdg-mime default nvim.desktop text/x-rust
xdg-mime default nvim.desktop text/x-go
xdg-mime default nvim.desktop text/x-java
xdg-mime default nvim.desktop text/x-lua

# Web development
xdg-mime default nvim.desktop text/html
xdg-mime default nvim.desktop text/css
xdg-mime default nvim.desktop text/javascript

# Set Neovim as system editor using update-alternatives
echo "→ Setting Neovim as system editor..."

# Register neovim if not already registered
if ! sudo update-alternatives --list editor 2>/dev/null | grep -q nvim; then
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
fi

# Set as default
sudo update-alternatives --set editor /usr/bin/nvim

# Also set for vi if desired
if ! sudo update-alternatives --list vi 2>/dev/null | grep -q nvim; then
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
fi
sudo update-alternatives --set vi /usr/bin/nvim

echo ""
echo "✓ Neovim configured as default editor successfully!"
echo ""
echo "Configuration:"
echo "  • Desktop file: $APPLICATIONS_DIR/nvim.desktop"
echo "  • Opens in Ghostty terminal"
echo "  • Set as default for text/* MIME types"
echo "  • Set as system editor via update-alternatives"
echo "  • Set as system vi via update-alternatives"
echo ""
echo "Usage:"
echo "  • Double-click text files to open in Neovim"
echo "  • Right-click text files → Open With → Neovim"
echo "  • Command line: editor <file>"
echo "  • Command line: vi <file>"
echo ""
echo "Note: You may need to log out and back in for changes to take full effect"
echo ""
