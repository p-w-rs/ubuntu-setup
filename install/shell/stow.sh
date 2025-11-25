#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

set -e

echo "Installing Stow config manager..."

# Update package list
echo "Updating package list..."
apt update

# Install Chrome
echo "Installing Stow..."
apt install -y stow
