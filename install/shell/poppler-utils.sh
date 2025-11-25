#!/bin/bash
# DEPENDS_ON:

# Install Poppler Utils
# PDF rendering and manipulation utilities

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Poppler Utils"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install poppler-utils
echo "→ Installing poppler-utils..."
sudo apt install -y poppler-utils > /dev/null 2>&1

echo ""
echo "✓ Poppler Utils installed successfully!"
echo ""
echo "Available tools:"
echo "  pdfinfo      # Display PDF information"
echo "  pdftotext    # Convert PDF to text"
echo "  pdftoppm     # Convert PDF to image"
echo "  pdfunite     # Merge PDF files"
echo "  pdfseparate  # Split PDF into pages"
echo ""
