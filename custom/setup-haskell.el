;;; package --- Summary
;;; Commentary:
;;; Code:

(require-package 'haskell-mode)

(add-to-list 'load-path "~/Documents/Code_Repository/haskell/haskell_libs/ghc-mod/elisp")

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(let ((my-ghc-path (expand-file-name "~/Development/bin/ghc/bin/")))
  (setenv "PATH" (concat my-ghc-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-ghc-path))

(custom-set-variables '(haskell-tags-on-save t))

(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(setq ghc-display-error 'minibuffer)
;; ;; (add-hook 'haskell-mode-hook (lambda () (ghc-init) (hare-init)) ; For HaRe refactoring.

(require 'company)
(add-hook 'haskell-mode-hook 'company-mode)

(require-package 'company-ghc)
(require-package 'company-cabal)
(add-to-list 'company-backends 'company-ghc)
(add-to-list 'company-backends 'company-cabal)
(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-type 'cabal-repl)
 '(haskell-process-arg-cabal-repl)
 '(haskell-process-generate-tags t)
 '(haskell-process-suggest-haskell-docs-imports t)
 '(haskell-interactive-popup-errors nil)
 '(company-ghc-show-info t)
 '(shm-lambda-indent-style 0)
 '(shm-indent-point-after-adding-where-clause t)
 '(haskell-tags-on-save t))

;; (after-load 'page-break-lines
;;   (push 'haskell-mode page-break-lines-modes))

;; (after-load 'compile
;;             (let ((alias 'ghc-at-regexp))
;;               (add-to-list
;;                'compilation-error-regexp-alist-alist
;;                (list alias " at \\(.*\\.\\(?:l?[gh]hs\\|hi\\)\\):\\([0-9]+\\):\\[0-9]+\\)-[0-9]+$" 1 2 3 0 1))
;;               (add-to-list
;;                'compilation-error-regexp-alist alias)))

(eval-after-load 'haskell-mode
  '(progn
    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
    (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
    (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
    (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-cabal-build)
    (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
    (define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile)
    (define-key haskell-mode-map (kbd "C-c TAB") 'ghc-insert-template-or-signature)
    (define-key haskell-mode-map (kbd "C-c C-p") 'highlight-symbol-prev)
    (define-key haskell-mode-map (kbd "C-c C-n") 'highlight-symbol-next)
    (define-key haskell-mode-map (kbd "M-g M-p") 'ghc-goto-prev-error)
    (define-key haskell-mode-map (kbd "M-g M-n") 'ghc-goto-next-error)
    (define-key haskell-mode-map (kbd "M-g h M-p") 'ghc-goto-prev-hole)
    (define-key haskell-mode-map (kbd "M-g h M-n") 'ghc-goto-next-hole)
    (define-key haskell-mode-map [f8] 'haskell-navigate-imports)
    (define-key haskell-mode-map (kbd "C-c C-h") 'hoogle)
    (define-key haskell-mode-map (kbd "C-c v c") 'haskell-cabal-visit-file)
    (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
    (define-key haskell-mode-map (kbd "M-t") 'transpose-words)
    (define-key shm-map (kbd "C-c C-s") 'shm/case-split)))

(eval-after-load 'haskell-cabal
  '(progn
     (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-cabal-mode-map (kbd "C-c c")   'haskell-process-cabal)
     (define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile)))

(add-hook 'haskell-mode-hook (lambda () (define-key haskell-mode-map (kbd "C-c ?") 'helm-ghc-errors)))

(add-to-list 'load-path "/home/emmanuel/.emacs.d/elpa/structured-haskell-mode/elisp")
(require-package 'shm)
;; (add-hook 'haskell-mode-hook 'structured-haskell-mode)
(require 'shm)
(require 'shm-case-split)
;; (eval-after-load 'structured-haskell-mode
;;   '(progn
;;      (define-key haskell-mode-map (kbd "M-p") 'highlight-symbol-prev)
;;      (define-key haskell-mode-map (kbd "M-n") 'highlight-symbol-next)))

;; (remove-hook 'haskell-mode-hook 'structured-haskell-mode)
(add-hook 'haskell-mode-hook (lambda ()
                               (subword-mode +1)
                               (haskell-doc-mode)
                               (haskell-indent-mode)
                               (interactive-haskell-mode +1)))

(add-hook 'inferior-haskell-mode-hook (lambda ()
                                        (subword-mode +1)
                                        (turn-on-smartparens-mode)))

(add-hook 'interactive-haskell-mode-hook (lambda ()
                                        (subword-mode +1)
                                        (turn-on-smartparens-mode)))

;; (custom-set-faces
;;  '(shm-quarantine-face ((t (:inherit font-loc k-error))))
;;  '(shm-current-face ((t (:background "#efefef")))))

(provide 'setup-haskell)
;;; setup-haskell.el ends here
