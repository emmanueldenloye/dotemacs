(use-package flyspell
	     :ensure t
	     :config
	     (if (fboundp 'prog-mode)
		 (add-hook 'prog-mode-hook 'flyspell-prog-mode)
	       (dolist (hook '(lisp-mode-hook
			       emacs-lisp-mode-hook
			       python-mode-hook
			       shell-mode-hook
			       haskell-mode-hook
			       crontab-mode-hook))
		 (add-hook hook 'flyspell-prog-mode))))

(provide 'init-flyspell)
;; init-flyspell.el ends here
