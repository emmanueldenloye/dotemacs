;;; package --- Summary
;;; Commentary:
;;; Code:

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielem-mode-hook 'turn-on-eldoc-mode)

(provide 'setup-development)
;;; setup-development.el ends here
