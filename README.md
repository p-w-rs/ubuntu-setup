# Debian Setup Scripts

Automated installation and configuration system for Debian-based distributions.

## Structure

```
~/debian-setup/
├── setup.sh           # Main entry point
├── install.sh         # Master installation script
├── configure.sh       # Master configuration script
├── install/           # Individual installation scripts
│   ├── *.sh          # Individual application install scripts
│   ├── nvidia/       # NVIDIA GPU stack (optional subfolder)
│   │   └── *.sh
│   ├── fish/         # Fish shell and tools (subfolder)
│   │   └── *.sh
│   └── ...           # Other subfolders as needed
└── configure/         # Individual configuration scripts
    └── *.sh          # Individual configuration scripts
```

## Usage

### Interactive Mode (Recommended)

Run the complete setup with interactive prompts:

```bash
cd ~/debian-setup
./setup.sh
```

You'll be prompted whether to install NVIDIA drivers and CUDA toolkit. If you choose yes, you'll be asked for:

- CUDA version (default: 13)
- cuDNN version (default: 9)

### Non-Interactive Mode

Run with command-line arguments:

```bash
# Install everything including NVIDIA with default versions
./setup.sh --nvidia

# Install with specific CUDA and cuDNN versions
./setup.sh --nvidia --cuda-version 12 --cudnn-version 8

# Install without NVIDIA
./setup.sh --no-interactive
```

### Install or Configure Separately

```bash
# Run installations only (with NVIDIA prompts)
./install.sh

# Run installations with NVIDIA and specific versions
./install.sh --nvidia --cuda-version 13 --cudnn-version 9

# Run configurations only
./configure.sh
```

## Script Metadata

Every script must include these headers:

```bash
#!/bin/bash
# REQUIRES_SUDO: yes|no
# DEPENDS_ON: script1 script2 script3
```

### Metadata Fields

- **REQUIRES_SUDO**: Whether the script needs root privileges
  - `yes` - Script will be run with `sudo`
  - `no` - Script runs as regular user

- **DEPENDS_ON**: Space-separated list of script names (without .sh)
  - Example: `gcc llvm` means this script requires gcc.sh and llvm.sh to run first
  - Leave empty if no dependencies

## How It Works

1. **Dependency Resolution**: The master scripts automatically resolve dependencies and run scripts in the correct order
2. **Circular Dependency Detection**: Scripts with circular dependencies will cause an error
3. **Missing Dependency Detection**: Scripts with unsatisfied dependencies will be reported
4. **Automatic sudo Handling**: Scripts are run with or without sudo based on their metadata

## Adding New Scripts

1. Create a new `.sh` file in `install/` or `configure/`
2. Add the required metadata headers
3. Write your installation/configuration logic
4. The script will be automatically discovered and run in the correct order

### Example: New Install Script

```bash
#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: gcc llvm

# Install my-package
set -e

echo "Installing my-package..."
apt install -y my-package

echo "✓ my-package installed!"
```

## NVIDIA GPU Stack (Optional)

The NVIDIA stack is **optional** and located in `install/nvidia/`. These scripts are only installed if you choose to enable them.

### Installation Options

**Interactive:** When you run `./setup.sh` or `./install.sh`, you'll be prompted:

```
NVIDIA GPU stack installation available.
Do you want to install NVIDIA drivers and CUDA toolkit? (y/N):
```

**Non-interactive:** Use command-line flags:

```bash
./setup.sh --nvidia --cuda-version 13 --cudnn-version 9
```

### Dependency Chain

```
nvidia-driver (base)
    ↓
cuda (depends on: nvidia-driver, gcc)
    ↓
├── cublas (depends on: cuda)
├── cufft (depends on: cuda)
├── cusparse (depends on: cuda)
├── cusolver (depends on: cuda)
    ↓
cudnn (depends on: cuda)
    ↓
tensorrt (depends on: cudnn)
```

### Available NVIDIA Scripts

- **nvidia-driver.sh** - NVIDIA GPU drivers (includes RTX 5090 Blackwell support)
- **cuda.sh** - CUDA Toolkit (compiler, runtime, libraries)
- **cublas.sh** - Basic Linear Algebra Subroutines
- **cufft.sh** - Fast Fourier Transform library
- **cusparse.sh** - Sparse matrix operations
- **cusolver.sh** - Linear algebra solvers
- **cudnn.sh** - Deep Neural Network library
- **tensorrt.sh** - Deep learning inference optimizer

### Version Configuration

Versions are specified at runtime:

- **CUDA version**: Defaults to 13, specify with `--cuda-version`
- **cuDNN version**: Defaults to 9, specify with `--cudnn-version`

The scripts automatically use these versions through environment variables.

### Important Notes

⚠️ **After installing NVIDIA drivers, reboot your system** before the drivers take effect.

After reboot, verify with:

```bash
nvidia-smi  # Check driver installation
nvcc --version  # Check CUDA installation
```

### Updating Versions

To install different versions in the future, simply run:

```bash
./install.sh --nvidia --cuda-version 14 --cudnn-version 10
```

No need to edit any script files!

## Benefits

✅ **Automatic Dependency Management**: No need to manually order scripts
✅ **Reusable**: Add new scripts without modifying the master scripts
✅ **Safe**: Checks for circular dependencies and missing requirements
✅ **Clear**: Each script declares its own requirements
✅ **Idempotent**: Safe to run multiple times

## Important Notes

- Always run `setup.sh` as a **regular user**, not with sudo
- Scripts will request sudo when needed
- Works on any Debian-based distribution (Debian, Ubuntu, Linux Mint, etc.)
- Script names (without .sh) are used for dependency tracking
