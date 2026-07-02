# Initialize Starship prompt
eval "$(starship init zsh)"

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Fastfetch
fastfetch

# Load plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ping="grc ping"
alias ls="eza -a --color=always --group-directories-first --icons"
alias la="eza -la --color=always --group-directories-first --icons"
alias vcupdate='sh -c "$(curl -sS https://vencord.dev/install.sh)"'

alias wallset="~/.config/hypr/scripts/wallset.sh"
alias clock='tty-clock -c -C 4 -r -s -t -f "%A, %B %d"'
export PATH="$HOME/.local/bin:$PATH"
