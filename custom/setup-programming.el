;;; package --- Summary
;;; Commentary:
;;; Code:

(provide 'setup-programming)

(setq c-default-style "linux"		;set style to "linux"
      c-basic-offset 4)

(setq gdb-many-windows t		; use  gdb-many-windows by default
      gdb-show-main t)			; Non-nil means display source file containing the main routine at startup

(defun prelude-colorize-compilation-buffer ()
  "Colorize a compilation buffer."
  (interacitve)
  ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc.
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

;; setup compilation-mode used by `compile` command
(require 'compile)
(setq compilation-ask-about-save nil 	; Just save before compiling
      compilation-always-kill t		; Just kill old compile process before starting the new one
      compilation-scroll-output 'first-error) ;Automatically scroll to first
(global-set-key (kbd "<f5>") 'compile)

(defun prelude-makefile-mode-defaults ()
  (whitespace-toggel-options '(tabs))
  (setq indent-tabs-mode t))

(setq prelude-makefile-mode-hook 'prelude-makefile-mode-defaults)
(add-hook 'makefile-mode-hook    (lambda ()
				   (run-hooks 'prelude-makefile-mode-hook)))


(global-diff-hl-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(setq ediff-diff-options "-w"
      ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain)

(require 'magit)
(set-default 'magit-stage-all-confirm nil)
(add-hook 'magit-mode-hook 'magit-load-config-extensions)

;;full screen magit-status
(defadvice magit-status (around magit-fullscreen-activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(global-unset-key (kbd "C-x g"))
(global-set-key (kbd "C-x g h") 'magit-log)
(global-set-key (kbd "C-x g f") 'magit-file-log)
(global-set-key (kbd "C-x g b") 'magit-blame-mode)
(global-set-key (kbd "C-x g m") 'magit-branch-manager)
(global-set-key (kbd "C-x g c") 'magit-branch)
(global-set-key (kbd "C-x g s") 'magit-status)
(global-set-key (kbd "C-x g r") 'magit-reflog)
(global-set-key (kbd "C-x g t") 'magit-tag)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Fix this crap at a later time. It is truly a whopping turd fest! GROSS!!
;; (defun flymake-Haskell-init ()
;;   (flymake-simple-make-init-impl
;;    'flymake-create-temp-with-folder-structure nil nil
;;    (file-name-nondirectory buffer-file-name)
;;    'flymake-get-Haskell-cmdline))

;; (defun flymake-get-Haskell-cmdline (source base-dir)
;;   (list "flycheck_haskell.pl"
;;         (list source base-dir)))

;; (push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
;;       flymake-allowed-file-name-masks)

;; (push
;;  '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
;;    1 2 3 4) flymake-err-line-patterns)

;;     ;; optional setting
;;     ;; if you want to use flymake always, then add the following hook.
;; (add-hook
;;  'haskell-mode-hook
;;  '(lambda ()
;;     (if (not (null buffer-file-name)) (flymake-mode))))

(require 'flycheck-tip)
(flycheck-tip-use-timer 'verbose)

(add-hook 'after-init-hook 'global-company-mode)

(provide 'setup-programming)
;;; setup-programming.el ends here
