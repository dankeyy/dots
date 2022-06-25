;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(add-to-list 'load-path "misc/")

;; font
(setq doom-font (font-spec :family "Fira Code" :size 15))
(setq! doom-unicode-font (font-spec :family "Victor Mono" :size 11))

;; theme
(setq doom-theme 'doom-city-lights)

;; just in case..
(setq ring-bell-function 'ignore)
(setq x-alt-keysym 'meta)

;; line numbers
(setq display-line-numbers-type 'relative)


;; ma keys
(map! :nv
    "M-e" #'eshell
    "M-s f" #'find-name-dired
    "C-9" #'sp-wrap-round
    "C-0" #'sp-unwrap-sexp
    "SPC d" #'lsp-describe-thing-at-point
    "SPC k" #'kill-compilation
    "SPC r" #'vr/replace
    "SPC c m" #'kmacro-call-macro
    "SPC p ;" #'parrot-start-animation
    "SPC l" #'(lambda () (interactive) (insert "λ")))


;; transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 80))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))
;; if on emacs 29, try
;; (set-frame-parameter nil 'alpha-background 0.2)
;; (set-frame-parameter (selected-frame) 'alpha-background 0.5)


;; compilation hooks
(load! "compilation-hooks.el")


;; garbage collection
(load! "gcmh") ; should be in misc/
(gcmh-mode 1)


;; dap config, see: https://emacs-lsp.github.io/dap-mode/page/configuration/
(setq dap-auto-configure-features '(sessions locals controls tooltip))


;; dired config
(setq dired-kill-when-opening-new-dired-buffer t)


;; pdf reading config
(add-hook 'pdf-view-mode-hook (lambda ()
                                (hide-mode-line-mode)
                                (pdf-view-midnight-minor-mode)))
;;                                 (pdf-outline)
;;                                 (pdf-outline-toggle-subtree)))


;; company mode
(setq company-quickhelp-mode t)
(setq company-idle-delay 0)
(setq company-show-quick-access t)
(add-to-list 'company-backends #'company-yasnippet)
(add-to-list 'company-backends #'company-tabnine)


;; telega
(setq telega-chat-show-deleted-messages-for '(not saved-messages))


;; scroll with cursor
(setq mwheel-scroll-up-function 'next-line)
(setq mwheel-scroll-down-function 'previous-line)
;; (setf (car mouse-wheel-scroll-amount) 2)
;; (setq mouse-wheel-progressive-speed nil)


;; shell config
(exec-path-from-shell-initialize)
(setq-default explicit-shell-file-name "/bin/bash")


;; most important part of the config
(setq parrot-mode t)


;; and other visual stuff
(setq prettify-symbols-alist '(("lambda" . 955)))

(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(defun parrot-animate-when-compile-success (buffer result)
  (if (string-match "^finished" result)
      (parrot-start-animation)))
(add-to-list 'compilation-finish-functions 'parrot-animate-when-compile-success)
