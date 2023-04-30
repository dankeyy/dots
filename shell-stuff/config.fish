function fish_greeting
    fortune
end


function zigbench
    zig build-obj $argv[1] -femit-asm=- | llvm-mca
end

function bench
    set -l metrics -e task-clock -e page-faults -e cycles -e stalled-cycles-frontend
    set metrics $metrics -e stalled-cycles-backend -e instructions -e branches -e branch-misses -e cache-references -e cache-misses
    perf stat $metrics $argv
end


function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end


function fish_user_key_bindings
  fish_hybrid_key_bindings
  bind -M insert ! bind_bang
  bind -M insert '$' bind_dollar
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
alias v="lvim"
alias i="sudo pacman -S"
alias up="sudo pacman -Syyu"
alias dut="youtube-dl --extract-audio --audio-format mp3"
alias ec="emacsclient -c"
alias et="emacsclient -t"
alias l="ls -lah"
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
alias c="z"
alias val="valgrind --tool=memcheck --leak-check=yes --leak-check=full"
alias pf="fzf --preview='bat {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
alias o="objdump -drwC -Mintel --visualize-jumps=color"

set -gx PATH $HOME/.local/bin $PATH
set -U fish_user_paths /home/dankey/dev/depot_tools $fish_user_paths
set -U fish_user_paths /home/dankey/dev/ELFkickers/bin $fish_user_paths

set -Ux COLUMNS 85

starship init fish | source
direnv hook fish | source
zoxide init fish | source
