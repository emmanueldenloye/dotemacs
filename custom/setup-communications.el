;;; package --- Summary
;;; Commentary:
;;; Code:

;; go-to-address-mode
(add-hook 'prog-mode-hook 'goto-address-mode)
(add-hook 'text-mode-hook 'goto-address-mode)

;; (require-package 'jabber)
;; (when (require 'jabber nil t)
;;   (setq starttls-use-gnutls t
;;         starttls-gnutls-program "gnutls-cli"
;;         starttls-extra-arguments '("--starttls" "--insecure")))

;; (setq
;;    jabber-history-enabled t
;;    jabber-use-global-history nil
;;    jabber-backlog-number 40
;;    jabber-backlog-days 30)

;; (defun my-jabber-chat-delete-or-bury ()
;;   (interactive)
;;   (if (eq 'jabber-chat-mode major-mode)
;;       (condition-case e
;;           (delete-frame)
;;         (error
;;          (if (string= "Attempt to delete the sole visible or iconified frame"
;;                       (cadr e)))))))

;; (when (require 'autosmiley nil t)
;;   (add-hook 'jabber-chat-mode-hook 'autosmiley-mode))

(provide 'setup-communications)
;;; setup-communications.el ends here
