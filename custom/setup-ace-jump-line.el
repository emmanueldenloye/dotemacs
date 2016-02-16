;;; package --
;;; Commentary:
;;; Code:

(require 'ace-jump-helm-line)

(eval-after-load "helm"
  (progn
    '(define-key helm-map (kbd "C-'") 'ace-jump-helm-line)
    '(define-key helm-map (kbd "C-S-'") 'ace-jump-helm-line-execute-action)))

(provide 'setup-ace-jump-line)
;;; setup-ace-jump-line.el ends here
