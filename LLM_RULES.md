# LLM Rules Management

This directory contains rules and instructions for AI coding assistants (Kilo Code, Cline, Roo Code).

## Structure

```
dotfiles/
├── LLM_RULES.md       # This file (documentation)
└── llm-rules/         # Actual rule files
    ├── language.md    # Language and communication guidelines
    ├── code-style.md  # Coding conventions and standards
    └── testing.md     # Testing requirements
```

## How It Works

1. **Installation**: Run `./install.sh` to create symlinks from your dotfiles to tool config directories
2. **Single Source**: Edit files here - changes instantly affect all tools via symlinks

## Tool Mappings

| Tool      | Global Rules Location      |
| --------- | -------------------------- |
| Kilo Code | `~/.kilocode/rules/`       |
| Cline     | `~/Documents/Cline/Rules/` |
| Roo Code  | `~/.roo/rules/`            |

All tools share the same rules from this directory via symlinks. The install script creates the necessary directories if they don't exist.

## Adding New Rules

1. Create or edit `.md` files in `llm-rules/`
2. Changes take effect immediately (symlinks)
3. All tools will see the updates

## Manual Sync

If symlinks break, run:

```bash
./sync-llm-rules
```
