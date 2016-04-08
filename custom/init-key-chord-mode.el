(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "xx" 'helm-M-x)
(key-chord-define-global "JJ" 'switch-to-previous-buffer)
(key-chord-define-global "uu" 'undo-tree-visualize)
(key-chord-define-global "xb" 'helm-mini)
(key-chord-define-global "xf" 'helm-find-files)
(key-chord-define-global "yy" 'browse-kill-ring)
;; (global-set-key (kbd "C-x C-b") 'ibuffer)
;; (global-set-key (kbd "C-c m") 'mail)
;; (global-set-key (kbd "C-c 4 m") 'mail-other-window)



(provide 'init-key-chord-mode)
;;; init-key-chord-mode.el ends here
