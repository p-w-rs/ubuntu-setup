#!/bin/bash
# DEPENDS_ON: julia

# Configure Julia
# Sets up startup configuration

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuring Julia"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create Julia config directory
JULIA_CONFIG_DIR="$HOME/.julia/config"

echo "→ Creating Julia configuration directory..."
mkdir -p "$JULIA_CONFIG_DIR"

# Create startup.jl file for REPL customization
echo "→ Creating startup.jl..."
cat > "$JULIA_CONFIG_DIR/startup.jl" << 'JULIA_EOF'
# Julia Startup Configuration
# This file runs automatically when Julia REPL starts

# Uncomment to automatically activate the current directory's project
# if isfile("Project.toml") || isfile("JuliaProject.toml")
#     using Pkg
#     Pkg.activate(".")
# end

# Uncomment to load Revise.jl automatically (install first with: using Pkg; Pkg.add("Revise"))
# try
#     using Revise
# catch e
#     @warn "Revise not loaded" exception=(e, catch_backtrace())
# end

# Custom prompt (optional)
# using REPL
# REPL.Terminals.raw!(Base.stdin.buffer, false)

println("Julia $(VERSION) - Welcome!")
JULIA_EOF

echo ""
echo "✓ Julia configured successfully!"
echo ""
echo "Configuration location: $JULIA_CONFIG_DIR/startup.jl"
echo ""
echo "Recommended packages to install:"
echo "  julia> using Pkg"
echo "  julia> Pkg.add(\"Revise\")       # Auto-reload code changes"
echo "  julia> Pkg.add(\"OhMyREPL\")     # Enhanced REPL experience"
echo "  julia> Pkg.add(\"BenchmarkTools\") # Performance testing"
echo ""
echo "Julia environment variables are configured in Fish shell"
echo "Run 'julia' or 'jlp' (for project mode) to start"
echo ""
