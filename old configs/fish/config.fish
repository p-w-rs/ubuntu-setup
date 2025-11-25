# ~/.config/fish/config.fish

# PATH Configuration with optimized order
set -gx PATH \
    $HOME/.local/bin \
    /usr/local/cuda/bin \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/bin \
    /usr/sbin \
    /bin \
    /sbin \
    /usr/games \
    /usr/local/games \
    /snap/bin

# Remove duplicates from PATH
set -gx PATH (printf '%s\n' $PATH | awk '!seen[$0]++')

# CUDA Environment Variables
set -gx CUDA_HOME /usr/local/cuda
set -gx LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH
set -gx CUDNN_PATH $CUDA_HOME

# Python Configuration - Disable cache and bytecode generation
set -gx PYTHONDONTWRITEBYTECODE 1  # Prevents .pyc files
set -gx PYTHONUNBUFFERED 1         # Ensures output is displayed immediately
set -gx PYTHONNODEBUGRANGES 1      # Reduces memory usage in 3.11+
set -gx PYTHONPYCACHEPREFIX /tmp   # Redirects __pycache__ to /tmp (auto-cleaned)
set -gx TORCH_CUDA_ARCH_LIST 12.0
# Alternative: set -gx PYTHONPYCACHEPREFIX /dev/null  # Completely discard cache

# Python/UV Configuration
if type -q uv
    # UV manages its own Python environments
    set -gx UV_CACHE_DIR $HOME/.cache/uv
    set -gx UV_LINK_MODE copy
    set -gx UV_NO_CACHE 0  # Set to 1 if you want to disable UV caching too
end

# Julia Configuration
set -gx JULIA_NUM_THREADS auto                    # Use all available cores
set -gx JULIA_EDITOR "nvim"                       # Set your preferred editor (vim, nano, code, etc.)
set -gx JULIA_PKG_PRESERVE_TIERED_INSTALLED true  # Prevent accidental package downgrades
set -gx JULIA_PKG_USE_CLI_GIT true               # Use system git for packages
set -gx JULIA_REVISE_POLL 0.5                    # Faster code reload with Revise.jl
set -gx JULIA_ERROR_COLOR "\033[91m"             # Red error messages
set -gx JULIA_WARN_COLOR "\033[93m"              # Yellow warnings
set -gx JULIA_INFO_COLOR "\033[36m"              # Cyan info messages

# Julia project-local Python configuration
set -gx JULIA_PYTHONCALL_EXE "@PyCall"           # Use project-local Python
set -gx JULIA_CONDAPKG_BACKEND "Null"            # Prevent global conda usage
set -gx PYTHON ""                                # Force PyCall to use Julia's Python

# Julia depot path (if custom location needed)
if test -d $HOME/.julia
    set -gx JULIA_DEPOT_PATH $HOME/.julia
end

function jlp --description "Launch Julia with project in current directory"
    # Pass all arguments after adding --project=.
    env -u LD_LIBRARY_PATH julia --project=. $argv
end

function julia --description "Launch Julia clearing library paths"
    # Pass all arguments after adding --project=.
    env -u LD_LIBRARY_PATH julia $argv
end

# Config Plugins
set -gx eza_run_on_cd true
set -gx HF_TOKEN ""
set -gx ALPHAV_FREE_API_KEY ""
set -gx ALPHAV_PAID_API_KEY ""


# Load completions
if status is-interactive
    # Generate completions for tools that support it

    # UV completions (if available)
    if type -q uv
        uv generate-shell-completion fish | source
    end

    # Julia completions - fish has built-in support
    # CUDA/nvcc - basic completion
    complete -c nvcc -s V -d "Display version information"
    complete -c nvcc -s h -l help -d "Display help"
    complete -c nvcc -s o -d "Output file name"
    complete -c nvcc -s c -d "Compile only"
    complete -c nvcc -s g -d "Generate debug info"
    complete -c nvcc -s O -d "Optimization level" -a "0 1 2 3"

    # Additional clang completions (fish has basic support)
    complete -c clang -s std -d "Language standard" -a "c++11 c++14 c++17 c++20 c++23 c11 c17"
end
