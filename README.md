# Jack's Dotfiles

Personal dotfiles for macOS and Linux environments, including shell configuration and LLM rules management.

## Features

- **Shell Configuration**: Zsh with Oh-My-Zsh, Powerlevel10k theme, and useful plugins
- **LLM Rules Management**: Centralized rules for AI coding assistants (Kilo Code, Cline, Roo Code)
- **Development Tools**: Node.js via nvm, Python via pyenv, and uv package manager
- **Auto-deployment**: Works with GitHub Codespaces

## Quick Start

### Local Installation

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

### GitHub Codespaces

Codespaces will automatically:

1. Clone this repository
2. Run `install.sh`
3. Configure your environment

## LLM Rules

This repository includes centralized rules for AI coding assistants. Rules are stored in [`llm-rules/`](llm-rules/) and automatically deployed to:

- **Kilo Code**: `~/.kilocode/rules/`
- **Cline**: `~/Documents/Cline/Rules/`
- **Roo Code**: `~/.roo/rules/`

### How It Works

- **Installation**: `install.sh` creates symlinks from `llm-rules/` to tool config directories
- **Instant Updates**: Edit files in `llm-rules/` - changes immediately affect all tools via symlinks
- **Global Access**: `sync-llm-rules` command is installed to `~/bin` for easy access

### Manual Sync

If needed, re-sync rules from anywhere:

```bash
sync-llm-rules
```

See [`LLM_RULES.md`](LLM_RULES.md) for more details.

## Structure

```
dotfiles/
├── .gitignore          # Git ignore patterns
├── .zshrc              # Zsh configuration
├── .jackrc             # Custom aliases and functions
├── .p10k.zsh           # Powerlevel10k theme config
├── install.sh          # Main installation script
├── sync-llm-rules      # LLM rules sync script (installed to ~/bin)
├── llm-rules/          # LLM assistant rules
│   ├── language.md     # Communication guidelines
│   ├── code-style.md   # Coding standards
│   └── testing.md      # Testing requirements
├── LLM_RULES.md        # Detailed LLM rules documentation
└── README.md           # This file
```

## Customization

1. **Shell**: Edit `.zshrc` for shell customization
2. **Aliases**: Add custom aliases to `.jackrc`
3. **LLM Rules**: Add or edit markdown files in `llm-rules/`
4. **Theme**: Run `p10k configure` to customize Powerlevel10k

## Requirements

- macOS or Linux
- Git
- Curl
- Zsh (installed by default on macOS)

## What Gets Installed

- **nvm**: Node Version Manager
- **Node.js**: Latest LTS version
- **uv**: Fast Python package installer
- **Oh-My-Zsh**: Zsh framework
- **Powerlevel10k**: Zsh theme
- **zsh-autosuggestions**: Fish-like autosuggestions
- **autojump**: Directory navigation tool
- **pyenv**: Python version manager

## Contributing

This is a personal dotfiles repository, but feel free to fork and adapt for your own use!

## License

MIT
