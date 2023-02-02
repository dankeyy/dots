
(defun c-buffer-config()
    (load! "disaster")
    (setq-local compile-command
        (format "gcc -Wall -Wextra -Wpedantic %s -o %s.out && ./%s.out"
                (shell-quote-argument (buffer-name))
                (file-name-sans-extension (buffer-name))
                (file-name-sans-extension (buffer-name)))))
(add-hook 'c-mode-hook #'c-buffer-config)


(defun cpp-buffer-config()
    (load! "disaster")
    (setq-local compile-command
        (format "g++ -Wall %s -o %s.out && ./%s.out"
                (shell-quote-argument (buffer-name))
                (file-name-sans-extension (buffer-name))
                (file-name-sans-extension (buffer-name)))))
(add-hook 'c++-mode-hook #'cpp-buffer-config)



(defun python-buffer-config ()
  (load! "disaster")
  (local-set-key (kbd "C-c C-f") #'python-shell-send-defun)
  (setq lsp-pyright-use-library-code-for-types t)
  (setq lsp-pyright-stub-path (concat (getenv "HOME") "/dev/pystubs"))

    (setq-local compile-command
        (format "python %s" (shell-quote-argument (buffer-name)))))
(add-hook 'python-mode-hook #'python-buffer-config)


(defun rust-buffer-config ()
        (setq-local compile-command "cargo run"))
(add-hook 'rustic-mode-hook #'rust-buffer-config)


(add-hook 'haskell-mode-hook
    (lambda () (setq-local compile-command "stack run")))


(add-hook 'java-mode-hook
    (lambda () (setq-local compile-command
        (format "javac %s && java %s"
        (shell-quote-argument (buffer-name))
        (file-name-sans-extension (buffer-name))))))


(add-hook 'kotlin-mode-hook
    (lambda () (setq-local compile-command
        (format "kotlinc %s -include-runtime -d %s.jar && java -jar %s.jar"
        (shell-quote-argument (buffer-name))
        (file-name-sans-extension (buffer-name))
        (file-name-sans-extension (buffer-name))))))


(add-hook 'zig-mode-hook
    (lambda ()
      (load! "disaster")
      (setq-local compile-command
        (format "zig run %s"
        (shell-quote-argument (buffer-name))))))
