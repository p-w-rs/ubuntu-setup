#!/bin/bash
# REQUIRES_SUDO: no
# DEPENDS_ON: fish fisher autopair_fish done_fish eza_fish fzf_fish zoxide_fish

# Configure Fish shell
# Sets up modular fish configuration with separate sections

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuring Fish Shell"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create fish config directory
FISH_CONFIG_DIR="$HOME/.config/fish"
FISH_CONF_D="$FISH_CONFIG_DIR/conf.d"
FISH_FUNCTIONS="$FISH_CONFIG_DIR/functions"

echo "→ Creating Fish configuration directories..."
mkdir -p "$FISH_CONFIG_DIR" "$FISH_CONF_D" "$FISH_FUNCTIONS"

# Create main config.fish file
echo "→ Creating main config.fish..."
cat > "$FISH_CONFIG_DIR/config.fish" << 'FISH_EOF'
# ~/.config/fish/config.fish
# Main Fish shell configuration
# Additional configurations are loaded from conf.d/

# Enable vi key bindings (optional - comment out if you prefer default)
# fish_vi_key_bindings
FISH_EOF

# Create path configuration
echo "→ Creating path configuration..."
cat > "$FISH_CONF_D/00-path.fish" << 'FISH_EOF'
# PATH Configuration
# Optimized order for fast command lookup

set -gx PATH \
    $HOME/.local/bin \
    /usr/local/cuda/bin \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/bin \
    /usr/sbin \
    /bin \
    /sbin \
    /usr/games \
    /usr/local/games \
    /snap/bin

# Remove duplicates from PATH
set -gx PATH (printf '%s\n' $PATH | awk '!seen[$0]++')
FISH_EOF

# Create CUDA configuration
echo "→ Creating CUDA configuration..."
cat > "$FISH_CONF_D/10-cuda.fish" << 'FISH_EOF'
# CUDA Environment Variables
# Configure CUDA paths and libraries

if test -d /usr/local/cuda
    set -gx CUDA_HOME /usr/local/cuda
    set -gx LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH
    set -gx CUDNN_PATH $CUDA_HOME
    set -gx TORCH_CUDA_ARCH_LIST 12.0
end
FISH_EOF

# Create Python/UV configuration
echo "→ Creating Python/UV configuration..."
cat > "$FISH_CONF_D/20-python.fish" << 'FISH_EOF'
# Python Configuration
# Disable cache and bytecode generation for cleaner development

set -gx PYTHONDONTWRITEBYTECODE 1  # Prevents .pyc files
set -gx PYTHONUNBUFFERED 1         # Ensures output is displayed immediately
set -gx PYTHONNODEBUGRANGES 1      # Reduces memory usage in 3.11+
set -gx PYTHONPYCACHEPREFIX /tmp   # Redirects __pycache__ to /tmp (auto-cleaned)

# UV Configuration
if type -q uv
    set -gx UV_CACHE_DIR $HOME/.cache/uv
    set -gx UV_LINK_MODE copy
    set -gx UV_NO_CACHE 0  # Set to 1 if you want to disable UV caching
end
FISH_EOF

# Create Julia configuration
echo "→ Creating Julia configuration..."
cat > "$FISH_CONF_D/30-julia.fish" << 'FISH_EOF'
# Julia Configuration
# Performance and development settings

set -gx JULIA_NUM_THREADS auto                    # Use all available cores
set -gx JULIA_EDITOR "nvim"                       # Set your preferred editor
set -gx JULIA_PKG_PRESERVE_TIERED_INSTALLED true  # Prevent accidental downgrades
set -gx JULIA_PKG_USE_CLI_GIT true               # Use system git for packages
set -gx JULIA_REVISE_POLL 0.5                    # Faster code reload with Revise.jl
set -gx JULIA_ERROR_COLOR "\033[91m"             # Red error messages
set -gx JULIA_WARN_COLOR "\033[93m"              # Yellow warnings
set -gx JULIA_INFO_COLOR "\033[36m"              # Cyan info messages

# Julia project-local Python configuration
set -gx JULIA_PYTHONCALL_EXE "@PyCall"           # Use project-local Python
set -gx JULIA_CONDAPKG_BACKEND "Null"            # Prevent global conda usage
set -gx PYTHON ""                                # Force PyCall to use Julia's Python

# Julia depot path
if test -d $HOME/.julia
    set -gx JULIA_DEPOT_PATH $HOME/.julia
end

# Julia helper functions
function jlp --description "Launch Julia with project in current directory"
    env -u LD_LIBRARY_PATH julia --project=. $argv
end

function julia --description "Launch Julia clearing library paths"
    command env -u LD_LIBRARY_PATH julia $argv
end
FISH_EOF

# Create plugin configuration
echo "→ Creating plugin configuration..."
cat > "$FISH_CONF_D/40-plugins.fish" << 'FISH_EOF'
# Plugin Configuration
# Settings for Fish plugins

# eza plugin - run on cd
set -gx eza_run_on_cd true
FISH_EOF

# Create API keys configuration (template)
echo "→ Creating API keys template..."
cat > "$FISH_CONF_D/90-api-keys.fish" << 'FISH_EOF'
# API Keys and Secrets
# !!! DO NOT COMMIT THIS FILE TO VERSION CONTROL !!!
# Add your API keys here

# Example:
# set -gx OPENAI_API_KEY "your-key-here"
# set -gx HF_TOKEN "your-token-here"
# set -gx ALPHAV_API_KEY "your-key-here"
FISH_EOF

# Create install_nerdfont function
echo "→ Creating install_nerdfont function..."
cat > "$FISH_FUNCTIONS/install_nerdfont.fish" << 'FISH_EOF'
function install_nerdfont --description "Download and install a Nerd Font from URL or name"
    # Check for required arguments
    if test (count $argv) -eq 0
        echo "Usage: install_nerdfont <font_url_or_name>"
        echo ""
        echo "Examples:"
        echo "  install_nerdfont FiraMono"
        echo "  install_nerdfont https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraMono.zip"
        return 1
    end

    set -l input $argv[1]
    set -l font_url
    set -l font_name

    # Determine if input is URL or font name
    if string match -qr '^https?://' $input
        # It's a URL
        set font_url $input
        set font_name (basename $font_url .zip)
    else
        # It's a font name, construct URL
        set font_name $input
        set -l version "v3.3.0"  # Update this to match your desired version
        set font_url "https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$font_name.zip"
    end

    set -l temp_dir (mktemp -d)
    set -l font_dir "$HOME/.local/share/fonts/NerdFonts"

    # Create font directory if it doesn't exist
    mkdir -p $font_dir

    echo "🔧 Installing Nerd Font: $font_name"
    echo "📥 Downloading from: $font_url"

    # Download the font
    if command -q wget
        wget -q --show-progress -O "$temp_dir/$font_name.zip" $font_url
    else if command -q curl
        curl -L --progress-bar -o "$temp_dir/$font_name.zip" $font_url
    else
        echo "❌ Error: Neither wget nor curl found. Please install one:" >&2
        echo "  sudo apt install wget" >&2
        rm -rf $temp_dir
        return 1
    end

    # Check if download was successful
    if test ! -f "$temp_dir/$font_name.zip"
        echo "❌ Error: Failed to download font" >&2
        rm -rf $temp_dir
        return 1
    end

    echo "📦 Extracting font files..."

    # Extract the font
    if command -q unzip
        unzip -q -o "$temp_dir/$font_name.zip" -d "$temp_dir/$font_name"
    else
        echo "❌ Error: unzip not found. Please install it:" >&2
        echo "  sudo apt install unzip" >&2
        rm -rf $temp_dir
        return 1
    end

    # Move font files to installation directory
    echo "📂 Installing to: $font_dir"

    # Find and move all font files (ttf, otf)
    set -l font_count 0
    for font_file in "$temp_dir/$font_name/"*.{ttf,otf,TTF,OTF}
        if test -f "$font_file"
            set -l basename (basename "$font_file")
            # Skip Windows compatible fonts
            if not string match -q "*Windows*" "$basename"
                cp "$font_file" "$font_dir/"
                set font_count (math $font_count + 1)
            end
        end
    end

    # Clean up temporary files
    rm -rf $temp_dir

    if test $font_count -eq 0
        echo "⚠️  Warning: No font files found in the archive" >&2
        return 1
    end

    echo "✓ Installed $font_count font files"

    # Update font cache
    echo "🔄 Updating font cache..."
    if command -q fc-cache
        fc-cache -fv $font_dir >/dev/null 2>&1
        echo "✓ Font cache updated"
    else
        echo "⚠️  Warning: fontconfig not found. Font cache not updated." >&2
        echo "  Install it with: sudo apt install fontconfig" >&2
    end

    echo ""
    echo "✅ Nerd Font '$font_name' successfully installed!"
    echo ""
    echo "📝 To verify installation:"
    echo "  fc-list | grep -i $font_name"
    echo ""
    echo "🔄 You may need to restart your applications to use the new font."
end
FISH_EOF

echo ""
echo "✓ Fish shell configured successfully!"
echo ""
echo "Configuration structure:"
echo "  Main config:      ~/.config/fish/config.fish"
echo "  Modules:          ~/.config/fish/conf.d/"
echo "    00-path.fish    - PATH configuration"
echo "    10-cuda.fish    - CUDA settings"
echo "    20-python.fish  - Python/UV settings"
echo "    30-julia.fish   - Julia settings"
echo "    40-plugins.fish - Plugin settings"
echo "    90-api-keys.fish - API keys (do not commit!)"
echo "  Functions:        ~/.config/fish/functions/"
echo "    install_nerdfont.fish - Install Nerd Fonts easily"
echo ""
echo "To set Fish as your default shell:"
echo "  chsh -s /usr/bin/fish"
echo ""
echo "Then log out and log back in for changes to take effect"
echo ""
