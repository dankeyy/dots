
(defun c-buffer-config()
    (load! "disaster")
    (setq-local compile-command
        (format "gcc -Wall %s -o %s && ./%s"
                (shell-quote-argument (buffer-name))
                (file-name-sans-extension (buffer-name))
                (file-name-sans-extension (buffer-name)))))
(add-hook 'c-mode-hook #'c-buffer-config)

(defun cpp-buffer-config()
    (load! "disaster")
    (setq-local compile-command
        (format "g++ -Wall %s -o %s && ./%s"
                (shell-quote-argument (buffer-name))
                (file-name-sans-extension (buffer-name))
                (file-name-sans-extension (buffer-name)))))
(add-hook 'c++-mode-hook #'cpp-buffer-config)

(defun python-buffer-config ()
    ;; (add-hook 'after-save-hook '(lambda () (mark-whole-buffer) (string-inflection-python-style-cycle))))
    (setq-local compile-command
        (format "python %s" (shell-quote-argument (buffer-name)))))
(add-hook 'python-mode-hook #'python-buffer-config)

        ;; (dap-register-debug-template "Ma Rust Debug Template"
        ;;         (list :type "cppdbg"
        ;;         :request "launch"
        ;;         :name "Rust::Run"
        ;;         :MIMode "gdb"
        ;;         :miDebuggerPath "rust-gdb"
        ;;         :environment []
        ;;         :program "${workspaceFolder}/target/debug/${workspaceFolder}"
        ;;         :cwd "${workspaceFolder}"
        ;;         :console "external"
        ;;         :dap-compilation "cargo build"
        ;;         :dap-compilation-dir "${workspaceFolder}")))

(require 'dap-cpptools)
(defun rust-buffer-config ()
        (setq-local compile-command "cargo run"))
        ;; (require 'dap-gdb-lldb)

        ;; (setq cargo-root (projectile-project-root))
        ;; (setq rust-exe (file-name-sans-extension (buffer-name)))

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
    (lambda () (setq-local compile-command
        (format "zig build-exe %s && ./%s"
        (shell-quote-argument (buffer-name))
        (file-name-sans-extension (buffer-name))))))
