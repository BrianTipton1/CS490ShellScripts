FROM registry.opensuse.org/opensuse/distrobox:latest

RUN sudo zypper refresh
RUN sudo zypper install -y neovim \
  bat \
  jq \
  zsh \
  fzf \
  git \
  awk \
  iputils \
  htop \
  psmisc \
  lazygit \
  tmux \
  lazygit \
  gcc-c++ \
  cmake \
  gcc \
  python3-virtualenv

RUN sudo zypper ar https://download.opensuse.org/tumbleweed/repo/oss/ factory-oss
RUN sudo zypper in -y eza
RUN echo "export XDG_CONFIG_HOME=\"\$HOME/.config\"" >> /etc/zshenv
RUN echo "export ZDOTDIR=\"\$HOME/.cache/zsh\"" >> /etc/zshenv
