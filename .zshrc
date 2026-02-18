# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ensure terminal advertises color support for all shells
export COLORTERM="truecolor"
export TERM="xterm-256color"
unset NO_COLOR 2>/dev/null || true

# Fastfetch solo se shell interattiva e terminal pronto
# Note: iTerm2 must have Profile → Terminal → "Report Terminal Type" set to ANSI
# for fastfetch to display colors correctly
if [[ -o interactive ]] && [[ -z "$FASTFETCH_RUN" ]] && command -v fastfetch >/dev/null; then
  # only run when stdout is a terminal and TERM is not dumb
  if [[ -t 1 ]] && [[ "$TERM" != "dumb" ]]; then
    # prefer iTerm readiness: require LC_TERMINAL or TERM_PROGRAM
      # wait briefly for terminal to populate identifying env vars (avoid VSCode/Code Helper)
      for _ in {1..10}; do
        if [[ -n "$LC_TERMINAL" ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
          fastfetch --config ~/.config/fastfetch/config.jsonc \
            --pipe false --color-output cyan --color-keys yellow --color-title magenta --bright-color true
          FASTFETCH_RUN=1
          break
        fi
        sleep 0.05
      done
  fi
fi



# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


# User configuration
export EDITOR='code'

# Aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Silenzia l'avviso di output durante l'inizializzazione
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet