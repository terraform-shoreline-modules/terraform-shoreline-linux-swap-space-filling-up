#!/bin/bash



# Check if swap is enabled

if [ "$(swapon --show | wc -l)" -gt 0 ]; then

  echo "Swap is currently enabled. Disabling swap..."

  

  # Turn off all swap devices

  sudo swapoff -a

  

  # Remove swap entries from /etc/fstab

  sudo sed -i '/swap/d' /etc/fstab

  

  echo "Swap is disabled."

else

  echo "Swap is already disabled."

fi