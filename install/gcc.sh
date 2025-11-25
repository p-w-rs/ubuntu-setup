#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install GCC compiler suite and build tools
# Includes: gcc, g++, gdb, gfortran, and essential build utilities

set -e

echo "Installing GCC compiler suite..."

# Update package list
echo "Updating package list..."
apt update

# Install GCC suite and build tools
echo "Installing GCC and build tools..."
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
    libtool

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
