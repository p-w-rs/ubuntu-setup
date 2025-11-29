#!/bin/bash
# DEPENDS_ON: essential gcc

# Install Lua and LuaRocks
# Builds from source to ~/.local and symlinks to ~/.local/bin

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing Lua and LuaRocks"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Versions
LUA_VERSION="5.4.8"
LUAROCKS_VERSION="3.12.2"

# Create temporary build directory
BUILD_DIR=$(mktemp -d)
trap "rm -rf $BUILD_DIR" EXIT

# Install readline development library (needed for Lua)
echo "→ Installing readline development library..."
sudo apt update > /dev/null 2>&1
sudo apt install -y libreadline-dev > /dev/null 2>&1

# Download and build Lua
echo "→ Downloading Lua $LUA_VERSION..."
cd "$BUILD_DIR"
wget -q "https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz"

echo "→ Extracting Lua..."
tar zxf "lua-${LUA_VERSION}.tar.gz"
cd "lua-${LUA_VERSION}"

echo "→ Building Lua..."
make linux > /dev/null 2>&1

echo "→ Testing Lua build..."
make test > /dev/null 2>&1

echo "→ Installing Lua to /usr/local..."
sudo make install > /dev/null 2>&1

# Download and build LuaRocks
echo "→ Downloading LuaRocks $LUAROCKS_VERSION..."
cd "$BUILD_DIR"
wget -q "https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz"

echo "→ Extracting LuaRocks..."
tar zxf "luarocks-${LUAROCKS_VERSION}.tar.gz"
cd "luarocks-${LUAROCKS_VERSION}"

echo "→ Configuring LuaRocks..."
./configure \
    --with-lua-include=/usr/local/include \
    > /dev/null 2>&1

echo "→ Building LuaRocks..."
make > /dev/null 2>&1

echo "→ Installing LuaRocks to /usr/local..."
sudo make install > /dev/null 2>&1

echo ""
echo "✓ Lua and LuaRocks installed successfully!"
echo ""
echo "Installation location: /usr/local"
echo "Binaries: /usr/local/bin"
echo "Libraries: /usr/local/lib/lua/5.4"
echo "Lua modules: /usr/local/share/lua/5.4"
echo "Rocks tree: /usr/local/lib/luarocks"
echo ""
echo "Installed:"
echo "  • Lua $LUA_VERSION"
echo "  • LuaRocks $LUAROCKS_VERSION"
echo ""
echo "Verify installation:"
echo "  lua -v"
echo "  luarocks --version"
echo ""
echo "Install packages with:"
echo "  sudo luarocks install <package>     # System-wide"
echo "  luarocks install --local <package>  # User-local (~/.luarocks)"
echo ""
