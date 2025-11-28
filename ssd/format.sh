#!/bin/bash

# Format and prepare the secondary SSD
# WARNING: This will DESTROY all data on /dev/nvme1n1

set -e

DEVICE="/dev/nvme1n1"
PARTITION="${DEVICE}p1"

echo "========================================="
echo "WARNING: This will DESTROY all data on $DEVICE"
echo "========================================="
echo ""
read -p "Are you absolutely sure you want to continue? (type 'YES' to confirm): " confirmation

if [ "$confirmation" != "YES" ]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "Starting disk format process..."

# Unmount if mounted
if mount | grep -q "$PARTITION"; then
    echo "Unmounting $PARTITION..."
    sudo umount "$PARTITION" || true
fi

# Wipe partition table
echo "Wiping partition table..."
sudo wipefs -a "$DEVICE"

# Create new GPT partition table and single partition
echo "Creating new partition table..."
sudo parted -s "$DEVICE" mklabel gpt
sudo parted -s "$DEVICE" mkpart primary ext4 0% 100%

# Wait for partition to be recognized
sleep 2

# Format with ext4
echo "Formatting $PARTITION with ext4..."
sudo mkfs.ext4 -F "$PARTITION"

# Set a label for easier identification
echo "Setting filesystem label..."
sudo e2label "$PARTITION" "WORKSPACE"

echo ""
echo "========================================="
echo "Format complete!"
echo "Partition: $PARTITION"
echo "Filesystem: ext4"
echo "Label: WORKSPACE"
echo "========================================="
echo ""
echo "You can now run the setup script to mount and configure it."
