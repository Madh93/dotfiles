#!/usr/bin/env bash

# Installers
install_arch_packages() {
  sudo pacman -Sy --noconfirm vim tmux fzf
}

install_alpine_packages() {
  sudo apk add --no-cache vim tmux fzf zsh-vcs ncurses
}

install_debian_packages() {
  sudo apt update
  sudo apt install -y vim tmux fzf
}

install_macos_packages() {
  brew install vim tmux fzf
}

echo "[Dotfiles] Installing packages..."

# Install packages
if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
  install_arch_packages
elif [ -f /etc/alpine-release ]; then
  install_alpine_packages
elif [ -f /etc/debian_version ]; then
  install_debian_packages
elif [ "$(uname)" == "Darwin" ]; then
  install_macos_packages
else
  echo "[Dotfiles] Unknown Operating System. Skipping packages installation..."
fi

echo "[Dotfiles] Installing packages. OK!"

# Bootstrap
if [ ! -f ../.bootstrapped ]; then
  ./scripts/bootstrap.sh
fi
