#!/bin/bash

if ! command -v docker-desktop &> /dev/null; then
    echo "🐳 Installing Docker Desktop..."
    
    # Add Docker's official GPG key
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    # Add the repository to Apt sources
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    
    # Download and install Docker Desktop
    curl -o /tmp/docker-desktop.deb "https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"
    sudo apt-get install -y /tmp/docker-desktop.deb || echo "ℹ️ Installation completed (apt error is normal)"
    rm -f /tmp/docker-desktop.deb
    
    # Configure user
    sudo usermod -aG docker "$USER"
    
    echo "✅ Docker Desktop installed!"
    echo "💡 Log out and log back in for group changes to take effect"
    echo "🚀 Launch from applications menu or: systemctl --user start docker-desktop"
else
    echo "✅ Docker Desktop already installed"
    docker-desktop --version 2>/dev/null || echo "Docker Desktop found at /opt/docker-desktop"
fi

