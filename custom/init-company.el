(use-package company
	     :ensure t
	     :pin melpa-stable
	     :config
	     (company-mode 1))

(add-hook 'after-init-hook 'global-company-mode)

(provide 'init-company)
;; init-company.el ends here
