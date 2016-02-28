(use-package yasnippet
	     :ensure t
	     :config
	     (yas-global-mode 1))

	     ;; (after-load  'yasnippet
	     ;;         (defadvice yas-expand (before advice-for-yas-expand activate)
	     ;;           (sp-remove-active-pair-overlay)))

(provide 'init-yasnippet)
;; init-yasnippet.el ends here
