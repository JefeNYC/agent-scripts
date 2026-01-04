#!/bin/bash

# Docker Installation Script (script works on Ubuntu as well)


# Uninstall old versions 
#  (Before you can install Docker Engine, you need to uninstall any conflicting packages. Your Linux distribution may provide unofficial Docker packages, which may conflict with the official packages provided by Docker. You must uninstall these packages before you install the official version of Docker Engine.)

sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine



# Installing using the rpm repository
# Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.

# Setting up the repository
# Install the dnf-plugins-core package (which provides the commands to manage your DNF repositories) and set up the repository.

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Installing Docker Engine
# Step 1 ... Installing Docker packages

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## If prompted to accept the GPG key, verify that the fingerprint matches 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35, and if so, accept it.
# This command installs Docker, but it doesn't start Docker. It also creates a docker group, however, it doesn't add any users to the group by default.If prompted to accept the GPG key, verify that the fingerprint matches 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35, and if so, accept it.
# This command installs Docker, but it doesn't start Docker. It also creates a docker group, however, it doesn't add any users to the group by default.

# Step 2 Starting Docker engine

sudo systemctl enable --now docker