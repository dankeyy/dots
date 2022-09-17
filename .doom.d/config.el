;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(add-to-list 'load-path "misc/")

;; font
(setq doom-font (font-spec :family "Fira Code" :size 15))
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
(map! :nv "M-c" #'cc)
(map! :nv "M-y" #'yank-from-kill-ring)
(map! :nv "M-v" #'recompile)
(map! :nv "M-e" #'iedit-mode)
(map! :nv "M-<escape>" #'keyboard-escape-quit)
(map! :nv "M-s f" #'find-name-dired)
(map! :nv "C-9" #'sp-wrap-round)
(map! :nv "C-0" #'sp-unwrap-sexp)
(map! :nv "SPC d" #'lsp-describe-thing-at-point)
(map! :nv "SPC k" #'kill-compilation)
(map! :nv "SPC r" #'vr/replace)
(map! :nv "SPC c m" #'kmacro-call-macro)
(map! :nv "SPC p ;" #'parrot-start-animation)
(map! :nv "SPC s g" #'poogle)
(map! :nv "SPC l" #'(lambda () (interactive) (insert "λ")))


(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "M-TAB") #'company-complete-selection))



;; transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 80))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))
;; if on emacs 29, try
;; (set-frame-parameter nil 'alpha-background 0.2)
;; (set-frame-parameter (selected-frame) 'alpha-background 0.5)


;; compilation hooks
(load! "misc/compilation-hooks.el")


;; garbage collection
(load! "misc/gcmh") ; should be in misc/
(gcmh-mode 1)


(load! "misc/topsy.el")
(add-hook 'prog-mode-hook #'topsy-mode)

;; dap config, see: https://emacs-lsp.github.io/dap-mode/page/configuration/
(setq dap-auto-configure-features '(sessions locals controls tooltip))


;; jumps to py docs
(load! "misc/poogle.el")

;; dired config
(setq dired-kill-when-opening-new-dired-buffer t)
(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))

;; pdf reading config
(add-hook 'pdf-view-mode-hook (lambda ()
                                (hide-mode-line-mode)
                                (pdf-view-midnight-minor-mode)))


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


;; and other visual stuff
(setq prettify-symbols-alist '(("lambda" . 955)))

(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


;;; * Highlight ansi escape sequences in exported buffers
;;;###autoload
(defun +eshell-ansi-buffer-output (fun object target)
  "Interpret ansi escape sequences when redirecting to buffer."
  (let* ((buf (and (markerp target) (marker-buffer target)))
         (str (and buf (stringp object) (string-match-p "\e\\[" object) object)))
    (funcall fun (if str str object) target)
    (when buf
      (with-current-buffer buf
        (goto-char (point-min))
        ;; For some reason applying this on the string and then inserting the
        ;; colorized string is not the same as colorizing the region.
        (ansi-color-apply-on-region (point-min) (point-max))
        (font-lock-mode)
        (pop-to-buffer buf)))))
(advice-add #'eshell-output-object-to-target :around #'+eshell-ansi-buffer-output)



;; most important part of the config
(parrot-mode)

(defun parrot-animate-when-compile-success (buffer result)
  (if (string-match "^finished" result)
      (parrot-start-animation)))
(add-to-list 'compilation-finish-functions 'parrot-animate-when-compile-success)


;; tabs | spaces
(setq tab-width 4)

(setq lsp-enable-file-watchers 'nil)
(setq vr/engine 'python)


(add-hook 'prog-mode-hook #'highlight-indent-guides-mode)
