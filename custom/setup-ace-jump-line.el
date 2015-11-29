;;; package -- Commentary
;;; Commentary:
;;; Code:

(require 'ace-jump-helm-line)

;; (use-package ace-jump-helm-line
;;   :config
;;   (setq ace-jump-helm-line-use-avy-style t))

(eval-after-load "helm"
  (progn
    '(define-key helm-map (kbd "C-'") 'ace-jump-helm-line)
    '(define-key helm-map (kbd "C-S-'") 'ace-jump-helm-line-execute-action)))

(provide 'setup-ace-jump-line)
;;; setup-ace-jump-line.el ends here
