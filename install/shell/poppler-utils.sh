#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install Poppler Utils
# PDF rendering and manipulation utilities

set -e

echo "Installing Poppler Utils..."

# Update package list
echo "Updating package list..."
apt update

# Install poppler-utils
echo "Installing poppler-utils..."
apt install -y poppler-utils

echo ""
echo "✓ Poppler Utils installed successfully!"
echo ""
echo "Available tools:"
echo "  pdfinfo      # Display PDF information"
echo "  pdftotext    # Convert PDF to text"
echo "  pdftoppm     # Convert PDF to image"
echo "  pdfunite     # Merge PDF files"
echo "  pdfseparate  # Split PDF into pages"
