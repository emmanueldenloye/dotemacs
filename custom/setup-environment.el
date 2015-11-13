;;; package --- Summary:
;;; Commentary:
;;; Code:
(provide 'setup-environment)

(eval-when-compile
  (defvar savehist-additional-variables)
  (defvar savehist-autosave-interval))

;;; Do not display an initial "startup" message
(setq initial-scratch-message "")
(setq inhibit-startup-screen t)

(setq savehist-additional-variables '(search ring regexp-search-ring) ; also save your regexp search queries
      savehist-autosave-interval 60)	; save every minute

(winner-mode  1)
(column-number-mode 1)

;;; auto refresh dired silently!
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(require 'ace-window)

(global-set-key (kbd "M-#") 'ace-window)

;; Remapped for Programmer Dvorak.
(setq aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))

(setq aw-background nil)

(setq aw-dispatch-always t)

(defvar aw-dispatch-alist
  '((?x aw-delete-window "Ace - Delete Window")
    (?m aw-swap-window " Ace - Swap Window")
    (?f aw-flip-window)
    (?v aw-split-window-vert " Ace - Split Vert Window")
    (?b aw-split-window-horz " Ace - Split Horz Window")
    (?c delete-other-windows " Ace - Maximize Window")
    (?C delete-other-windows))
  "List of actions for `aw-dispatch-default'.")

(diminish 'eldoc-mode)
;; (diminish 'highlight-symbol-mode)
(diminish 'volatile-highlights-mode)

(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))

;; Should return nil
;; (defadvice ace-window
;;     (after golden-ratio-resize-window)
;;   (golden-ratio) nil)

;; (defadvice ace-select-window (after golden-window-adjust activate)
;;   "Readjust the selected-window if golden-ratio mode is active."

;;   )

(require 'golden-ratio)


(global-unset-key (kbd "C-x +"))
(global-set-key (kbd "C-x + +") (lambda () (interactive) (balance-windows)))
(global-set-key (kbd "C-x + w") (lambda () (interactive) (golden-ratio-adjust 1.0)))

(diminish 'golden-ratio-mode)

(add-to-list 'golden-ratio-inhibit-functions  'pl/helm-alive-p)

(defun pl/helm-alive-p ()
  "Check if helm is alive."
  (if (boundp 'helm-alive-p)
      (symbol-value 'helm-alive-p)))

;; do not enable golden-ratio in these modes
(setq golden-ratio-exclude-modes '("ediff-mode"
				   "gud-mode"
				   "gdb-registers-mode"
				   "gdb-local-mode"
				   "gdb-breakpoints-mode"
				   "gdb-threads-mode"
				   "gdb-frames-mode"
				   "gdb-inferior-io-mode"
				   "gdb-inferior-disassembly-mode"
				   "gdb-memory-mode"
				   "magit-log-mode"
				   "magit-reflog-mode"
				   "magit-status-mode"
                   "helm-mode"
                   "IELEM"
				   "eshell-mode"
				   "dired-mode"))

(golden-ratio-mode)

;; (load-theme 'ample t t)
;; (load-theme 'ample-flat t t)
;; (load-theme 'ample-light t t)

;; (enable-theme 'ample)

;;; setup-environment.el ends here
