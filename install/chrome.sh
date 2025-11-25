#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install Google Chrome on Debian-based systems
# Adds the official Chrome repository for automatic updates via apt

set -e

echo "Installing Google Chrome..."

# Download and add Google's signing key
echo "Adding Google signing key..."
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg

# Add Chrome repository
echo "Adding Chrome repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list

# Update package list
echo "Updating package list..."
apt update

# Install Chrome
echo "Installing Chrome..."
apt install -y google-chrome-stable

echo "✓ Chrome installed successfully!"
echo "Launch with: google-chrome"
