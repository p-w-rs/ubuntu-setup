#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON:

# Install LLVM compiler suite and tools
# Includes: clang, clang-format, clang-tidy, lldb, lld, libc++, and more

set -e

echo "Installing LLVM compiler suite..."

# Update package list
echo "Updating package list..."
apt update

# Install LLVM suite
echo "Installing LLVM tools..."
apt install -y \
    clang \
    clang-format \
    clang-tidy \
    clangd \
    lldb \
    lld \
    libc++-dev \
    libc++abi-dev \
    libclang-dev \
    llvm \
    llvm-dev \
    llvm-config \
    llvm-runtime

echo ""
echo "✓ LLVM suite installed successfully!"
echo ""
echo "Installed components:"
echo "  • clang (C/C++ compiler)"
echo "  • clang-format (code formatter)"
echo "  • clang-tidy (static analyzer)"
echo "  • clangd (language server)"
echo "  • lldb (debugger)"
echo "  • lld (linker)"
echo "  • libc++ (C++ standard library)"
echo ""
echo "Verify installation: clang --version"
