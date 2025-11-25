#!/bin/bash
# DEPENDS_ON: uv

# Configure UV Python package manager
# Sets up optimal defaults

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuring UV Python Manager"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create UV config directory
UV_CONFIG_DIR="$HOME/.config/uv"

echo "→ Creating UV configuration directory..."
mkdir -p "$UV_CONFIG_DIR"

# Create UV config file
echo "→ Creating UV configuration..."
cat > "$UV_CONFIG_DIR/uv.toml" << 'UV_EOF'
# UV Configuration
# Modern Python package and project manager settings

[pip]
# Use system certificates
system-certs = true

# Show more detailed progress
progress = true

# Prefer binary wheels
prefer-binary = true

[tool.uv]
# Cache directory (can be changed if needed)
# cache-dir = "~/.cache/uv"

# Link mode for installing packages
# Options: "copy", "symlink", "hardlink"
link-mode = "copy"

# Python discovery
# python-preference = "system"

# Compile Python files
# compile-bytecode = false
UV_EOF

echo ""
echo "✓ UV configured successfully!"
echo ""
echo "Configuration location: $UV_CONFIG_DIR/uv.toml"
echo ""
echo "Quick start:"
echo "  uv init myproject          # Create new project"
echo "  cd myproject"
echo "  uv add numpy pandas        # Add dependencies"
echo "  uv run python script.py    # Run script in virtual env"
echo ""
echo "Common commands:"
echo "  uv venv                    # Create virtual environment"
echo "  uv pip install package     # Install package"
echo "  uv pip list                # List installed packages"
echo "  uv sync                    # Sync project dependencies"
echo ""
echo "UV environment variables are configured in Fish shell"
echo ""
