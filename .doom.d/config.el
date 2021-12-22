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
(setq doom-theme 'doom-rouge)


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
;(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

;; eshell shortcut
(map! :nv "M-e" #'eshell)

;; transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 80))
(add-to-list 'default-frame-alist '(alpha . (90 . 80)))


;; highlight similar occurences
(add-hook 'prog-mode-hook 'highlight-symbol-mode)


;; treemacs
(setq treemacs-project-follow-mode 1)
;; (setq doom-themes-treemacs-theme "doom-colors")


;; general lsp config
;; (debug-on-entry 'lsp--ask-about-watching-big-repo)


;; dap config, see: https://emacs-lsp.github.io/dap-mode/page/configuration/
(require 'dap-cpptools)

(require 'dap-python)

(dap-register-debug-template "Rust::GDB Run Configuration"
                             (list :type "gdb"
                                   :request "launch"
                                   :name "GDB::Run"
                           :gdbpath "rust-gdb"
                                   :target nil
                                   :cwd nil))

;; compilation hooks
(add-hook 'rustic-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 "cargo run")))

(add-hook 'c-mode-hook
        (lambda ()
        (setq-local compile-command
                    (format "gcc -Wall %s -o %s && ./%s"
                            (shell-quote-argument (buffer-name))
                            (file-name-sans-extension (buffer-name))
                            (file-name-sans-extension (buffer-name))))))

;; (add-hook 'c++-mode-hook
;;         (setq-local compile-command
;;               (format "g++ -std=c++17 -Wall %s -o a.out && ./a.out" (shell-quote-argument (buffer-name)))))

(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "python %s" (shell-quote-argument (buffer-name))))))


(add-hook 'haskell-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 "stack run")))

(add-hook 'java-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "javac %s && java %s"
                         (shell-quote-argument (buffer-name))
                         (file-name-sans-extension (buffer-name))))))
