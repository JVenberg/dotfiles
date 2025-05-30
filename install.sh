#!/bin/bash

# Install nvm, Node.js (for npx), and uv (for uvx)
echo "==========================================================="
echo "                  Installing nvm                             "
echo "-----------------------------------------------------------"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "==========================================================="
echo "          Installing Node.js (LTS) via nvm                 "
echo "-----------------------------------------------------------"
nvm install --lts
nvm alias default 'lts/*' # Set default node version

echo "==========================================================="
echo "                    Installing uv                            "
echo "-----------------------------------------------------------"
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> $HOME/.zshrc # Add uv to PATH for zsh
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> $HOME/.bashrc # Add uv to PATH for bash
# Source the profile files to make uv available in the current script session if needed,
# though typically these are for new shell sessions.
# For Codespaces, these PATH updates will be picked up on new terminal creation.
# We also need to ensure .cargo/bin is in the PATH for the rest of this script if uv is used immediately.
export PATH="$HOME/.cargo/bin:$PATH"


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
    sudo ln -s $HOME/roverform/bin/roverform /usr/local/bin/roverform

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

cp .jackrc $HOME/.jackrc
echo "source $HOME/.jackrc" >> $HOME/.bashrc
echo "source $HOME/.jackrc" >> $HOME/.zshrc
