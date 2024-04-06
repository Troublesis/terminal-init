#!/bin/bash

# Update package lists and install necessary packages
apt update -y
apt install -y curl git vim pipx

# Install pipx packages
pipx install -y pdm

# Install oh-my-zsh and configure plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git vi-mode zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# Install zsh-autosuggestions and zsh-syntax-highlighting plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Reload shell configuration
source ~/.zshrc

# Optional: Configure Powerlevel10k theme
# p10k configure
