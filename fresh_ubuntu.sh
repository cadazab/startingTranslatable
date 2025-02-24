#!/bin/bash
# Install packages

echo "Updating package lists..."
sudo apt update

echo "Instaling ohmyzsh"
sudo apt install zsh -y
chsh -s $(which zsh)
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# Change the Oh My Zsh theme
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc
# Replace the modified theme inside the .oh-my-zsh directory
cp zsh-themes/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme
# Source the .zshrc file to apply changes
source ~/.zshrc
echo "Oh My Zsh theme changed to agnoster and theme file replaced successfully."

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y
sudo apt autoclean

echo "System update and upgrade completed successfully!"


echo "initializing docker swarm"
docker swarm init --advertise-addr 134.209.249.254
# Init service

exec # Init zsh
exec zsh

