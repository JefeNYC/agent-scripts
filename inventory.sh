#!/bin/bash

# Server Inventory Script
# Collects basic system information

echo "=============================="
echo " Server Inventory Report"
echo " Generated on: $(date)"
echo "=============================="
echo ""

# Hostname
echo "Hostname: $(hostname)"

sleep 2

# OS Info
echo "Operating System: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"')"

sleep 2

# Kernel version
echo "Kernel Version: $(uname -r)"

sleep 2

# Uptime
echo "Uptime: $(uptime -p)"

sleep 2

# CPU Info
echo "CPU(s): $(nproc) cores"
echo "CPU Model: $(lscpu | grep 'Model name' | awk -F: '{print $2}' | xargs)"

sleep 2

# Memory Info
echo "Total Memory: $(free -h | grep Mem | awk '{print $2}')"
echo "Available Memory: $(free -h | grep Mem | awk '{print $7}')"

sleep 2

# Disk Info
echo "Disk Usage:"
df -h --total | grep total

sleep 2

# Network Info
echo "IP Addresses:"
hostname -I

sleep 2

# List of installed packages (optional, can be commented)
# echo "Installed Packages:"
# rpm -qa | sort

echo ""
echo "=============================="
echo "End of Report"
echo "=============================="
