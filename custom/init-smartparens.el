(use-package smartparens
  :ensure t
  :config
  :bind
  (("C-c w r" . sp-rewrap-sexp)
   ("C-c w u" . sp-unwrap-sexp))
  (use-package smartparens-config
    :config
    (setq sp-base-key-bindings 'paredit)
    (setq sp-autoskip-closing-pair 'always)
    (setq sp-hybrid-kill-entire-symbol nil)
    (sp-use-paredit-bindings)))
;; (diminish 'smartparens-mode)

(provide 'init-smartparens)
;;; init-smartparens.el ends here
