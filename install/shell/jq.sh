#!/bin/bash
# DEPENDS_ON:

# Install jq
# Lightweight command-line JSON processor

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing jq"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install jq
echo "→ Installing jq..."
sudo apt install -y jq > /dev/null 2>&1

echo ""
echo "✓ jq installed successfully!"
echo ""
echo "Usage: jq [options] <filter> [files...]"
echo "Examples:"
echo "  echo '{\"foo\":\"bar\"}' | jq .           # Pretty print"
echo "  echo '{\"foo\":\"bar\"}' | jq .foo        # Extract field"
echo "  cat data.json | jq '.[] | .name'         # Process arrays"
echo ""
