(provide 'setup-help)

(require 'info+)

(global-unset-key (kbd "C-h h"))	;original "C-h h" displays "hello world" in different languages
(define-key 'help-command (kbd "h m") 'discover-my-major)


(add-hook 'html-mode-hook 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)

(require 'help+)
