#!/usr/bin/env bash

echo "[Dotfiles] Bootstrapping..."

# Setup config files
ln -sf "$(readlink -f .tmux.conf)" $HOME
ln -sf "$(readlink -f .vimrc)" $HOME
ln -sf "$(readlink -f .zshrc)" $HOME

# Finish bootstrap
touch "$(readlink -f ../.bootstrapped)"

echo "[Dotfiles] Bootstrapping. OK!"
