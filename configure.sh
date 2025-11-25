#!/bin/bash

# Master configuration script
# Automatically runs all scripts in the configure/ directory in dependency order
# Usage: ./configure.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGURE_DIR="$SCRIPT_DIR/configure"

echo "=== Configuration Master Script ==="
echo ""

# Check if running as regular user
if [ "$EUID" -eq 0 ]; then
    echo "Error: Do not run this script with sudo"
    echo "The script will ask for sudo when needed"
    exit 1
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

# Find all .sh scripts in configure directory
if [ ! -d "$CONFIGURE_DIR" ]; then
    echo "Warning: Configure directory not found: $CONFIGURE_DIR"
    echo "Creating directory..."
    mkdir -p "$CONFIGURE_DIR"
fi

# Get list of scripts
SCRIPTS=($(find "$CONFIGURE_DIR" -name "*.sh" -type f | sort))

if [ ${#SCRIPTS[@]} -eq 0 ]; then
    echo "No configuration scripts found in $CONFIGURE_DIR"
    exit 0
fi

echo "Found ${#SCRIPTS[@]} configuration script(s)"
echo ""

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
            echo ">>> Running: $script_name"
            if [ -n "$depends_on" ]; then
                echo "    Dependencies: $depends_on"
            fi

            # Make script executable
            chmod +x "$script"

            # Run script with or without sudo
            if [ "$requires_sudo" = "yes" ]; then
                echo "    (requires sudo)"
                sudo "$script"
            else
                echo "    (no sudo required)"
                "$script"
            fi

            echo "    ✓ Completed: $script_name"
            echo ""

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
        echo "Error: Unable to resolve dependencies for remaining scripts:"
        for script in "${SCRIPTS[@]}"; do
            script_name=$(basename "$script" .sh)
            depends_on=$(get_metadata "$script" "DEPENDS_ON")
            echo "  - $script_name (depends on: ${depends_on:-none})"
        done
        exit 1
    fi
done

if [ ${#SCRIPTS[@]} -gt 0 ]; then
    echo "Error: Maximum iterations reached. Possible circular dependency."
    exit 1
fi

echo "=== All configurations completed successfully! ==="
