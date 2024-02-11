#!/usr/bin/env bash
#
sudo apt update && sudo apt upgrade -y
sudo apt install tmux screen htop git -y
git clone https://github.com/BrianTipton1/CS490ShellScripts.git ~/CS490ShellScripts
yes | "${SHELL}" <(curl -L micro.mamba.pm/install.sh)
echo "alias conda=micromamba" >> ~/.bashrc
cp ~/CS490ShellScripts/.condarc ~/.condarc
yes | ~/.local/bin/micromamba self-update
yes | ~/.local/bin/micromamba create -n jupyter -c conda-forge notebook nb_conda_kernels nb_conda
yes | ~/.local/bin/micromamba install -n jupyter pytorch==2.1.2 torchvision==0.16.2 torchaudio==2.1.2 -c pytorch
