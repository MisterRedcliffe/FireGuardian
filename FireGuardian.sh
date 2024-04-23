#!/bin/bash

# FireGuardian.sh: Simplified Firewall Rule Update Utility with UFW

echo "Welcome to FireGuardian - Firewall Rule Update Utility"
echo "Ensuring UFW (Uncomplicated Firewall) is installed and enabled..."

# Function to install UFW if not already installed
install_ufw() {
    echo "Installing UFW..."
    sudo apt-get update && sudo apt-get install ufw -y
    sudo ufw enable
}

# Check if UFW is installed and enabled
if ! command -v ufw &> /dev/null; then
    install_ufw
fi

echo "UFW is installed and enabled. Proceeding with firewall rule management."

# Main menu for managing firewall rules with UFW
echo "What would you like to do?"
echo "1. Allow a specific port"
echo "2. Deny a specific port"
echo "3. Allow a port for a specific IP address"
echo "4. Deny a port for a specific IP address"
echo "5. Show current rules"
echo "6. Exit"

read -p "Choose an option [1-6]: " option

# Firewall rule management logic
case $option in
  1)
    read -p "Enter port to ALLOW: " port
    sudo ufw allow $port
    ;;
  2)
    read -p "Enter port to DENY: " port
    sudo ufw deny $port
    ;;
  3)
    read -p "Enter IP address: " ip
    read -p "Enter port to ALLOW for $ip: " port
    sudo ufw allow from $ip to any port $port
    ;;
  4)
    read -p "Enter IP address: " ip
    read -p "Enter port to DENY for $ip: " port
    sudo ufw deny from $ip to any port $port
    ;;
  5)
    sudo ufw status numbered
    ;;
  6)
    echo "Exiting."
    exit 0
    ;;
  *)
    echo "Invalid option. Exiting."
    exit 1
    ;;
esac
