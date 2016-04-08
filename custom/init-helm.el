(use-package helm
  :ensure t
  :init
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  (when (executable-find "ack-grep")
    (setq helm-grep-default-command "ack grep -Hn --no-group --no-color %e %p %f"
          helm-grep-default-recurse-command "ack grep -H --no-group --no-color %e %p %f"))
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files))
  :config
  (setq helm-command-prefix-key "C-c h")
  (bind-keys :map helm-map
             ("<tab>" . helm-execute-persistent-action)
             ("C-i" . helm-execute-persistent-action)
             ("C-z" . helm-select-action))
  (bind-key "C-c C-l" 'helm-minibuffer-history minibuffer-local-map)
  (bind-key "C-x b" 'helm-mini)
  (add-hook
   'eshell-mode-hook
   #'(lambda ()
       (define-key
         eshell-mode-map
         (kbd "C-c C-l") 'helm-eshell-history)))
  (helm-mode 1)
  (helm-autoresize-mode t)
  (setq helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-ff-search-libray-in-sexp t
        helm-scroll-amount t
        helm-ff-file-name-history-use-recentf t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-M-x-fuzzy-match t
        helm-file-cache-fuzzy-match t
        helm-lisp-fuzzy-completion t
        helm-apropos-fuzzy-match t
        helm-completion-in-region-fuzzy-match t
        helm-mode-fuzzy-match t
        helm-input-idle-delay 0.02
        helm-candidate-number-limit 100
        helm-locate-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-semantic-fuzzy-match t)
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
  (add-to-list
   'helm-boring-file-regexp-list
   '("\\.dyn_hi$" "\\.dyn_o$" "\\.hi$" "\\.o$" "\\.tags$" "^\\.ghci"))
  (use-package helm-config)
  (use-package helm-descbinds
    :ensure t
    :config
    (helm-descbinds-mode))
  (use-package helm-unicode))

(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h x") 'helm-register)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)
(global-set-key (kbd "C-c h M-:") 'helm-eval-expression-with-eldoc)
(global-set-key (kbd "C-c h C-b") 'helm-bibtex)

(provide 'init-helm)
;;; init-helm.el ends here
