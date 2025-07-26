#!/bin/bash

if ! command -v volta &> /dev/null; then
    echo "⚡ Installing Volta..."
    # install Volta
    curl https://get.volta.sh | bash
    
    # Source volta for current session
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
    
    echo "📦 Installing Node.js with Volta..."
    # install Node
    volta install node
    
    echo "✅ Volta and Node.js installed!"
    echo "💡 Restart your shell or run: source ~/.bashrc"
else
    echo "✅ Volta already installed"
    volta --version
fi
