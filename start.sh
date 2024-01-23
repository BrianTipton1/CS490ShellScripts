#!/usr/bin/env bash
#

sudo apt-get update
sudo apt-get upgrade -y 
sudo mkdir -p /etc/apt/keyrings
curl -fsSL "https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_$(lsb_release -rs)/Release.key" \
  | gpg --dearmor \
  | sudo tee /etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg > /dev/null
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg]\
    https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_$(lsb_release -rs)/ /" \
  | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list > /dev/null
sudo apt-get update -qq
sudo apt-get -qq -y install podman
sudo apt-get -y install git
yes | $(curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh)

git clone https://github.com/BrianTipton1/CS490ShellScripts.git ~/CS490ShellScripts
cd ~/CS490ShellScripts

mkdir -p ~/.cache/zsh
mkdir -p ~/.config/zsh
mkdir -p ~/work
sudo mkdir -p /etc/containers/systemd
 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm -f ~/.zshrc ~/.zsh_history
cp ./.zshrc ~/.cache/zsh/.zshrc

podman run quay.io/k9withabone/podlet podman run --name jupyter_notebook --detach -p 10000:8888 -v ~/work:/home/jovyan/work quay.io/jupyter/datascience-notebook:python-3.11 | sudo bash -c 'cat > /etc/containers/systemd/jupyter_notebook.container'
sudo /usr/libexec/podman/quadlet /etc/systemd/system/
sudo systemctl enable jupyter_notebook.service --now

podman build -t mybase -f ./Containerfile .
distrobox create main --image mybase

distrobox enter main -- zsh -c "yes '' | bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)" 
rm -rf ~/.config/lvim
git clone https://github.com/BrianTipton1/lunarvim.git ~/.config/lvim 
echo -e "if [ -z \"\${CONTAINER_ID}\" ]; then\n  exec distrobox enter main -- zsh\nfi" >> ~/.bashrc
