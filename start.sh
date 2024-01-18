#!/usr/bin/env bash
#

sudo apt update
sudo apt upgrade -y 
sudo apt install -y podman git wget distrobox

mkdir -p ~/.cache/zsh
mkdir -p ~/work
mkdir -p ~/.config/zsh
 
yes | bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
rm -rf ~/.config/lvim

git clone https://github.com/BrianTipton1/lunarvim.git ~/.config/lvim
git clone https://github.com/BrianTipton1/CS490ShellScripts.git ~/CS490ShellScripts
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting

yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc ~/.zsh_history

cd ~/CS490ShellScripts
cp ./.zshrc ~/.cache/zsh/.zshrc

podman build -t mybase .
distrobox create main --image mybase

podman pull quay.io/jupyter/datascience-notebook:python-3.11
podman run --name jupyter_notebook -it -p 10000:8888 -v "${PWD}":~/work datascience-notebook:python-3.11

podman generate systemd --new --name jupyter_notebook -f
mv container-jupyter_notebook.service /etc/systemd/system
sudo systemctl enable container-jupyter_notebook.service

echo "
if [ ! -z "${CONTAINER_ID}" ]; then
  exec zsh
fi
" >> ~/.bashrc
