(use-package haskell-mode
  :ensure t
  :init
  (autoload 'ghc-init "ghc" nil t)
  (autoload 'ghc-debug "ghc" nil t)
  :config
  (let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
    (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
    (add-to-list 'exec-path my-cabal-path))
  (let ((my-ghc-path (expand-file-name "~/Development/bin/ghc/bin/")))
    (setenv "PATH" (concat my-ghc-path path-separator (getenv "PATH")))
    (add-to-list 'exec-path my-ghc-path))
  (add-to-list 'load-path "~/Documents/Code_Repository/haskell/haskell_libs/ghc-mod-5.4.0.0/elisp")
  (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
  (add-hook 'haskell-mode-hook (lambda () (define-key haskell-mode-map (kbd "C-c ?") 'helm-ghc-errors)))
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  (add-hook 'haskell-mode-hook 'subword-mode)
  (add-hook 'haskell-mode-hook 'haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
  (add-hook 'haskell-mode-hook 'turn-on-smartparens-mode)
  (add-hook 'haskell-mode-hook 'rainbow-delimiters-mode-enable)
  (add-hook 'haskell-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook #'hindent-mode)
  ;; (add-hook 'haskell-mode-hook 'haskell-indent-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (custom-set-variables '(haskell-tags-on-save t)
                        '(haskell-process-suggest-remove-import-lines t))
  (setq ghc-display-error 'minibuffer)
  (setq haskell-interactive-popup-errors 'nil)
  (bind-keys :map haskell-mode-map
             ("C-c C-l" . haskell-process-load-or-reload)
             ("C-c C-z" . haskell-interactive-switch)
             ("C-c C-n C-t" . haskell-process-do-type)
             ("C-c C-n C-i" . haskell-process-do-info)
             ("C-c C-n C-c" . haskell-cabal-build)
             ("C-c C-n c" . haskell-process-cabal)
             ("C-c C-o" . haskell-compile)
             ("C-c C-." . haskell-format-imports)
             ("C-c ." . haskell-indent-align-guards-and-rhs)
             ("C-c TAB" . ghc-insert-template-or-signature)
             ("C-c C-u" . eod-haskell-mode-insert-undefined-at-point)
             ("C-c i d" . eod-haskell-insert-doc)
             ("M-s" . haskell-sp-splice-sexp)
             ("M-(" . haskell-wrap-with-paren-pair-and-fix-indent)
             ("M-g M-p" . ghc-goto-prev-error)
             ("M-g M-n" . ghc-goto-next-error)
             ("M-g h M-p" . ghc-goto-prev-hole)
             ("M-g h M-n" . ghc-goto-next-hole)
             ([f8] . haskell-navigate-imports)
             ([f12] . haskell-simple-run)
             ("C-c C-n h" . hoogle)
             ("C-c v c" . haskell-cabal-visit-file)
             ("SPC" . haskell-mode-contextual-space)))

(use-package haskell-process)

(use-package haskell-font-lock)

(use-package hindent
  :ensure t
  :config
  (setq hindent-style "johan-tibell"))

;; (define-key shm-map (kbd "C-c C-s") 'shm/case-split)

(use-package company-ghc
  :ensure t
  :config
  (add-to-list 'company-backends 'company-ghc))
(use-package company-cabal
  :ensure t
  :config
  (add-to-list 'company-backends 'company-cabal))

(defun haskell-wrap-with-paren-pair-and-fix-indent (&optional arg)
  "Wrap the number 'ARG' of words/sexps thing at point with some give delimiter."
  (interactive "P")
  (sp-wrap-with-pair "(")
  (haskell-indentation-indent-backwards))

(defun eod-haskell-mode-insert-undefined-at-point ()
  "Insert undefined at point, you lazy schmuck!"
  (interactive)
  (when (eq major-mode 'haskell-mode)
    (insert "undefined")))

(defun eod-haskell-insert-doc ()
  "Insert the documentation syntax."
  (interactive)
  (when (eq major-mode 'haskell-mode)
    (insert "-- | ")))

(defun haskell-sp-splice-sexp (&optional arg)
  "Requisite documentation ARG!"
  (interactive "p")
  (sp-splice-sexp arg)
  (haskell-indentation-indent-backwards))

(defun haskell-simple-run ()
  "Run the current haskell file with the program \"runhaskell\"."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when (eq major-mode 'haskell-mode)
      (async-shell-command
       (concat "runhaskell "
               filename)))))

(defun haskell-auto-insert-module-template ()
  "Insert a module template for the newly created buffer."
  (interactive)
  (when (and (= (point-min)
                (point-max))
             (buffer-file-name))
    (insert
     "-- | "
     "\n"
     "\n"
     "module "
     )
    (let ((name (haskell-guess-module-name)))
      (if (string= name "")
          (insert "Main")
        (insert name)))
    (insert " where"
            "\n"
            "\n"
            )
    (goto-char (point-min))
    (forward-char 4)))

(add-hook 'inferior-haskell-mode-hook 'subword-mode)
(add-hook 'inferior-haskell-mode-hook 'turn-on-smartparens-mode)

(add-hook 'interactive-haskell-mode-hook 'subword-mode)
(add-hook 'interactive-haskell-mode-hook 'turn-on-smartparens-mode)
(add-hook 'interactive-haskell-mode-hook 'company-mode)

(define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
(define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile)

(provide 'init-haskell)
;;; init-haskell.el ends here
