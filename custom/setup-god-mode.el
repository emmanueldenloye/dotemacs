;;; package --- Summary
;;; Commentary:
;;; Code:

(require-package 'god-mode)

;; ENABLE THIS AT A LATER TIME.

;; (require 'god-mode-isearch)

;; ;; Functions

;; (defun god-update-cursor ()
;;   "Update my cursor."
;;   (setq cursor-type
;;         (if god-local-mode
;;             'box
;;           'bar)))

;; (defun god-toggle-on-overwrite ()
;;   "Toggle god-mode on overwrite-mode."
;;   (if (bound-and-true-p overwrite-mode)
;;       (god-local-mode-pause)
;;     (god-local-mode-resume)))


;; ;; Keybindings


;; (define-key god-local-mode-map (kbd "x1") 'delete-other-windows)
;; (define-key god-local-mode-map (kbd "x2") 'split-window-below)
;; (define-key god-local-mode-map (kbd "x3") 'split-window-right)
;; (define-key god-local-mode-map (kbd "x4") 'delete-window)

;; (define-key god-local-mode-map (kbd ".") 'repeat)

;; (global-set-key (kbd "<escape>") 'god-mode-all)
;; (define-key god-local-mode-map (kbd "DEL") 'delete-backward-char)


;; (define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
;; (define-key god-mode-isearch-map (kbd "<escape>") 'god-mode-isearch-disable)

;; (setq god-exempt-major-modes nil)
;; (setq god-exempt-predicates nil)


;; ;; Hooks

;; (add-hook 'god-mode-enabled-hook 'god-update-cursor)
;; (add-hook 'god-mode-disabled-hook 'god-update-cursor)
;; (add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)

(provide 'setup-god-mode)
;;; setup-god-mode.el ends here
