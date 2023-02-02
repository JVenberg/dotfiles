#!/bin/bash

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "                cloning powerlevel10k                      "
    echo "-----------------------------------------------------------"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    curl -o $HOME/git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

    echo "==========================================================="
    echo "                   cloning autojump                        "
    echo "-----------------------------------------------------------"
    git clone https://github.com/wting/autojump.git
    echo "==========================================================="
    echo "                  installing autojump                      "
    echo "-----------------------------------------------------------"
    ./autojump/install.py

    echo "==========================================================="
    echo "                    cloning roverform                      "
    echo "-----------------------------------------------------------"
    git clone https://github.com/roverdotcom/roverform.git $HOME/roverform
    echo "==========================================================="
    echo "                   installing roverform                    "
    echo "-----------------------------------------------------------"
    ln -s $HOME/roverform/bin/roverform /usr/local/bin/roverform

    echo "==========================================================="
    echo "                    cloning pyenv                      "
    echo "-----------------------------------------------------------"
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

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
