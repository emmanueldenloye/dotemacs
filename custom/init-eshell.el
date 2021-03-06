(use-package eshell
  :bind
  (("C-. m" . eshell))
  :config
  (add-hook
   'eshell-mode-hook
   'smartparens-mode)
  (add-hook
   'eshell-mode-hook
   (lambda ()
     (setq pcomplete-cycle-completions nil))))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(use-package em-alias
  :config
  (require 'cl)
  ;; In eshell, you can run the commands in M-x
  ;; Here are the aliases to the commands.
  ;; $* emacs accepts all arguments.
  (eshell/alias "o" "")
  (eshell/alias "o" "find-file-other-window $*")
  (eshell/alias "vi" "find-file-other-window $*")
  (eshell/alias "vim" "find-file-other-window $*")
  (eshell/alias "emacs" "find-file-other-window $*")

  ;; change  listing sitches based on OS
  (when (not (eq  system-type 'windows-nt))
    (eshell/alias "ls" "ls -color -h --group-directories-first $*")))

(provide 'init-eshell)
;;; init-eshell.el ends here
