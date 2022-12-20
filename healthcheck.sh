#!/bin/sh

(
echo n # Add a new partition
echo 2 # Partition number
echo 50  # First sector (Accept default: 1)
echo     # Last sector (Accept default: varies)
echo w # Write changes
) | sudo fdisk /dev/xvda

sudo mkfs -t ext4 /dev/xvda2
sudo echo "/dev/xvda2      /tmp    ext4    defaults        0 2" >> /etc/fstab
mount -a

