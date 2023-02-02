
;;; poogle.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 dankey
;;
;; Author: dankey
;; Maintainer: dankey
;; Version: 0.0.1
;; Keywords: python docs jump
;; Homepage: https://github.com/dankeyy/poogle
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;; The code for calling running poogle is  very short (just calling the executable),
;;; so you may just want to put it in your config.
;;; if not then just put this file in your load path and don't forget to load it via your init.el/ config.el.
;;; Function is interactive so of course trigger via M-x poogle or bind it to a key of your choice.
;;
;;
;;; Code:

(defun poogle ()
  "Enter query to jump to in python docs."
  (interactive)

  (shell-command
    (concat "poogle "
            (read-from-minibuffer "Enter Query: "))))


(provide 'poogle)
;;; poogle.el ends here
