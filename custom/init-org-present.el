;;; package --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path "~/.emacs.d/my-git-packages/org-present/")

(use-package org-present
	     :init
	     (autoload 'org-present "org-present" nil t)
	     :config
	     (bind-key "C-c M-p" 'org-present org-mode-map)
	     (bind-key "n" 'org-present-next org-present-mode-keymap)
	     (bind-key "p" 'org-present-prev org-present-mode-keymap)
	     (progn
	       (add-hook 'org-present-mode-hook
			 (lambda ()
			   (org-present-small)
			   (org-display-inline-images)
			   (org-present-hide-cursor)
			   (org-present-read-only)))
	       (add-hook 'org-present-mode-quit-hook
			 (lambda ()
			   ;; (org-present-small)
			   (org-remove-inline-images)
			   (org-present-show-cursor)
			   (org-present-read-write)))))

(provide 'init-org-present)
;;; init-org-present.el ends here
