
sudo pacman -S emacs tmux fish
# use doom, rustup, ghcup install scripts
# copy config files and dirs [.doom.d/, .tmux/, .tmux.conf, .config/fish/ .config/sxhkd]
# comment any sxhkd keybindings starting with alt bc that'll mess up emacs' M commands.
# set closing windows to super + q
# set opening rofi to super + d
# follow libinput-gestures github
# on firefox, in about:config, set accessibility.typeaheadfind.enablesound to false

echo "setxkbmap -option grp:alt_space_toggle us,il &" >> ~/.config/bspwm/bspwmrc

dconf write /org/gnome/desktop/sound/event-sounds "false"
