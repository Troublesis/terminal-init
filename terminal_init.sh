#!/bin/bash

# Define the list of packages to install
packages_to_install="curl git vim pipx zsh docker.io"

# Function to detect package manager
detect_package_manager() {
    if [ -x "$(command -v apt)" ]; then
        echo "apt"
    elif [ -x "$(command -v yum)" ]; then
        echo "yum"
    elif [ -x "$(command -v dnf)" ]; then
        echo "dnf"
    else
        echo "Unsupported package manager. Exiting."
        exit 1
    fi
}

# Update package lists and install necessary packages if package manager is available
package_manager=$(detect_package_manager)
if [ "$package_manager" == "apt" ]; then
    apt update -y
    apt install -y $packages_to_install
elif [ "$package_manager" == "yum" ]; then
    yum update -y
    yum install -y $packages_to_install
elif [ "$package_manager" == "dnf" ]; then
    dnf update -y
    dnf install -y $packages_to_install
else
    echo "No supported package manager found. Exiting."
    exit 1
fi

# Only run the following code if a supported package manager was found
if [ "$package_manager" != "Unsupported package manager. Exiting." ]; then
    # Install pipx packages
    pipx install -y poetry
    pipx ensurepath
    poetry config virtualenvs.in-project true

    # Install oh-my-zsh and configure plugins
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    # Install zsh-autosuggestions and zsh-syntax-highlighting plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    sed -i 's/plugins=(git)/plugins=(git vi-mode zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

    # Install oh-my-zsh powerleve110k theme
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    
    # Reload shell configuration
    # source ~/.zshrc

    # Optional: Configure Powerlevel10k theme
    # p10k configure
fi
