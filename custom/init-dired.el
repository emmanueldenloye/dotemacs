
(setq
 dired-dwim-target t
 dired-recursive-copies 'always
 dired-recursive-deletes 'top
 dired-listing-switches "-lha"
)

;; automatically refresh dired buffer on changes
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; if it is not Windows, use the following listing switches
(when (not (eq system-type 'windows-nt))
  (setq dired-listing-switches "-lha --group-directories-first"))

(use-package dired-x
	     :defer t) ; provide extra commands dired

(use-package wdired
	     :defer t)

(setq
 wdired-allow-to-change-premissions t 	; allow to edit permission bits
 widred-allow-to-redirect-links		; allow to edit symlinks
 )

(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(use-package dired+
	     :defer t)

(provide 'init-dired)
;; init-dired.el ends here
