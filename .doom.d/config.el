;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(add-to-list 'load-path "misc/")

;; compilation hooks
(load! "misc/compilation-hooks.el")


;; garbage collection
(load! "misc/gcmh")
(gcmh-mode 1)


;; topsy
(load! "misc/topsy.el")
(add-hook 'prog-mode-hook #'topsy-mode)


;; jump to snek docs
(load! "misc/poogle.el")


;; font
(setq  doom-font         (font-spec :family "Fira Code"   :size 15))
(setq! doom-unicode-font (font-spec :family "Victor Mono" :size 11))


;; theme
(setq doom-theme 'doom-oceanic-next)


;; just in case..
(setq ring-bell-function 'ignore)
;; (setq x-alt-keysym 'meta)


;; line numbers
(setq display-line-numbers-type 'relative)


;; compile on comint buffer
(defun cc ()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'compile))


;; ma keys
(map! :nv "M-c"        #'cc)
(map! :nv "M-r"        #'recompile)
(map! :nv "M-y"        #'yank-from-kill-ring)
(map! :nv "M-e"        #'iedit-mode)
(map! :nv "M-<escape>" #'keyboard-escape-quit)
(map! :nv "M-s f"      #'find-name-dired)
(map! :nv "C-9"        #'sp-wrap-round)
(map! :nv "C-0"        #'sp-unwrap-sexp)
(map! :nv "SPC d"      #'lsp-describe-thing-at-point)
(map! :nv "SPC k"      #'kill-compilation)
(map! :nv "SPC r r"    #'vr/replace)
(map! :nv "SPC r m"    #'vr/mc-mark)
(map! :nv "SPC r q"    #'vr/query-replace)
(map! :nv "SPC r a"    #'align-regexp)
(map! :nv "SPC c m"    #'kmacro-call-macro)
(map! :nv "SPC p ;"    #'parrot-start-animation)
(map! :nv "SPC s g"    #'poogle)
(map! :nv "SPC g d"    #'vc-msg-show)
(map! :nv "SPC l"      #'(lambda () (interactive) (insert "λ")))


;; company
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil))

(setq company-quickhelp-mode t)
(setq company-idle-delay 0.3)
(setq company-show-quick-access t)
(setq company-mode/enable-yas t)
(add-to-list 'company-backends #'company-yasnippet)
(add-to-list 'company-backends #'company-tabnine)



;; transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 80))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))
;; if on emacs 29, try
;; (set-frame-parameter nil 'alpha-background 0.2)
;; (set-frame-parameter (selected-frame) 'alpha-background 0.5)


;; dired config
(setq dired-kill-when-opening-new-dired-buffer t)
(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))


;; pdf config
(add-hook 'pdf-view-mode-hook
          (lambda ()
            (hide-mode-line-mode)
            (pdf-view-midnight-minor-mode)))


;; scroll with cursor
(setq mwheel-scroll-up-function 'next-line)
(setq mwheel-scroll-down-function 'previous-line)
;; (setf (car mouse-wheel-scroll-amount) 2)
;; (setq mouse-wheel-progressive-speed nil)


;; shell config
(exec-path-from-shell-initialize)
(setq-default explicit-shell-file-name "/bin/bash")


;; and other visual stuff
(setq prettify-symbols-alist '(("lambda" . 955)))


;; most important part of the config
(parrot-mode)

(defun parrot-animate-when-compile-success (buffer result)
  (if (string-match "^finished" result)
      (parrot-start-animation)))
(add-to-list 'compilation-finish-functions 'parrot-animate-when-compile-success)


;; tabs bad
(setq tab-width 4)


;; it's slow im disabling it
(setq lsp-enable-file-watchers 'nil)


;; the visual replacement thingy
(setq vr/engine 'python)


;; fix for icons not displaying in treemacs
(remove-hook 'doom-load-theme-hook #'doom-themes-treemacs-config)


;; adjusted from https://github.com/redguardtoo/vc-msg
;; to make vc-msg's code option use magit
(setq vc-msg-git-show-commit-function 'magit-show-commit)
