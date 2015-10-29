;;; package -- Commentary
;;; Commentary:
;;; Code:

(require 'ace-jump-helm-line)

(eval-after-load "helm"
  '(define-key helm-map (kbd "C-'") 'ace-jump-helm-line))

(setq ace-jump-helm-line-use-avy-style t)

(provide 'setup-ace-jump-line)
;;; setup-ace-jump-line.el ends here
