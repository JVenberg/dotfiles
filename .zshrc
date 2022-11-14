# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions autojump)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set git rebase default
git config --global pull.rebase true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Bash completion
test -f ~/.git-completion.bash && . $_

# kubectl configure_eks_cluster Command
export KUBECONFIG=~/.kube/rover-config
function configure_eks_cluster() {
  local cluster=$1
  local aws_account=$(cut -d '-' -f 1 <<< "$cluster")

  # Check for awscli
  which aws > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install aws cli (https://aws.amazon.com/cli/)"
    return
  fi

  aws eks update-kubeconfig \
    --alias $cluster \
    --name $cluster \
    --profile $aws_account

  KUBECONFIG=$HOME/.kube/$cluster aws eks update-kubeconfig \
    --alias $cluster \
    --name $cluster \
    --profile $aws_account
}