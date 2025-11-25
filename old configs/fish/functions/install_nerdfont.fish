function install_nerdfont --description "Download and install a Nerd Font from URL"
    # Check for required arguments
    if test (count $argv) -eq 0
        echo "Usage: install_nerdfont <font_url>"
        echo "Example: install_nerdfont https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraMono.zip"
        return 1
    end

    set -l font_url $argv[1]
    set -l font_name (basename $font_url .zip)
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
        echo "❌ Error: Neither wget nor curl found. Please install one:"
        echo "  sudo apt install wget"
        rm -rf $temp_dir
        return 1
    end

    # Check if download was successful
    if test ! -f "$temp_dir/$font_name.zip"
        echo "❌ Error: Failed to download font"
        rm -rf $temp_dir
        return 1
    end

    echo "📦 Extracting font files..."

    # Extract the font
    if command -q unzip
        unzip -q -o "$temp_dir/$font_name.zip" -d "$temp_dir/$font_name"
    else
        echo "❌ Error: unzip not found. Please install it:"
        echo "  sudo apt install unzip"
        rm -rf $temp_dir
        return 1
    end

    # Move font files to installation directory
    echo "📂 Installing to: $font_dir"

    # Find and move all font files (ttf, otf)
    set -l font_count 0
    for font_file in "$temp_dir/$font_name/"*.ttf "$temp_dir/$font_name/"*.otf "$temp_dir/$font_name/"*.TTF "$temp_dir/$font_name/"*.OTF
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
        echo "⚠️  Warning: No font files found in the archive"
        return 1
    end

    echo "✓ Installed $font_count font files"

    # Update font cache
    echo "🔄 Updating font cache..."
    if command -q fc-cache
        fc-cache -fv $font_dir >/dev/null 2>&1
        echo "✓ Font cache updated"
    else
        echo "⚠️  Warning: fontconfig not found. Font cache not updated."
        echo "  Install it with: sudo apt install fontconfig"
    end

    echo ""
    echo "✅ Nerd Font '$font_name' successfully installed!"
    echo ""
    echo "📝 To verify installation:"
    echo "  fc-list | grep -i $font_name"
    echo ""
    echo "🔄 You may need to restart your applications to use the new font."
end
