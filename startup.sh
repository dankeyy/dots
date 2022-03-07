#!/bin/bash

systemctl --user enable --now emacs && systemctl --user start emacs.service 
systemctl enable bluetooth.service
