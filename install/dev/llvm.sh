#!/bin/bash
# DEPENDS_ON: essential

# Install LLVM compiler suite and tools
# Includes: clang, clang-format, clang-tidy, lldb, lld, libc++, and more

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing LLVM Compiler Suite"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install LLVM suite
echo "→ Installing LLVM tools..."
sudo apt install -y \
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
    llvm-runtime > /dev/null 2>&1

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
echo ""
