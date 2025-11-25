#!/bin/bash
# DEPENDS_ON: cuda cudnn

# Install TensorRT (C/C++ libraries only)
# NVIDIA's high-performance deep learning inference optimizer and runtime
# No Python bindings - C/C++ development only

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing TensorRT (C/C++ Libraries)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update package list
echo "→ Updating package list..."
sudo apt update > /dev/null 2>&1

# Install TensorRT using meta-packages
echo "→ Installing TensorRT development libraries..."
sudo apt install -y tensorrt-dev tensorrt-libs > /dev/null 2>&1

echo ""
echo "✓ TensorRT (C/C++) installed successfully!"
echo ""
echo "Installed packages:"
echo "  • tensorrt-dev         (Development headers and libraries)"
echo "  • tensorrt-libs        (Runtime libraries)"
echo ""
echo "Includes libraries:"
echo "  • libnvinfer           (Core runtime)"
echo "  • libnvinfer-plugin    (Plugin library)"
echo "  • libnvinfer-dispatch  (Dispatch runtime)"
echo "  • libnvinfer-lean      (Lean runtime)"
echo "  • libnvonnxparsers     (ONNX parser)"
echo ""
echo "Library location: /usr/lib/x86_64-linux-gnu/"
echo "Headers location: /usr/include/x86_64-linux-gnu/"
echo ""
echo "Compile example:"
echo "  g++ -o app app.cpp -lnvinfer -lnvonnxparser -L/usr/lib/x86_64-linux-gnu"
echo ""
echo "For more info: https://docs.nvidia.com/deeplearning/tensorrt/"
echo ""
