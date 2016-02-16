;;; package --- Summary
;;; Commentary:
;;; Code:

(add-hook 'haskell-mode-hook 'my-mmm-mode)

(mmm-add-classes
 '((literate-haskell-bird
    :sub-mode text-mode
    :front "^[^>]"
    :include-font true
    :back "^>\\|$")
   (literate-haskell-latex
    :submode literate-haksell-mode
    :front "^\\\\begin{code}"
    :front-offset (end-of-line 1)
    :back "^\\\\end{code}"
    :include-back nil
    :back-offset (beginning-of-line -1))))

(defun my-mmm-mode ()
  ;; go into mmm minor mode when class is given
  (make-local-variable 'mmm-global-mode)
  (setq mmm-global-mode 'true))

(setq mmm-submode-decoration-level 0)

(provide 'setup-mmm)
;;; setup-mmm.el ends here
