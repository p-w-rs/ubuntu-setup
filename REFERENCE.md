# Quick Reference Guide

## ⚠️ IMPORTANT: NVIDIA Requires Explicit OS

NVIDIA installation **does not auto-detect** your OS. You must specify:
- `--os-type`: ubuntu or debian
- `--os-version`: 22, 24 (Ubuntu) or 12, 13 (Debian)

## Common Commands

### Basic Setup (No NVIDIA)
```bash
cd ~/debian-setup
./setup.sh
```

### NVIDIA Setup (OS REQUIRED)

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
./setup.sh --nvidia \
  --os-type ubuntu \
  --os-version 24 \
  --no-interactive
```

### Install Only (No Configuration)
```bash
./install.sh --nvidia --os-type debian --os-version 12
```

### Configure Only
```bash
./configure.sh
```

## Supported Systems

| OS | Versions | Command Example |
|-----|----------|-----------------|
| Ubuntu | 22, 24 | `--os-type ubuntu --os-version 24` |
| Debian | 12, 13 | `--os-type debian --os-version 12` |

**Architecture**: x86_64 (amd64) only

## OS Version Shortcuts

You can use short version numbers:
- `--os-version 22` → Ubuntu 22.04 (2204)
- `--os-version 24` → Ubuntu 24.04 (2404)
- `--os-version 12` → Debian 12
- `--os-version 13` → Debian 13

Or full version numbers:
- `--os-version 2204` → Ubuntu 22.04
- `--os-version 2404` → Ubuntu 24.04

## TensorRT: C/C++ Only

The TensorRT installation includes **only C/C++ libraries**:

**Installed:**
- `libnvinfer-dev` (Core runtime)
- `libnvinfer-plugin-dev` (Plugins)
- `libnvparsers-dev` (Caffe parser)
- `libnvonnxparsers-dev` (ONNX parser)

**Not Installed:**
- Python bindings
- Python wheel packages

**Usage Example:**
```bash
g++ -o app app.cpp \
  -lnvinfer \
  -lnvonnxparser \
  -L/usr/lib/x86_64-linux-gnu \
  -I/usr/include/x86_64-linux-gnu
```

## Verification Commands

### Check Your OS
```bash
cat /etc/os-release
# Look for ID and VERSION_ID
```

### Check NVIDIA Driver
```bash
nvidia-smi
```

### Check CUDA
```bash
nvcc --version
echo $CUDA_HOME
```

### Check TensorRT
```bash
# Check installed packages
dpkg -l | grep tensorrt

# Check libraries
ls /usr/lib/x86_64-linux-gnu/ | grep nvinfer

# Check headers
ls /usr/include/x86_64-linux-gnu/ | grep NvInfer
```

## Environment Variables

Set automatically by the scripts:

```bash
NVIDIA_CUDA_VERSION="13"      # From --cuda-version
NVIDIA_CUDNN_VERSION="9"      # From --cudnn-version
NVIDIA_OS_TYPE="ubuntu"       # From --os-type (REQUIRED)
NVIDIA_OS_VERSION="24"        # From --os-version (REQUIRED)
```

## Error Messages

### Missing OS Parameters
```
! Error: NVIDIA installation requires --os-type and --os-version
```

**Solution:**
```bash
./install.sh --nvidia --os-type ubuntu --os-version 24
```

### Invalid OS Type
```
! Error: Invalid OS type: fedora
```

**Solution:** Use `ubuntu` or `debian`:
```bash
./install.sh --nvidia --os-type ubuntu --os-version 24
```

### Invalid OS Version
```
! Error: Invalid Ubuntu version: 20
```

**Solution:** Use supported versions:
- Ubuntu: 22, 24
- Debian: 12, 13

```bash
./install.sh --nvidia --os-type ubuntu --os-version 24
```

## Troubleshooting

### Repository Not Found

If you get repository errors during installation:

1. **Verify your OS:**
   ```bash
   cat /etc/os-release
   ```

2. **Use the correct OS specification:**
   ```bash
   # For Ubuntu 24.04
   ./install.sh --nvidia --os-type ubuntu --os-version 24
   
   # For Debian 12
   ./install.sh --nvidia --os-type debian --os-version 12
   ```

### Driver Not Loading
```bash
# Did you reboot?
sudo reboot

# Check driver after reboot
nvidia-smi

# Check driver version
cat /proc/driver/nvidia/version
```

### Broken Packages
```bash
sudo apt --fix-broken install
sudo apt update
sudo apt full-upgrade
```

## File Locations

### Configuration Files
```
~/.config/fish/config.fish          # Main Fish config
~/.config/fish/conf.d/*.fish        # Fish modules
~/.config/ghostty/config            # Ghostty terminal
~/.config/uv/uv.toml               # UV Python manager
~/.julia/config/startup.jl         # Julia startup
```

### NVIDIA/CUDA
```
/usr/local/cuda                     # CUDA installation
/usr/local/cuda/bin                 # CUDA binaries
/usr/local/cuda/lib64               # CUDA libraries
/usr/local/cuda/include             # CUDA headers
```

### TensorRT (C/C++)
```
/usr/lib/x86_64-linux-gnu/          # Libraries (libnvinfer*.so)
/usr/include/x86_64-linux-gnu/      # Headers (NvInfer*.h)
```

## Complete Examples

### Ubuntu 24.04 with NVIDIA
```bash
cd ~/debian-setup

# Full setup
./setup.sh --nvidia \
  --os-type ubuntu \
  --os-version 24 \
  --cuda-version 13 \
  --cudnn-version 9

# Reboot
sudo reboot

# Verify after reboot
nvidia-smi
nvcc --version
```

### Debian 12 with NVIDIA
```bash
cd ~/debian-setup

# Full setup
./setup.sh --nvidia \
  --os-type debian \
  --os-version 12

# Reboot
sudo reboot

# Verify after reboot
nvidia-smi
nvcc --version
```

### Without NVIDIA
```bash
cd ~/debian-setup
./setup.sh
# No OS parameters needed!
```

## Post-Installation

### Set Fish as Default Shell
```bash
chsh -s /usr/bin/fish
# Log out and log back in
```

### Configure Tide Prompt
```bash
tide configure
```

### Add API Keys
```bash
nano ~/.config/fish/conf.d/90-api-keys.fish
```

## Quick Reinstall

### Full Reinstall (With NVIDIA)
```bash
cd ~/debian-setup
./setup.sh --nvidia --os-type ubuntu --os-version 24
```

### NVIDIA Only
```bash
./install.sh --nvidia --os-type ubuntu --os-version 24
```

### Skip NVIDIA
```bash
./install.sh
```

## Notes

- 📝 Always run as regular user (scripts use sudo internally)
- 🔄 Always reboot after NVIDIA driver installation
- ⚠️ **NVIDIA requires explicit OS specification** - no auto-detection
- ✅ Scripts are idempotent (safe to run multiple times)
- 🌐 Requires internet connection
- 💾 Requires ~10GB free space for full NVIDIA stack
- ⏱️ Takes 15-30 minutes for full installation
- 🔧 TensorRT installs C/C++ libraries only (no Python)
