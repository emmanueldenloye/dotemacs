;;; package --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path "~/.emacs.d/my-git-packages/org-present/")

(autoload 'org-present "org-present" nil t)

(eval-after-load "org-present"
  '(progn
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

(define-key org-mode-map (kbd "C-c M-p") 'org-present)

;; (define-key org-present-mode-keymap (kbd "n") org-present-next)
;; (define-key org-present-mode-keymap (kbd "p") org-present-prev)

(provide 'setup-org-present)
;;; setup-org-present.el ends here
