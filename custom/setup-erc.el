;;; package --- Summary
;;; Commentary:
;;; Code:


;;; package --- Summary
;;; Commentary:
;;; Personal Items
;;; Code:

(add-to-list
 'load-path
 "~/elisp/erc-extras" t)

(eval-when-compile
  (defvar erc-autojoin-channels-alist)
  (defvar my/erc-mode-hook))

(setq
 user-login-name
 "emmanuel_erc")

(setq
 erc-autojoin-channels-alist
      '(("freenode.net" "#haskell")
        ("freenode.net" "#emacs")
        ("freenode.net" "#haskell-beginners")
        ("irc.oftc.net" "#pentadactyl")))

(defun eod/erc-mode-defaults ()
       (smartparens-mode))

(eval-after-load 'erc
  '(progn
     (eod/erc-mode-defaults)

     (setq eod/erc-mode-hook 'eod/erc-mode-defaults)

     (add-hook 'erc-mode-hook (lambda ()
                                (run-hooks 'eod/erc-mode-hook)))))

(provide 'setup-erc)
;;; setup-erc.el ends here
