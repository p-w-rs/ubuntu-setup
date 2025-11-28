#!/bin/bash

# Setup script for mounting secondary SSD and symlinking home directories
# This script is idempotent and can be run multiple times safely

set -e

PARTITION="/dev/nvme1n1p1"
MOUNT_POINT="/mnt/workspace"
HOME_DIRS=("Desktop" "Documents" "Downloads" "Music" "Pictures" "Public" "Templates" "Videos")

echo "========================================="
echo "Workspace SSD Setup Script"
echo "========================================="
echo ""

# Function to check if partition is mounted
is_mounted() {
    mount | grep -q "$MOUNT_POINT"
}

# Create mount point if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point at $MOUNT_POINT..."
    sudo mkdir -p "$MOUNT_POINT"
fi

# Mount if not already mounted
if ! is_mounted; then
    echo "Mounting $PARTITION to $MOUNT_POINT..."
    sudo mount "$PARTITION" "$MOUNT_POINT"
else
    echo "Partition already mounted at $MOUNT_POINT"
fi

# Get the UUID of the partition for fstab
UUID=$(sudo blkid -s UUID -o value "$PARTITION")
echo "Partition UUID: $UUID"

# Set ownership of mount point to current user
echo "Setting ownership of $MOUNT_POINT to $USER..."
sudo chown "$USER:$USER" "$MOUNT_POINT"

# Process each home directory
echo ""
echo "Setting up home directories..."
for dir in "${HOME_DIRS[@]}"; do
    SSD_DIR="$MOUNT_POINT/$dir"
    HOME_DIR="$HOME/$dir"

    echo "Processing $dir..."

    # Create directory on SSD if it doesn't exist
    if [ ! -d "$SSD_DIR" ]; then
        echo "  Creating $SSD_DIR on SSD..."
        mkdir -p "$SSD_DIR"
    fi

    # Handle existing home directory
    if [ -e "$HOME_DIR" ]; then
        if [ -L "$HOME_DIR" ]; then
            # It's already a symlink
            LINK_TARGET=$(readlink -f "$HOME_DIR")
            if [ "$LINK_TARGET" = "$SSD_DIR" ]; then
                echo "  ✓ $dir already correctly symlinked"
                continue
            else
                echo "  Removing old symlink..."
                rm "$HOME_DIR"
            fi
        else
            # It's a real directory, move contents to SSD
            echo "  Moving existing contents to SSD..."
            # Use rsync to preserve permissions and copy contents
            rsync -a "$HOME_DIR/" "$SSD_DIR/"
            rm -rf "$HOME_DIR"
        fi
    fi

    # Create symlink
    echo "  Creating symlink: $HOME_DIR -> $SSD_DIR"
    ln -s "$SSD_DIR" "$HOME_DIR"
done

# Configure automatic mounting in fstab
echo ""
echo "Configuring automatic mount on boot..."

FSTAB_ENTRY="UUID=$UUID $MOUNT_POINT ext4 defaults,nofail,x-gvfs-hide 0 2"

# Check if entry already exists
if grep -q "$UUID" /etc/fstab; then
    echo "  Entry already exists in /etc/fstab"
else
    echo "  Adding entry to /etc/fstab..."
    echo "# Workspace SSD for home directories" | sudo tee -a /etc/fstab
    echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
    echo "  ✓ Added to /etc/fstab"
fi

# Test fstab
echo ""
echo "Testing fstab configuration..."
sudo mount -a
echo "  ✓ fstab test successful"

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "Summary:"
echo "  Mount point: $MOUNT_POINT"
echo "  Partition: $PARTITION"
echo "  UUID: $UUID"
echo "  Directories configured: ${HOME_DIRS[*]}"
echo ""
echo "Your home directories are now on the workspace SSD and will"
echo "automatically mount on boot (hidden from file manager sidebar)."
echo "You can verify by running:"
echo "  ls -la ~"
echo ""
