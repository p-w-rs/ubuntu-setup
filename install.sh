#!/bin/bash

# Master installation script
# Automatically runs all scripts in the install/ directory in dependency order
# Usage: ./install.sh [--nvidia --os-type TYPE --os-version VER] [--cuda-version X] [--cudnn-version Y]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$SCRIPT_DIR/install"
NVIDIA_DIR="$INSTALL_DIR/nvidia"

# Default values
INSTALL_NVIDIA=false
CUDA_VERSION="13"
CUDNN_VERSION="9"
INTERACTIVE=true
OS_TYPE=""
OS_VERSION=""

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
        --os-type)
            OS_TYPE="$2"
            shift 2
            ;;
        --os-version)
            OS_VERSION="$2"
            shift 2
            ;;
        --no-interactive)
            INTERACTIVE=false
            shift
            ;;
        *)
            echo "! Unknown option: $1" >&2
            echo "" >&2
            echo "Usage: ./install.sh [OPTIONS]" >&2
            echo "" >&2
            echo "Options:" >&2
            echo "  --nvidia              Enable NVIDIA GPU stack installation" >&2
            echo "  --os-type TYPE        OS type (ubuntu or debian) - REQUIRED with --nvidia" >&2
            echo "  --os-version VER      OS version - REQUIRED with --nvidia" >&2
            echo "                        Ubuntu: 22, 24 (or 2204, 2404)" >&2
            echo "                        Debian: 12, 13" >&2
            echo "  --cuda-version X      CUDA version (default: 13)" >&2
            echo "  --cudnn-version Y     cuDNN version (default: 9)" >&2
            echo "  --no-interactive      Skip all prompts" >&2
            echo "" >&2
            echo "Examples:" >&2
            echo "  ./install.sh" >&2
            echo "  ./install.sh --nvidia --os-type ubuntu --os-version 24" >&2
            echo "  ./install.sh --nvidia --os-type debian --os-version 12 --cuda-version 13" >&2
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
    echo "  Scripts will request sudo when needed" >&2
    exit 1
fi

# Interactive prompt for NVIDIA installation
if [ "$INTERACTIVE" = true ] && [ -d "$NVIDIA_DIR" ]; then
    echo "NVIDIA GPU stack installation available."
    echo ""
    read -p "Do you want to install NVIDIA drivers and CUDA toolkit? (y/N): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        INSTALL_NVIDIA=true

        # Prompt for OS type
        echo ""
        echo "Select your OS type:"
        echo "  1) Ubuntu"
        echo "  2) Debian"
        read -p "Enter choice (1 or 2): " os_choice

        case "$os_choice" in
            1)
                OS_TYPE="ubuntu"
                echo ""
                echo "Select Ubuntu version:"
                echo "  1) 22.04 (22)"
                echo "  2) 24.04 (24)"
                read -p "Enter choice (1 or 2): " ver_choice
                case "$ver_choice" in
                    1) OS_VERSION="22" ;;
                    2) OS_VERSION="24" ;;
                    *)
                        echo "! Invalid choice" >&2
                        exit 1
                        ;;
                esac
                ;;
            2)
                OS_TYPE="debian"
                echo ""
                echo "Select Debian version:"
                echo "  1) 12 (Bookworm)"
                echo "  2) 13 (Trixie)"
                read -p "Enter choice (1 or 2): " ver_choice
                case "$ver_choice" in
                    1) OS_VERSION="12" ;;
                    2) OS_VERSION="13" ;;
                    *)
                        echo "! Invalid choice" >&2
                        exit 1
                        ;;
                esac
                ;;
            *)
                echo "! Invalid choice" >&2
                exit 1
                ;;
        esac

        # Prompt for CUDA version
        echo ""
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

# Validate NVIDIA requirements
if [ "$INSTALL_NVIDIA" = true ]; then
    if [ -z "$OS_TYPE" ] || [ -z "$OS_VERSION" ]; then
        echo "! Error: NVIDIA installation requires --os-type and --os-version" >&2
        echo "" >&2
        echo "Examples:" >&2
        echo "  ./install.sh --nvidia --os-type ubuntu --os-version 24" >&2
        echo "  ./install.sh --nvidia --os-type debian --os-version 12" >&2
        echo "" >&2
        exit 1
    fi
fi

# Export versions and OS info for nvidia scripts to use
export NVIDIA_CUDA_VERSION="$CUDA_VERSION"
export NVIDIA_CUDNN_VERSION="$CUDNN_VERSION"
export NVIDIA_OS_TYPE="$OS_TYPE"
export NVIDIA_OS_VERSION="$OS_VERSION"

if [ "$INSTALL_NVIDIA" = true ]; then
    echo "→ NVIDIA installation enabled:"
    echo "  • OS: $OS_TYPE $OS_VERSION"
    echo "  • CUDA: $CUDA_VERSION"
    echo "  • cuDNN: $CUDNN_VERSION"
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
        depends_on=$(get_metadata "$script" "DEPENDS_ON")

        # Check if dependencies are satisfied
        if check_dependencies "$script" "$depends_on"; then
            # Make script executable
            chmod +x "$script"

            # Run script (it will handle sudo internally where needed)
            "$script"

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
