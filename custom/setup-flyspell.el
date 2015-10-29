;;; package --- Summary
;;; Commentary:
;;; Code:

(require-package 'flyspell)

(if (fboundp 'prog-mode)
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (dolist (hook '(lisp-mode-hook
                  emacs-lisp-mode-hook
                  python-mode-hook
                  shell-mode-hook
                  haskell-mode-hook
                  crontab-mode-hook))
    (add-hook hook 'flyspell-prog-mode)))


(provide 'setup-flyspell)
;;; setup-flyspell.el ends here
