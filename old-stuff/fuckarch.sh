#!/bin/bash

sudo rm -r /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy gnupg archlinux-keyring
sudo pacman-key --refresh-keys
