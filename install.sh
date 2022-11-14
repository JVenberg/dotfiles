#!/bin/bash

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "                 cloning powerlevel10k                       "
    echo "-----------------------------------------------------------"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "==========================================================="
    echo "                  Import p10k.zsh                             "
    echo "-----------------------------------------------------------"
    cp .p10k.zsh $HOME/.p10k.zsh
    echo "==========================================================="
    echo "                  Import zshrc                             "
    echo "-----------------------------------------------------------"
    cp .zshrc $HOME/.zshrc
}

zshrc
