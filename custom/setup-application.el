(provide 'setup-application)

(require 'eshell)
(require 'em-alias)
(require 'cl)

(global-set-key (kbd "C-x m") 'eshell)

;; Advise find-file-other-window to accept more than one file
(defadvice find-file-other-window (around find-files activate)
  "Also find all files within a list of files. This even works recursively."
  (if (listp filename)
      (loop for f in filename do (find-file-other-window f wildcards))
    ad-do-it))

;; In eshell, you can run the commands in M-x
;; Here are the aliases to the commands.
;; $* emacs accepts all arguments.
(eshell/alias "o" "")
(eshell/alias "o" "find-file-other-window $*")
(eshell/alias "vi" "find-file-other-window $*")
(eshell/alias "vim" "find-file-other-window $*")
(eshell/alias "emacs" "find-file-other-window $*")

(add-hook
 'eshell-mode-hook
 'smartparens-mode)

(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions  nil)))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; change  listing sitches based on OS
(when (not (eq  system-type 'windows-nt))
  (eshell/alias "ls" "ls -color -h --group-directories-first $*"))
