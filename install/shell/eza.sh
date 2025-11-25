#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

set -e

echo "Installing eza smarter ls command..."

# Update package list
echo "Updating package list..."
apt update

# Install Chrome
echo "Installing eza..."
apt install -y eza
