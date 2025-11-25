#!/bin/bash

# Master installation script
# Automatically runs all scripts in the install/ directory in dependency order
# Usage: ./install.sh [--nvidia] [--cuda-version X] [--cudnn-version Y]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$SCRIPT_DIR/install"
NVIDIA_DIR="$INSTALL_DIR/nvidia"

# Default values
INSTALL_NVIDIA=false
CUDA_VERSION="13"
CUDNN_VERSION="9"
INTERACTIVE=true

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --nvidia)
            INSTALL_NVIDIA=true
            INTERACTIVE=false
            shift
            ;;
        --cuda-version)
            CUDA_VERSION="$2"
            shift 2
            ;;
        --cudnn-version)
            CUDNN_VERSION="$2"
            shift 2
            ;;
        --no-interactive)
            INTERACTIVE=false
            shift
            ;;
        *)
            echo "! Unknown option: $1" >&2
            echo "Usage: ./install.sh [--nvidia] [--cuda-version X] [--cudnn-version Y] [--no-interactive]"
            exit 1
            ;;
    esac
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installation Master Script"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if running as regular user
if [ "$EUID" -eq 0 ]; then
    echo "! Error: Do not run this script with sudo" >&2
    echo "  The script will ask for sudo when needed" >&2
    exit 1
fi

# Interactive prompt for NVIDIA installation
if [ "$INTERACTIVE" = true ] && [ -d "$NVIDIA_DIR" ]; then
    echo "NVIDIA GPU stack installation available."
    read -p "Do you want to install NVIDIA drivers and CUDA toolkit? (y/N): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        INSTALL_NVIDIA=true

        # Prompt for CUDA version
        read -p "CUDA version to install [default: 13]: " cuda_input
        if [ -n "$cuda_input" ]; then
            CUDA_VERSION="$cuda_input"
        fi

        # Prompt for cuDNN version
        read -p "cuDNN version to install [default: 9]: " cudnn_input
        if [ -n "$cudnn_input" ]; then
            CUDNN_VERSION="$cudnn_input"
        fi
    fi
    echo ""
fi

# Export versions for nvidia scripts to use
export NVIDIA_CUDA_VERSION="$CUDA_VERSION"
export NVIDIA_CUDNN_VERSION="$CUDNN_VERSION"

if [ "$INSTALL_NVIDIA" = true ]; then
    echo "→ NVIDIA installation enabled with CUDA $CUDA_VERSION and cuDNN $CUDNN_VERSION"
    echo ""
fi

# Function to extract metadata from script
get_metadata() {
    local script="$1"
    local key="$2"
    grep "^# $key:" "$script" | head -1 | cut -d: -f2- | xargs
}

# Function to check if all dependencies are satisfied
check_dependencies() {
    local script="$1"
    local deps="$2"

    if [ -z "$deps" ]; then
        return 0
    fi

    for dep in $deps; do
        if ! grep -q "^${dep}$" "$COMPLETED_FILE" 2>/dev/null; then
            return 1
        fi
    done
    return 0
}

# Create temp file to track completed scripts
COMPLETED_FILE=$(mktemp)
trap "rm -f $COMPLETED_FILE" EXIT

# Find all .sh scripts in install directory
if [ ! -d "$INSTALL_DIR" ]; then
    echo "! Error: Install directory not found: $INSTALL_DIR" >&2
    exit 1
fi

# Get list of scripts, excluding nvidia directory if NVIDIA installation is disabled
SCRIPTS=()
while IFS= read -r script; do
    # Skip scripts in nvidia directory if NVIDIA installation is disabled
    if [[ "$script" == *"/nvidia/"* ]] && [ "$INSTALL_NVIDIA" = false ]; then
        continue
    fi
    SCRIPTS+=("$script")
done < <(find "$INSTALL_DIR" -name "*.sh" -type f | sort)

if [ ${#SCRIPTS[@]} -eq 0 ]; then
    echo "No installation scripts found in $INSTALL_DIR"
    exit 0
fi

echo "Found ${#SCRIPTS[@]} installation script(s)"
echo ""

# Track stats
INSTALLED_COUNT=0
TOTAL_COUNT=${#SCRIPTS[@]}

# Process scripts in dependency order
MAX_ITERATIONS=100
iteration=0

while [ ${#SCRIPTS[@]} -gt 0 ] && [ $iteration -lt $MAX_ITERATIONS ]; do
    iteration=$((iteration + 1))
    made_progress=false

    # Try to find a script whose dependencies are all satisfied
    for i in "${!SCRIPTS[@]}"; do
        script="${SCRIPTS[$i]}"
        script_name=$(basename "$script" .sh)

        # Get metadata
        requires_sudo=$(get_metadata "$script" "REQUIRES_SUDO")
        depends_on=$(get_metadata "$script" "DEPENDS_ON")

        # Check if dependencies are satisfied
        if check_dependencies "$script" "$depends_on"; then
            # Make script executable
            chmod +x "$script"

            # Run script with or without sudo
            if [ "$requires_sudo" = "yes" ]; then
                sudo "$script"
            else
                "$script"
            fi

            # Increment counter
            INSTALLED_COUNT=$((INSTALLED_COUNT + 1))

            # Mark as completed
            echo "$script_name" >> "$COMPLETED_FILE"

            # Remove from array
            unset 'SCRIPTS[$i]'
            SCRIPTS=("${SCRIPTS[@]}")

            made_progress=true
            break
        fi
    done

    # If we didn't make progress, we have a circular dependency or missing dependency
    if [ "$made_progress" = false ]; then
        echo ""
        echo "! Error: Unable to resolve dependencies for remaining scripts:" >&2
        for script in "${SCRIPTS[@]}"; do
            script_name=$(basename "$script" .sh)
            depends_on=$(get_metadata "$script" "DEPENDS_ON")
            echo "  - $script_name (depends on: ${depends_on:-none})" >&2
        done
        exit 1
    fi
done

if [ ${#SCRIPTS[@]} -gt 0 ]; then
    echo "! Error: Maximum iterations reached. Possible circular dependency." >&2
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installation Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✓ Successfully installed $INSTALLED_COUNT component(s)"
echo ""
if [ "$INSTALL_NVIDIA" = true ]; then
    echo "⚠  IMPORTANT: Reboot your system to activate NVIDIA drivers"
    echo ""
fi
