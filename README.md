# Debian/Ubuntu Setup Scripts

Automated installation and configuration system for Debian-based distributions (Debian, Ubuntu, Devuan).

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

### Basic Installation (No NVIDIA)

```bash
cd ~/debian-setup
./setup.sh
```

### NVIDIA Installation (OS Must Be Specified)

**⚠️ IMPORTANT**: NVIDIA installation requires explicit OS specification. No auto-detection.

```bash
# Ubuntu 24.04
./setup.sh --nvidia --os-type ubuntu --os-version 24

# Ubuntu 22.04
./setup.sh --nvidia --os-type ubuntu --os-version 22

# Debian 12
./setup.sh --nvidia --os-type debian --os-version 12

# Debian 13
./setup.sh --nvidia --os-type debian --os-version 13
```

### Interactive Mode

Run with prompts for NVIDIA configuration:

```bash
./setup.sh
```

You'll be prompted for:
1. Whether to install NVIDIA
2. OS type (Ubuntu or Debian)
3. OS version (22/24 for Ubuntu, 12/13 for Debian)
4. CUDA version (default: 13)
5. cuDNN version (default: 9)

### Custom CUDA/cuDNN Versions

```bash
./setup.sh --nvidia \
  --os-type ubuntu \
  --os-version 24 \
  --cuda-version 12 \
  --cudnn-version 8
```

### Non-Interactive Mode

```bash
./setup.sh --nvidia --os-type debian --os-version 12 --no-interactive
```

### Install or Configure Separately

```bash
# Run installations only
./install.sh --nvidia --os-type ubuntu --os-version 24

# Run configurations only
./configure.sh
```

## Supported Systems

### Ubuntu
- **22.04** (Jammy Jellyfish)
- **24.04** (Noble Numbat)

### Debian
- **12** (Bookworm)
- **13** (Trixie)

### Architecture
- **x86_64 (amd64)** only

## Script Metadata

Every script must include this header:

```bash
#!/bin/bash
# DEPENDS_ON: script1 script2 script3
```

### Metadata Fields

- **DEPENDS_ON**: Space-separated list of script names (without .sh)
  - Example: `gcc llvm` means this script requires gcc.sh and llvm.sh to run first
  - Leave empty if no dependencies

### Handling sudo

Scripts handle sudo internally where needed. Each script should:
- Use `sudo` on individual commands that require root privileges
- Run as regular user for commands that don't need elevated privileges
- Be executable by regular users (don't run the whole script with sudo)

## How It Works

1. **Dependency Resolution**: The master scripts automatically resolve dependencies and run scripts in the correct order
2. **Circular Dependency Detection**: Scripts with circular dependencies will cause an error
3. **Missing Dependency Detection**: Scripts with unsatisfied dependencies will be reported
4. **Automatic sudo Handling**: Scripts use sudo internally for commands that require it
5. **Explicit OS Configuration**: NVIDIA components require explicit OS specification

## Adding New Scripts

1. Create a new `.sh` file in `install/` or `configure/`
2. Add the required metadata header (shebang and DEPENDS_ON)
3. Write your installation/configuration logic with sudo on commands that need it
4. The script will be automatically discovered and run in the correct order

### Example: New Install Script

```bash
#!/bin/bash
# DEPENDS_ON: gcc llvm

# Install my-package
set -e

echo "Installing my-package..."
sudo apt update > /dev/null 2>&1
sudo apt install -y my-package > /dev/null 2>&1

echo "✓ my-package installed!"
```

## NVIDIA GPU Stack (Optional)

The NVIDIA stack is **optional** and located in `install/nvidia/`.

### ⚠️ Important: OS Must Be Specified

Unlike the base installation, **NVIDIA installation does not auto-detect your OS**. You must explicitly specify:
- OS type: `ubuntu` or `debian`
- OS version: `22`, `24` for Ubuntu; `12`, `13` for Debian

This ensures the correct CUDA repository is used for your specific system.

### Installation Examples

```bash
# Ubuntu 24.04
./install.sh --nvidia --os-type ubuntu --os-version 24

# Ubuntu 22.04
./install.sh --nvidia --os-type ubuntu --os-version 22

# Debian 12
./install.sh --nvidia --os-type debian --os-version 12

# Debian 13
./install.sh --nvidia --os-type debian --os-version 13

# With custom CUDA/cuDNN
./install.sh --nvidia \
  --os-type ubuntu \
  --os-version 24 \
  --cuda-version 12 \
  --cudnn-version 8
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
- **tensorrt.sh** - Deep learning inference optimizer (C/C++ libraries only, no Python bindings)

### TensorRT: C/C++ Only

The TensorRT installation installs **only C/C++ libraries**, not Python bindings:

**Installed libraries:**
- `libnvinfer-dev` - Core TensorRT runtime
- `libnvinfer-plugin-dev` - Plugin library
- `libnvparsers-dev` - Caffe parser
- `libnvonnxparsers-dev` - ONNX parser

**Not installed:**
- `python3-libnvinfer` - Not installed
- Python wheel packages - Not installed

**Compile example:**
```bash
g++ -o app app.cpp \
  -lnvinfer \
  -lnvonnxparser \
  -L/usr/lib/x86_64-linux-gnu \
  -I/usr/include/x86_64-linux-gnu
```

### Version Configuration

Versions are specified at runtime:

- **CUDA version**: Defaults to 13, specify with `--cuda-version`
- **cuDNN version**: Defaults to 9, specify with `--cudnn-version`
- **OS type**: **REQUIRED**, specify with `--os-type ubuntu` or `--os-type debian`
- **OS version**: **REQUIRED**, specify with `--os-version 22|24|12|13`

The scripts use these environment variables:
- `NVIDIA_CUDA_VERSION`
- `NVIDIA_CUDNN_VERSION`
- `NVIDIA_OS_TYPE`
- `NVIDIA_OS_VERSION`

### Important Notes

⚠️ **After installing NVIDIA drivers, reboot your system** before the drivers take effect.

After reboot, verify with:

```bash
nvidia-smi  # Check driver installation
nvcc --version  # Check CUDA installation
```

### Why No Auto-Detection for NVIDIA?

NVIDIA CUDA repositories are very specific to OS type and version. Explicitly specifying ensures:
1. ✅ Correct repository is always used
2. ✅ No ambiguity in multi-boot or container scenarios
3. ✅ Clear documentation of target system
4. ✅ Prevents wrong repository causing installation failures

## System Maintenance

The `essential.sh` script includes:
- Package list updates
- Broken package fixes
- Full system upgrade

This ensures your system is up-to-date before installing any software.

## Benefits

✅ **Automatic Dependency Management**: No need to manually order scripts  
✅ **Reusable**: Add new scripts without modifying the master scripts  
✅ **Safe**: Checks for circular dependencies and missing requirements  
✅ **Clear**: Each script declares its own requirements  
✅ **Idempotent**: Safe to run multiple times  
✅ **Flexible sudo**: Scripts handle sudo at the command level, not script level  
✅ **Explicit Configuration**: NVIDIA requires explicit OS specification for reliability  
✅ **C/C++ Focus**: TensorRT installs development libraries without Python overhead  

## Important Notes

- Always run `setup.sh` as a **regular user**, not with sudo
- Scripts will request sudo when needed for individual commands
- Script names (without .sh) are used for dependency tracking
- **NVIDIA installation requires explicit OS specification** - no auto-detection

## Command Reference

### Basic Commands

```bash
# Install everything (no NVIDIA)
./setup.sh

# Install with NVIDIA (Ubuntu 24.04)
./setup.sh --nvidia --os-type ubuntu --os-version 24

# Install with NVIDIA (Debian 12)
./setup.sh --nvidia --os-type debian --os-version 12

# Install only (no configuration)
./install.sh --nvidia --os-type ubuntu --os-version 24

# Configure only
./configure.sh
```

### Version Overrides

```bash
# Custom CUDA/cuDNN versions
./setup.sh --nvidia \
  --os-type ubuntu \
  --os-version 24 \
  --cuda-version 12 \
  --cudnn-version 8
```

## Troubleshooting

### Missing OS Parameters

If you see:
```
! Error: NVIDIA installation requires --os-type and --os-version
```

Add the required parameters:
```bash
./install.sh --nvidia --os-type ubuntu --os-version 24
```

### Invalid OS Version

If you see:
```
! Error: Invalid Ubuntu version: 20
```

Use a supported version:
- Ubuntu: 22, 24
- Debian: 12, 13

### Wrong Repository Used

If NVIDIA installation fails, verify:
```bash
# Check your actual OS
cat /etc/os-release

# Use the correct OS specification
./install.sh --nvidia --os-type ubuntu --os-version 24
```

### General Issues

```bash
# Fix broken packages
sudo apt --fix-broken install

# Update package lists
sudo apt update

# Verify system
cat /etc/os-release
uname -m
```

## Examples

### Fresh Ubuntu 24.04 System

```bash
cd ~/debian-setup

# With NVIDIA
./setup.sh --nvidia --os-type ubuntu --os-version 24

# Without NVIDIA
./setup.sh
```

### Fresh Debian 12 System

```bash
cd ~/debian-setup

# With NVIDIA
./setup.sh --nvidia --os-type debian --os-version 12

# Without NVIDIA
./setup.sh
```

### Development System (Custom CUDA)

```bash
cd ~/debian-setup

./setup.sh --nvidia \
  --os-type ubuntu \
  --os-version 24 \
  --cuda-version 12 \
  --cudnn-version 8
```
