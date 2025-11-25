#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install jq
# Lightweight command-line JSON processor

set -e

echo "Installing jq..."

# Update package list
echo "Updating package list..."
apt update

# Install jq
echo "Installing jq..."
apt install -y jq

echo ""
echo "✓ jq installed successfully!"
echo ""
echo "Usage: jq [options] <filter> [files...]"
echo "Examples:"
echo "  echo '{\"foo\":\"bar\"}' | jq .           # Pretty print"
echo "  echo '{\"foo\":\"bar\"}' | jq .foo        # Extract field"
echo "  cat data.json | jq '.[] | .name'         # Process arrays"
