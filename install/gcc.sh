#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: essential

# Install GCC compiler suite and build tools
# Includes: gcc, g++, gdb, gfortran, and essential build utilities

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing GCC Compiler Suite"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
apt update > /dev/null 2>&1

# Install GCC suite and build tools
echo "→ Installing GCC and build tools..."
apt install -y \
    build-essential \
    gcc \
    g++ \
    gfortran \
    gdb \
    make \
    cmake \
    autoconf \
    automake \
    libtool > /dev/null 2>&1

echo ""
echo "✓ GCC suite installed successfully!"
echo ""
echo "Installed components:"
echo "  • gcc (C compiler)"
echo "  • g++ (C++ compiler)"
echo "  • gfortran (Fortran compiler)"
echo "  • gdb (debugger)"
echo "  • make, cmake (build tools)"
echo "  • build-essential (compilation essentials)"
echo ""
echo "Verify installation: gcc --version"
echo ""
