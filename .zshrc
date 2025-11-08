# Initialize Starship prompt
eval "$(starship init zsh)"

# Fastfetch
fastfetch

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Load plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# Tmux autostart
if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then
    if tmux has-session -t default 2>/dev/null; then
        exec tmux attach -t default
    else
        exec tmux new -s default
    fi
fi

# Cross-distro bat command and preview function
if command -v batcat &> /dev/null; then
    alias bat="batcat"
    BAT_PREVIEW="batcat --color=always --style=numbers"
elif command -v bat &> /dev/null; then
    BAT_PREVIEW="bat --color=always --style=numbers"
else
    BAT_PREVIEW="cat"
fi

# GRC and EZA aliases
alias ping="grc ping"
alias nmap="grc nmap"
alias ls="eza -a --color=always --group-directories-first --icons"
alias la="eza -la --color=always --group-directories-first --icons"

# CTF aliases
alias thm_au='sudo openvpn "$PATH_THM_AU"'
alias thm_us_vip='sudo openvpn "$PATH_THM_US_VIP"'
alias thm_eu_vip='sudo openvpn "$PATH_THM_EU_VIP"'
alias check_thm="curl 10.10.10.10/whoami"
alias htb_academy_us='sudo openvpn "$PATH_HTB_ACADEMY_US"'
alias htb_sp_us='sudo openvpn "$PATH_HTB_SP_US"'
alias htb_au='sudo openvpn "$PATH_HTB_AU"'

# FZF aliases
alias fzf="fzf --preview \"$BAT_PREVIEW {}\" --preview-window=right,65%"
alias fvim="nvim \$(fzf --preview \"$BAT_PREVIEW {}\" --preview-window=right,65%)"
alias clear='printf "\\033_Ga=d\\033\\\\"; clear'

# Other important aliases
alias emby="sudo systemctl start emby-server.service"

# IPTables
alias lockhost="sudo iptables -A INPUT -i virbr1 -s 10.0.0.0/24 -j DROP"
alias unlockhost="sudo iptables -D INPUT -i virbr0 -s 192.168.122.0/24 -j DROP"
