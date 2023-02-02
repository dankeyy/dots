function fish_greeting
    fortune
end

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
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
alias c="calc"
alias gd="git diff"
alias tb="nc termbin.com 9999"
alias intcode="intcode/target/release/intcode"
alias ocaml="rlwrap ocaml"
alias e="exa -lah --icons"
alias exa="exa --icons"
alias def="xdg-open"
alias pip="pip3"
alias fm="pcmanfm"
alias st="git status"
alias ct="~/Desktop/Cutter-v2.0.5-x64.Linux.AppImage"
alias d8="rlwrap ~/dev/v8/v8/out/x64.debug/d8 --allow-natives-syntax"
alias hebk="setxkbmap -option grp:lalt_lshift_toggle us,il -option caps:escape"
alias bqnk="setxkbmap -option grp:lalt_lshift_toggle us,bqn -option caps:escape"

set -gx PATH $HOME/.local/bin $PATH
set -U fish_user_paths /home/dankey/dev/depot_tools $fish_user_paths
set -U fish_user_paths /home/dankey/dev/ELFkickers/bin $fish_user_paths

export DOCKER_HOST=unix:///var/run/docker.sock

starship init fish | source
direnv hook fish | source
