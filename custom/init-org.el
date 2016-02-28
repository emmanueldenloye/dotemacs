(use-package org
	     :init
	     (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
	     (bind-key "C-c l" 'org-store-link)
	     (bind-key "C-c a a" 'org-agenda)
	     (bind-key "C-c b" 'org-iswitchb)
	     :config
	     (setq org-src-fontify-natively t)
	     (add-hook 'org-mode-hook 'smartparens-mode)
	     (add-hook 'org-mode-hook 'flyspell-mode))

(use-package ox-latex
	     :config
	     (add-to-list 'org-latex-classes
			  '("beamer"
			    "\\documentclass\[presentation\]\{beamer\}"
			    ("\\section\{%s\}" . "\\section\{%s\}")
			    ("\\subsection\{%s\}" . "\\subsection\{%s\}")
			    ("\\subsubsection\{%s\}" . "\\subsubsection\{%s\}")))
	     (org-babel-do-load-languages
	      'org-babel-load-languages
	      '((dot . t))))

(provide 'init-org)
;; init-org.el ends here
