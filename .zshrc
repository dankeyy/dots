
# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[white]%}[%{$fg[green]%}%n%{$fg[white]%}@%{$fg[green]%}%M %{$fg[blue]%}%~%{$fg[white]%}]%{$reset_color%}$%b "


# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[1 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#tmux
#clear

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#echo $(lsb_release -is) $(uname -srm) 

# Add useful aliases 
alias aup="pamac upgrade --aur"
alias grubup="sudo update-grub"
alias orphaned="sudo pacman -Rns $(pacman -Qtdq)"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias path='echo -e ${PATH//:/\\n}'


#myshit
alias activenv="source /home/qwerty/virtualenvironment/env/bin/activate"
alias xclip="xclip -selection c"
alias kgrepps="sudo -S grepps $1"
alias grep="grep --color=auto"
alias py2="python2"
alias py="python"
alias rm="rm -I"
alias http_here="echo \"RUNNING python -m http.server 8000\" && python -m http.server 8000"
alias getpass="genpass | xclip"
alias tor='~/software/start-tor-browser.desktop'
alias pypy="/home/qwerty/.pyenv/versions/pypy3.6-7.3.1/bin/pypy3"
alias ipy="ipython"
alias jnp="cd ~/jupyter && jupyter-notebook"
alias cps="cat ~/.cps | xclip"
alias hs="ghci"
alias cl="rlwrap sbcl"
alias doom=".emacs.d/bin/doom"
alias ride="cd ~/ride && npm start"
#alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu'
