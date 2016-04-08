(use-package avy
  :defer t
  :init
  (setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  (setq avy-all-windows 'all-frames)
  (setq avy-background t)
  :bind
  (("C-c a c" . avy-copy-line)
   ("C-C a p" . avy-pop-mark)
   ("C-c a m" . avy-move-line)
   ("C-c a r" . avy-copy-region)
   ("C-c a s" . avy-isearch)
   ("M-g g" . avy-goto-line)
   ("M-g M-g" . avy-goto-line))
  :config
  (avy-setup-default))

;; Key chords are nice to have!
(key-chord-define-global "jc" 'avy-goto-char-in-line)
(key-chord-define-global "jj" 'avy-goto-char)
(key-chord-define-global "jk" 'avy-goto-word-or-subword-1)
(key-chord-define-global ",." 'eod-insert-dollar)
(key-chord-define-global ";," (lambda () (interactive) (insert "~")))

(provide 'init-avy)
;;; init-avy.el ends here
