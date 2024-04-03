#!/bin/bash

# Check if script is run as root
if [ "$(id -u)" = "0" ]; then
   echo "This script must not be run as root" 1>&2
   exit 1
fi

# Check if Homebrew is already installed
if command -v brew &> /dev/null; then
    echo "Homebrew is already installed."
    exit 1
fi

# Set environment variables to enable silent installation
export CI=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export PATH="/usr/local/bin:$PATH"

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "Homebrew has been installed successfully."
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    brew
else
    echo "Something went wrong, try again later."
    exit 1
fi
