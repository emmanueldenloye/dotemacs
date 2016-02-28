
(use-package magit
	     :bind
	     (("C-x g i " . magit-init)
	      ("C-x g f" . magit-file-log)
	      ("C-x g b" . magit-blame-mode)
	      ("C-x g m" . magit-branch-manager)
	      ("C-x g c" . magit-branch)
	      ("C-x g s" . magit-status)
	      ("C-x g r " . magit-reflog)
	      ("C-x g t" . magit-tag))
	     :config
	     (set-default 'magit-stage-all-confirm nil)
	     (add-hook 'magit-mode-hook 'magit-load-config-extensions)
	     (defadvice magit-status (around magit-fullscreen-activate)
	       (window-configuration-to-register :magit-fullscreen)
	       ad-do-it
	       (delete-other-windows)))

(provide 'init-magit)
;;; init-magit.el ends here
