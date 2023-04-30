;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(add-to-list 'load-path "misc/")
(add-to-list 'load-path "misc/bqn-mode/")
(load! "misc/lang-hooks.el")
(load! "misc/poogle.el") ;; jump to snek docs
(load! "misc/topsy.el")  ;; shows topmost definition
(load! "misc/gcmh.el")   ;; garbage collection

;; that's dumb af
;; (load! "misc/bqn-mode/bqn-symbols.el")
;; (load! "misc/bqn-mode/bqn-symbols-doc.el")
;; (load! "misc/bqn-mode/bqn-syntax.el")
;; (load! "misc/bqn-mode/bqn-backslash.el")
;; (load! "misc/bqn-mode/bqn-help.el")
;; (load! "misc/bqn-mode/bqn-comint.el")
;; (load! "misc/bqn-mode/bqn-glyphs.el")
;; (load! "misc/bqn-mode/bqn-input.el")
;; (load! "misc/bqn-mode/bqn-keyboard.el")
;; (load! "misc/bqn-mode/bqn-mode.el")

(gcmh-mode 1)
(add-hook 'prog-mode-hook #'topsy-mode)


;; how stuff looks
(setq doom-theme 'doom-henna)

(setq  doom-font         (font-spec :family "FiraCode Nerd Font"   :size 14))
;(setq! doom-unicode-font (font-spec :family "BQN386" :size 14))

(setq display-line-numbers-type 'relative)


;; just in case..
(setq ring-bell-function 'ignore)


;; compile on comint buffer
(defun cc ()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'compile))

;; cursed ik
(defun simulate-esc ()
  (interactive)
  (execute-kbd-macro (kbd "<escape>")))

(defun project-find-regexp-universal ()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'project-find-regexp))


;; ma keys
(map! :nv "M-c"        #'cc)
(map! :nv "M-r"        #'recompile)
(map! :nv "M-y"        #'yank-from-kill-ring)
(map! :nv "M-p"        #'mark-paragraph)
(map! :nv "M-e"        #'iedit-mode)
(map! :nv "M-?"        #'lsp-ui-peek-find-references)
(map! :nv "M-."        #'lsp-ui-peek-find-definitions)
(map! :nv "M-<escape>" #'keyboard-escape-quit)
(map! :nv "M-s f"      #'find-name-dired)
(map! :nv "C-9"        #'sp-wrap-round)
(map! :nv "C-0"        #'sp-unwrap-sexp)
(map! :nv "SPC d a"    #'disaster)
(map! :nv "SPC d j"    #'disaster-jump)
(map! :nv "SPC d t"    #'lsp-describe-thing-at-point)
(map! :nv "SPC k"      #'kill-compilation)
(map! :nv "SPC r r"    #'vr/replace)
(map! :nv "SPC r m"    #'vr/mc-mark)
(map! :nv "SPC r q"    #'vr/query-replace)
(map! :nv "SPC r a"    #'align-regexp)
(map! :nv "SPC c m"    #'kmacro-call-macro)
(map! :nv "SPC p ;"    #'parrot-start-animation)
(map! :nv "SPC s g"    #'poogle)
(map! :nv "SPC g d"    #'vc-msg-show)
(map! :nv "g b"        #'pop-global-mark)
(map! :nv "SPC r t"    #'string-rectangle)
(map! :nv "SPC r k"    #'kill-rectangle)
(map! :nv "SPC s c"    #'async-shell-command)
(map! :nv "C-y"        #'yank)
(map! :nv "C-l"        #'recenter-top-bottom)
(map! :nv "SPC l"      #'(lambda () (interactive) (insert "λ")))
(map! :leader "s m"    #'(lambda () (interactive) (rectangle-mark-mode) (simulate-esc) (simulate-esc))) ;; set mark for rectangle-mode, very hacky but works
(map! :leader "/"      #'project-find-regexp-universal)

;; company
;;(with-eval-after-load 'company
;;  (define-key company-active-map (kbd "<return>") nil)
;;  (define-key company-active-map (kbd "RET") nil)
;;  (define-key company-active-map (kbd "M-q") #'company-complete-selection))

(setq company-quickhelp-mode t)
(setq company-idle-delay 0.2)
(setq company-show-quick-access t)
(setq company-mode/enable-yas t)
(add-to-list 'company-backends #'company-yasnippet)
(add-to-list 'company-backends #'company-tabnine)


;; transparency
;; (set-frame-parameter (selected-frame) 'alpha '(90 . 80))
;; (add-to-list 'default-frame-alist '(alpha . (85 . 85)))
;; if on emacs 29, try
;; (set-frame-parameter nil 'alpha-background 0.2)
;; (set-frame-parameter (selected-frame) 'alpha-background 0.5)


;; dired config
(setq dired-kill-when-opening-new-dired-buffer t)
(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))
(setq dired-dwim-target t)

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


;; most important part of the config
(parrot-mode)

(defun parrot-animate-when-compile-success (buffer result)
  (if (string-match "^finished" result)
      (parrot-start-animation)))
(add-to-list 'compilation-finish-functions 'parrot-animate-when-compile-success)


;; tabs bad
(setq tab-width 4)


;; the visual replacement thingy
(setq vr/engine 'python)


;; fix for icons not displaying in treemacs
(remove-hook 'doom-load-theme-hook #'doom-themes-treemacs-config)


;; adjusted from https://github.com/redguardtoo/vc-msg
;; to make vc-msg's code option use magit
(setq vc-msg-git-show-commit-function 'magit-show-commit)

;; line textwrap
(global-visual-line-mode t)


;; dots for whitespace
(setq whitespace-face 'shadow)
(setq whitespace-style '(face spaces space-mark))
(setq whitespace-display-mappings '((space-mark 32 [183] [46])))
(global-whitespace-mode)


;; realgud settings
(setq realgud-safe-mode nil)

;; enable hyperlinks
(add-to-list 'comint-output-filter-functions 'comint-osc-process-output)


;; lsp config
(setq lsp-ui-doc-delay 0)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-show-with-mouse t)
(setq lsp-ui-doc-position 'top)
(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-doc-max-width 90)
(setq lsp-ui-doc-max-height 20)
