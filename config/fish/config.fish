function fish_greeting
    fortune
end

alias xclip="xclip -selection c"
alias kgrepps="sudo -S grepps $1"
alias grep="grep --color=auto"
alias py2="python2"
alias py="python"
alias rm="rm -I"
alias http_here="echo \"RUNNING python -m http.server 8000\" && python -m http.server 8000" 
alias getpass="genpass | xclip"
alias ipy="ipython"
alias jnp="cd ~/jupyter && jupyter-notebook"
alias hs="ghci"
alias cl="rlwrap sbcl"
alias doom=".emacs.d/bin/doom"
alias ride="cd ~/ride && npm start"
alias aup="pamac upgrade --aur"
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias en="emacs -nw"
alias v="vim"
alias i="sudo pacman -S"
alias up="sudo pacman -Syyu"
alias dut="youtube-dl --extract-audio --audio-format mp3"
alias ec="emacsclient -c"
alias et="emacsclient -t"
alias l="ls -lah"
alias c="clear"
alias gd="git diff"
alias tb="nc termbin.com 9999"
alias intcode="intcode/target/release/intcode"
alias ocaml="rlwrap ocaml"
alias e="exa -lah --icons"
alias exa="exa --icons"
alias def="xdg-open"
alias fm="pcmanfm"
alias st="git status"
#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/dankey/.ghcup/bin $PATH # ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/dankey/.ghcup/bin $PATH # ghcup-env
set -gx PATH $HOME/.local/bin $PATH

starship init fish | source
