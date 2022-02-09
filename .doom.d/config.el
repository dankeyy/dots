;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(let ((file-name-handler-alist nil))
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
 (setq doom-font (font-spec :family "Hack" :size 15 :weight 'semi-bold)
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
(setq doom-theme 'doom-dracula)


;; PATH setting
;; (defun set-exec-path-from-shell-PATH ()
;;   "Set up Emacs' `exec-path' and PATH environment variable to match
;; that used by the user's shell.

;; This is particularly useful under Mac OS X and macOS, where GUI
;; apps are not started from a shell."
;;   (interactive)
;;   (let ((path-from-shell (replace-regexp-in-string
;; 			  "[ \t\n]*$" "" (shell-command-to-string
;; 					  "$SHELL --login -c 'echo $PATH'"
;; 						    ))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))

;; (set-exec-path-from-shell-PATH)


;; multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)


;; eshell shortcut
(map! :nv "M-e" #'eshell)

;; find -name shortcut
(map! :nv "M-s f" #'find-name-dired)

;; parens
(map! :nv "C-9" #'sp-wrap-round)
(map! :nv "C-0" #'sp-unwrap-sexp)

(map! :nv "SPC d" #'lsp-describe-thing-at-point)
(map! :nv "SPC k" #'kill-compilation)

;; transparency
(set-frame-parameter (selected-frame) 'alpha '(99 . 80))
(add-to-list 'default-frame-alist '(alpha . (95 . 80)))


;; highlight similar occurences
;; (highlight-symbol-mode t)
;; (use-package dap-cpptools)

;; dap config, see: https://emacs-lsp.github.io/dap-mode/page/configuration/
(add-hook 'dap-mode-hook
          (lambda()
                (setq dap-auto-configure-features '(sessions locals controls tooltip))
                (dap-ui-mode 1)
                (dap-tooltip-mode 1)
                (tooltip-mode 1)
                (dap-ui-controls-mode 1)))


;; lsp shit
;; (setq read-process-output-max (* 1024 1024))
;; (setq lsp-enable-file-watchers t)
;; (setq lsp-file-watch-threshold 30000)


;; hooks for different langs
(defun ccpp-buffer-config()
  (load! "misc/disaster")
  (setq-local compile-command
        (format "gcc -Wall %s -o %s && ./%s"
                (shell-quote-argument (buffer-name))
                (file-name-sans-extension (buffer-name))
                (file-name-sans-extension (buffer-name)))))

(add-hook 'c-mode-hook #'ccpp-buffer-config)
(add-hook 'c++-mode-hook #'ccpp-buffer-config)


(defun python-buffer-config ()
        (setq-local compile-command
                (format "python %s" (shell-quote-argument (buffer-name)))))
        ;; (use-package dap-python :defer 2))

(add-hook 'python-mode-hook #'python-buffer-config)

;; (setq fancy-splash-image (concat doom-private-dir "misc/donkey2.jpg"))

(defun rust-buffer-config ()
        (setq-local compile-command "cargo run"))

;; (dap-register-debug-template "Rust::GDB Run Configuration"
;;         (list :type "gdb"
;;                 :request "launch"
;;                 :name "GDB::Run"
;;                 :gdbpath "rust-gdb"
;;                 :target nil
;;                 :cwd nil))

(add-hook 'rustic-mode-hook #'rust-buffer-config)


(add-hook 'haskell-mode-hook
          (lambda () (setq-local compile-command "stack run")))


(add-hook 'java-mode-hook
          (lambda ()
            (setq-local compile-command
                 (format "javac %s && java %s"
                         (shell-quote-argument (buffer-name))
                         (file-name-sans-extension (buffer-name))))))


;; vterm fix
;; (use-package vterm
;;   :load-path  "~/.emacs.d/straight/repos/emacs-libvterm")


)
