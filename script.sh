#!/bin/bash
# Cross-platform Package Installation Script
set -e  # Exit on any error

echo "Detecting Linux distribution..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect OS. Exiting."
    exit 1
fi

echo "Detected OS: $OS"

# Define packages
COMMON_PACKAGES=(wget net-tools sysstat gcc make python3 git)

if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    echo "Updating APT repositories..."
    sudo apt-get update -y
    
    # Ensure 'universe' repo is enabled (needed for 'finger' on Ubuntu)
    sudo add-apt-repository -y universe
    
    # Ubuntu packages list
    UBUNTU_PACKAGES=("${COMMON_PACKAGES[@]}" finger)
    
    echo "Installing packages on Ubuntu/Debian..."
    sudo apt-get install -y "${UBUNTU_PACKAGES[@]}"

else
    echo "Installing packages on CentOS/RedHat/Amazon Linux..."
    
    # Remove epel-release from list for AL2023 / RHEL9, but keep for older versions if needed
    if [[ "$OS" == "amzn" || "$OS" == "rhel" || "$OS" == "centos" ]]; then
        # Only install epel-release if package manager supports it
        sudo yum install -y epel-release || true
    fi
    
    # RHEL/CentOS/Amazon Linux packages list
    CENTOS_PACKAGES=("${COMMON_PACKAGES[@]}" finger)
    
    sudo yum install -y "${CENTOS_PACKAGES[@]}"
fi

echo "All packages installed successfully!"
