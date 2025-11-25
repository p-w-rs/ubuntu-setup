#!/bin/bash

# Master configuration script
# Automatically runs all scripts in the configure/ directory in dependency order
# Usage: ./configure.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGURE_DIR="$SCRIPT_DIR/configure"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuration Master Script"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if running as regular user
if [ "$EUID" -eq 0 ]; then
    echo "! Error: Do not run this script with sudo" >&2
    echo "  The script will ask for sudo when needed" >&2
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
    echo "⚠  Warning: Configure directory not found: $CONFIGURE_DIR" >&2
    echo "→ Creating directory..." >&2
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

# Track stats
CONFIGURED_COUNT=0
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
            CONFIGURED_COUNT=$((CONFIGURED_COUNT + 1))

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
echo "  Configuration Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✓ Successfully configured $CONFIGURED_COUNT component(s)"
echo ""
