;;; package --
;;; Commentary:
;;; Code:

(use-package ace-jump-helm-line
  :init
  (bind-key "C-'" 'ace-jump-helm-line)
  (bind-key "C-S-'" 'ace-jump-helm-line-execute-action)
  :config
  (setq ace-jump-helm-line-use-avy-style t))

(provide 'init-ace-jump-line)
;;; init-ace-jump-line.el ends here
