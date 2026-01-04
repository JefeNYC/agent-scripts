#!/bin/bash
# Apache Server Automation Script (CentOS/Ubuntu compatible)

set -e  # Exit on error

echo "Detecting OS..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect OS. Exiting."
    exit 1
fi

echo "Detected OS: $OS"

# Install Apache
if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    echo "Installing Apache for Ubuntu/Debian..."
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl enable apache2
    sudo systemctl start apache2
    sudo systemctl is-active --quiet apache2 && echo "Apache is running!" || echo "Apache failed to start!"
else
    echo "Installing Apache for CentOS/RedHat/Amazon Linux..."
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
    sudo systemctl is-active --quiet httpd && echo "Apache is running!" || echo "Apache failed to start!"
fi
