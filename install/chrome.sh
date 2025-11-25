#!/bin/bash
# DEPENDS_ON: essential

# Install Google Chrome on Debian-based systems
# Adds the official Chrome repository for automatic updates via apt

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Google Chrome"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Download and add Google's signing key
echo "→ Adding Google signing key..."
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg > /dev/null

# Add Chrome repository
echo "→ Adding Chrome repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install Chrome
echo "→ Installing Chrome..."
sudo apt install -y google-chrome-stable > /dev/null 2>&1

echo ""
echo "✓ Chrome installed successfully!"
echo ""
echo "Launch with: google-chrome"
echo ""
