#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

set -e

echo "Installing bat smarter cat command..."

# Update package list
echo "Updating package list..."
apt update

# Install Chrome
echo "Installing bat..."
apt install -y bat

echo "To use as bat make sure you smylink"
echo "mkdir -p ~/.local/bin"
echo "ln -s /usr/bin/batcat ~/.local/bin/bat"
