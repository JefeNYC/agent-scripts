#!/bin/bash

# Docker Installation Script (Works on Ubuntu and CentOS/Stream 9)
# Author: Jefe

set -e  # Exit on any error

echo "Detecting Linux distribution..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VERSION=$VERSION_ID
else
    echo "Cannot detect OS. Exiting."
    exit 1
fi

echo "Detected OS: $OS $VERSION"

# --- Uninstall old Docker versions ---
echo "Removing old Docker packages (if any)..."
if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt-get remove -y docker docker-engine docker.io containerd runc || true
else
    sudo dnf remove -y docker \
                      docker-client \
                      docker-client-latest \
                      docker-common \
                      docker-latest \
                      docker-latest-logrotate \
                      docker-logrotate \
                      docker-engine || true
fi

# --- Install Docker ---
if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    echo "Installing Docker on Ubuntu/Debian..."
    sudo apt-get update
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # Add Docker’s official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Set up repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

else
    echo "Installing Docker on CentOS/Stream..."
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# --- Start Docker and enable on boot ---
echo "Enabling and starting Docker service..."
sudo systemctl enable --now docker

# --- Add current user to docker group ---
echo "Adding user $USER to docker group..."
sudo usermod -aG docker $USER

echo "Docker installation completed!"
docker --version
