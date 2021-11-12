# ~/.config/fish/config.fish
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

