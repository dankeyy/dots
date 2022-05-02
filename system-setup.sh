
sudo pacman -S emacs tmux fish xorg-xinit
# use doom, rustup, ghcup install scripts
# copy config files and dirs [.doom.d/, .tmux/, .tmux.conf, .config/fish/ .config/sxhkd]
# comment any sxhkd keybindings starting with alt bc that'll mess up emacs' M commands.
# set closing windows to super + q
# set opening rofi to super + d
# follow libinput-gestures github
# on firefox, in about:config, set accessibility.typeaheadfind.enablesound to false

# add to bspwmrc probably, maybe xinitrc so it'll run at autostart
#xset b off
#setxkbmap -option grp:alt_space_toggle us,il -option caps:escape &
#usr/lib/geoclue-2.0/demos/agent &
#redshift-gtk &


# if you're experiencing tearing on the side of the screen,
# try disabling vsync in picom.conf or just not setting shadow=True there


sudo echo "blacklist pcspkr" > /etc/modprobe.d/pcspkr-blacklist.conf
