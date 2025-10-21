#!/bin/bash

# Prevent running the entire script with sudo
if [ "$EUID" -eq 0 ] || [ -n "$SUDO_USER" ]; then
    echo "ERROR: Do not run this script with sudo!"
    echo "The script will request sudo access only when needed (for roverform symlink)."
    exit 1
fi

# Check if sudo is available (required for roverform symlink)
if ! sudo -n true 2>/dev/null; then
    echo "This script requires sudo access for roverform installation."
    echo "You may be prompted for your password."
fi

# Determine the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    echo "             Installing zsh-autosuggestions                "
    echo "-----------------------------------------------------------"
    ZSH_AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    rm -rf "$ZSH_AUTOSUGGESTIONS_DIR"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_AUTOSUGGESTIONS_DIR"

    echo "==========================================================="
    echo "                Installing powerlevel10k                   "
    echo "-----------------------------------------------------------"
    P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    rm -rf "$P10K_DIR"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"

    echo "==========================================================="
    echo "                Installing git-completion                  "
    echo "-----------------------------------------------------------"
    curl -o $HOME/git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

    echo "==========================================================="
    echo "                   Installing autojump                     "
    echo "-----------------------------------------------------------"
    rm -rf "$DOTFILES_DIR/autojump"
    git clone https://github.com/wting/autojump.git "$DOTFILES_DIR/autojump"
    (cd "$DOTFILES_DIR/autojump" && python3 install.py)
    rm -rf "$DOTFILES_DIR/autojump"

    echo "==========================================================="
    echo "                    Installing roverform                   "
    echo "-----------------------------------------------------------"
    # Remove roverform, using sudo if permission denied
    if ! rm -rf "$HOME/roverform" 2>/dev/null; then
        echo "Removing root-owned roverform files (requires sudo)..."
        sudo rm -rf "$HOME/roverform"
    fi
    git clone https://github.com/roverdotcom/roverform.git $HOME/roverform

    echo "Creating roverform symlink (requires sudo)..."
    sudo ln -sf $HOME/roverform/bin/roverform /usr/local/bin/roverform

    echo "==========================================================="
    echo "                    Installing pyenv                       "
    echo "-----------------------------------------------------------"
    # Remove pyenv, using sudo if permission denied
    if ! rm -rf "$HOME/.pyenv" 2>/dev/null; then
        echo "Removing root-owned pyenv files (requires sudo)..."
        sudo rm -rf "$HOME/.pyenv"
    fi
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

    echo "==========================================================="
    echo "                  Copying p10k.zsh                         "
    echo "-----------------------------------------------------------"
    cp -f "$DOTFILES_DIR/.p10k.zsh" $HOME/.p10k.zsh

    echo "==========================================================="
    echo "                  Copying .zshrc                           "
    echo "-----------------------------------------------------------"
    cp -f "$DOTFILES_DIR/.zshrc" $HOME/.zshrc

    # Deploy LLM rules
    bash "$DOTFILES_DIR/sync-llm-rules"

    echo "==========================================================="
    echo "              Installing sync-llm-rules                    "
    echo "-----------------------------------------------------------"
    mkdir -p "$HOME/bin"
    # Create a wrapper script that knows where the dotfiles are
    cat > "$HOME/bin/sync-llm-rules" << EOF
#!/bin/bash
# Wrapper for sync-llm-rules that knows the dotfiles location
exec "$DOTFILES_DIR/sync-llm-rules" "\$@"
EOF
    chmod +x "$HOME/bin/sync-llm-rules"
    echo "  ✓ Installed wrapper to ~/bin/sync-llm-rules"

    echo "==========================================================="
    echo "                  Copying .jackrc                          "
    echo "-----------------------------------------------------------"
    cp -f "$DOTFILES_DIR/.jackrc" $HOME/.jackrc

    echo "==========================================================="
    echo "              Ensuring .jackrc is sourced                  "
    echo "-----------------------------------------------------------"
    # Add to .bashrc if it exists and doesn't already source .jackrc
    if [ -f "$HOME/.bashrc" ]; then
        if ! grep -q "source.*\.jackrc" "$HOME/.bashrc" && ! grep -q "\. .*\.jackrc" "$HOME/.bashrc"; then
            echo '[[ -f ~/.jackrc ]] && source ~/.jackrc' >> "$HOME/.bashrc"
            echo "  ✓ Added .jackrc source to .bashrc"
        else
            echo "  ✓ .bashrc already sources .jackrc"
        fi
    fi

    # Add to .zshrc if it doesn't already source .jackrc
    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -q "source.*\.jackrc" "$HOME/.zshrc" && ! grep -q "\. .*\.jackrc" "$HOME/.zshrc"; then
            echo '[[ -f ~/.jackrc ]] && source ~/.jackrc' >> "$HOME/.zshrc"
            echo "  ✓ Added .jackrc source to .zshrc"
        else
            echo "  ✓ .zshrc already sources .jackrc"
        fi
    fi

    echo "✓ Installation complete!"
}

zshrc
