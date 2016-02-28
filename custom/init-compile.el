(use-package compile
	     :ensure t
	     :bind
	     ("<f5>" . compile))

(use-package auto-compile
	     :ensure t)

(setq compilation-ask-about-save nil 	; Just save before compiling
      compilation-always-kill t		; Just kill old compile process before starting the new one
      compilation-scroll-output 'first-error) ;Automatically scroll to first
(global-set-key (kbd "<f5>") 'compile)

(defun prelude-colorize-compilation-buffer ()
  "Colorize a compilation buffer."
  (interacitve)
  ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc.
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

(defun prelude-makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t))

(setq prelude-makefile-mode-hook 'prelude-makefile-mode-defaults)
(add-hook 'makefile-mode-hook    (lambda ()
				   (run-hooks 'prelude-makefile-mode-hook)))


(global-diff-hl-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(provide 'init-compile)
;; init-compile.el ends here
