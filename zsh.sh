#!/bin/bash

which zsh >>/etc/shells
chsh -s "$(which zsh)"

# Install oh-my-zsh and keep the dotfile zshrc
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh --keep-zshrc)"

# install the themes and instant shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

# Install z for zsh
git clone --depth=1 https://github.com/agkozak/zsh-z "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/}"/plugins/zsh-z
