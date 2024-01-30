#!/usr/bin/env bash
#
sudo apt update && sudo apt upgrade -y
sudo apt install tmux screen htop git -y
git clone https://github.com/BrianTipton1/CS490ShellScripts.git ~/CS490ShellScripts
yes | "${SHELL}" <(curl -L micro.mamba.pm/install.sh)
echo "alias conda=micromamba" >> ~/.bashrc
cp ~/CS490ShellScripts/.condarc ~/.condarc
yes | ~/.local/bin/micromamba self-update
yes | ~/.local/bin/micromamba env create -f ~/CS490ShellScripts/requirements.yml
