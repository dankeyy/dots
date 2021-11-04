;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
 (setq doom-font (font-spec :family "monospace" :size 15 :weight 'semi-bold)
       doom-variable-pitch-font (font-spec :family "sans" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; end of doom configs, my shit below: 

;; theme setting
(setq doom-theme 'doom-city-lights)

;; PATH setting
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL --login -c 'echo $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)


;; multiple-cursors
;(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
;;(global-unset-key (kbd "M-<down-mouse-1>"))
;;(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)


;; transparency
(set-frame-parameter (selected-frame) 'alpha '(92 . 90))
(add-to-list 'default-frame-alist '(alpha . (92 . 90)))


;; smooth scrolling with sublimity
(require 'sublimity)
(require 'sublimity-scroll)
;; (require 'sublimity-map)
(sublimity-mode 1)
(setq sublimity-scroll-weight 3
      sublimity-scroll-drift-length 5)


;; highlight similar occurences
(require 'highlight-symbol)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)


;; treemacs configuration
(treemacs-project-follow-mode)


;;yasnippets
;; (yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)


;; absolute mess of lsp & flychecking, will organize one day
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "/home/dankey"))

(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

(use-package flycheck
 :hook (prog-mode . flycheck-mode))

;;(use-package company
;;  :hook (prog-mode . company-mode)
;;  :config (setq company-tooltip-align-annotations t)
;;          (setq company-minimum-prefix-length 1))

;;(use-package lsp-ui)

;;(use-package toml-mode)

;; (use-package rust-mode
;;  :hook (rust-mode . lsp))

;; Add keybindings for interacting with Cargo
 (use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
 :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;(setq lsp-file-watch-threshold 1000)
;;(require 'flycheck)
 (require 'flycheck-rust)
;;(require 'flycheck-mypy)
;;(require 'flymake)

;;(add-hook 'python-mode-hook 'flycheck-mode)
;;(add-hook 'after-init-hook #'global-flycheck-mode)
;;(add-hook 'python-mode-hook
;;         (lambda ()
;;            (setq flycheck-python-pylint-executable "~/venv/bin/pylint")
;;            (setq flycheck-pylintrc "~/.pylintrc")))

;;(flycheck-add-next-checker 'python-flake8 'python-pylint)

(setq lsp-rust-server 'rust-analyzer)
(use-package rustic
  :hook (rust-mode . lsp))
;; (use-package rust-mode
;;  :hook (rust-mode . lsp))

