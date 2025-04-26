eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$(brew --prefix python)/libexec/bin:$PATH"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
