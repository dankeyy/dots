;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

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
;; (setq doom-font (font-spec :family "Hack" :size 15 :weight 'semi-bold)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 14))
(setq doom-font (font-spec :family "Fira Code" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq ring-bell-function 'ignore)
(setq x-alt-keysym 'meta)
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

(setq doom-theme 'doom-city-lights)

;; ma keys
(map! :nv "M-e" #'eshell)
(map! :nv "M-s f" #'find-name-dired)
(map! :nv "C-9" #'sp-wrap-round)
(map! :nv "C-0" #'sp-unwrap-sexp)
(map! :nv "SPC d" #'lsp-describe-thing-at-point)
(map! :nv "SPC k" #'kill-compilation)
(map! :nv "SPC l" #'(lambda () (interactive) (insert "λ")))
(map! :nv "SPC r" #'vr/replace)
;; transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 80))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))


;; dap config, see: https://emacs-lsp.github.io/dap-mode/page/configuration/
(setq dap-auto-configure-features '(sessions locals controls tooltip))

;; hooks for different langs
(defun c-buffer-config()
    (load! "misc/disaster")
    (setq-local compile-command
        (format "gcc -Wall %s -o %s && ./%s"
                (shell-quote-argument (buffer-name))
                (file-name-sans-extension (buffer-name))
                (file-name-sans-extension (buffer-name)))))
(add-hook 'c-mode-hook #'c-buffer-config)

(defun cpp-buffer-config()
    (load! "misc/disaster")
    (setq-local compile-command
        (format "g++ -Wall %s -o %s && ./%s"
                (shell-quote-argument (buffer-name))
                (file-name-sans-extension (buffer-name))
                (file-name-sans-extension (buffer-name)))))
(add-hook 'c++-mode-hook #'cpp-buffer-config)

(defun python-buffer-config ()
    (setq-local compile-command
        (format "python %s" (shell-quote-argument (buffer-name)))))
(add-hook 'python-mode-hook #'python-buffer-config)


(defun rust-buffer-config ()
        (setq-local compile-command "cargo run")
        (require 'dap-cpptools)
        (require 'dap-gdb-lldb)

        (setq cargo-root (projectile-project-root))
        (setq rust-exe (file-name-sans-extension (buffer-name)))

        (dap-register-debug-template "Ma Rust Debug Template"
                (list :type "cppdbg"
                :request "launch"
                :name "Rust::Run"
                :MIMode "gdb"
                :miDebuggerPath "rust-gdb"
                :environment []
                :program "${workspaceFolder}/target/debug/${workspaceFolder}"
                :cwd "${workspaceFolder}"
                :console "external"
                :dap-compilation "cargo build"
                :dap-compilation-dir "${workspaceFolder}")))
(add-hook 'rustic-mode-hook #'rust-buffer-config)


(add-hook 'haskell-mode-hook
    (lambda () (setq-local compile-command "stack run")))


(add-hook 'java-mode-hook
    (lambda () (setq-local compile-command
        (format "javac %s && java %s"
        (shell-quote-argument (buffer-name))
        (file-name-sans-extension (buffer-name))))))


;; dired
(setq dired-kill-when-opening-new-dired-buffer t)


;; eshell aliases
(defun eshell-add-aliases ()
    (dolist (var '(
        ("ff" "find-file $1")
        ("xclip" "xclip -selection c")
        ("kgrepps" "sudo -S grepps $1")
        ("grep" "grep --color=auto")
        ("py2" "python2")
        ("py" "python")
        ("rm" "rm -I")
        ("httphere" "echo \"RUNNING python -m http.server 8000\" && python -m http.server 8000")
        ("getpass" "genpass | xclip")
        ("ipy" "ipython")
        ("jnp" "cd ~/jupyter && jupyter-notebook")
        ("hs" "ghci")
        ("cl" "rlwrap sbcl")
        ("doom" ".emacs.d/bin/doom")
        ("ride" "cd ~/ride && npm start")
        ("aup" "pamac upgrade --aur")
        ("grubup" "sudo update-grub")
        ("fixpacman" "sudo rm /var/lib/pacman/db.lck")
        ("en" "emacs -nw")
        ("v" "vim")
        ("i" "sudo pacman -S")
        ("up" "sudo pacman -Syyu")
        ("dut" "youtube-dl --extract-audio --audio-format mp3")
        ("ec" "emacsclient -c")
        ("et" "emacsclient -t")
        ("l" "ls -lah")
        ("c" "clear 1")
        ("gd" "git diff")
        ("tb" "nc termbin.com 9999")
        ("intcode" "intcode/target/release/intcode")
        ("ocaml" "rlwrap ocaml")
        ("e" "exa -lah --icons")
        ("def" "xdg-open")
        ("fm" "pcmanfm")
        ("st" "git status")
    (add-to-list 'eshell-command-aliases-list var)))
(add-hook 'eshell-post-command-hook 'eshell-add-aliases)))

(add-hook 'circe-mode (lambda () (company-mode)))

(add-to-list 'company-backends #'company-yasnippet)

(setq mwheel-scroll-up-function 'next-line)
(setq mwheel-scroll-down-function 'previous-line)
;; (setf (car mouse-wheel-scroll-amount) 2)
;; (setq mouse-wheel-progressive-speed nil)
