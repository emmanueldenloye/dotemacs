;;; package --- Summary
;;; Commentary:
;;; Code:

;; GROUP: Editing -> Editing Basics
(setq global-mark-ring-max 5000		; increase global mark ring to contain 500 entries
      mark-ring-max 5000		; increase local mark ring to contain 5000 entries
      mode-require-final-newline t	; add a newline to end of file
      )

;;  default to 4 visible spaces to display a tab
(setq-default tab-width 4)

;;  set fill column
(setq fill-column 80)

(setq sentence-end-double-space nil)
;; (fset 'yes-or-no-p 'y-or-no-p)


(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(delete-selection-mode)
(global-set-key (kbd "RET") 'newline-and-indent)

;; GROUP: Editing -> Killing
(setq
 kill-ring-max 5000			; increase kill-ring capacity
 kill-whole-line t			; if NIL, kill whole line and move the next line up
 )

;; show important whitespace in diff mode
(add-hook 'diff-mode-hook (lambda ()
			    (setq-local whitespace-style
					'(face
					  tabs
					  tab-mark
					  spaces
					  space-mark
					  trailing
					  indentation::space
					  indentation::tab
					  newline
					  newline-mark))
			    (whitespace-mode 1)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; This preserves the group and the owner of edited files.
(setq backup-by-copying-when-mismatch t)

;; courtesy of http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace caharcter on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginnnig of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first. If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line`
(global-set-key [remap move-beginning-of-line]
		'smarter-move-beginning-of-line)

(require 'duplicate-thing)
(global-set-key (kbd "C-c d") 'duplicate-thing)

(require 'volatile-highlights)
(volatile-highlights-mode t)
(diminish 'volatile-highlights-mode)

(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)
(diminish 'smartparens-mode)

(add-hook 'org-mode-hook 'smartparens-mode)

(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

(after-load  'yasnippet
        (defadvice yas-expand (before advice-for-yas-expand activate)
          (sp-remove-active-pair-overlay)))

;; Paredit Settings
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)

(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)

(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'minibuffer-setup-hook 'smartparens-mode)
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)

(defun  paredit-barf-all-the-way-backward ()
  "Barf all the items from point to beginning of sexp out."
  (interactive)
  (paredit-split-sexp)
  (paredit-backward-down)
  (paredit-splice-sexp))

(defun paredit-barf-all-the-way-forward ()
  "Barf all the items from point to end of sexp out."
  (interactive)
  (paredit-split-sexp)
  (paredit-forward-down)
  (paredit-splice-sexp)
  (if (eolp) (delete-horizontal-space)))

(defun paredit-slurp-all-the-way-backward ()
  "Slurp baby."
  (interactive)
  (catch 'done
    (while (not (bobp))
      (save-excursion
        (paredit-backward-up)
        (if (eq (char-before) ?\()
            (throw 'done t)))
      (paredit-backward-slurp-sexp))))

(defun paredit-slurp-all-the-way-forward ()
  "Slurp baby."
  (interactive)
  (catch 'done
    (while (not (eobp))
      (save-excursion
        (paredit-forward-up)
        (if (eq (char-after) ?\))
            (throw 'done t)))
      (paredit-forward-slurp-sexp))))

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "C-M-)")
       'paredit-slurp-all-the-way-forward)
     (define-key paredit-mode-map (kbd "C-M-(")
       'paredit-slurp-all-the-way-backward)
     (define-key paredit-mode-map (kbd "C-M-}")
       'paredit-barf-all-the-way-forward)
     (define-key paredit-mode-map (kbd "C-M-{")
       'paredit-barf-all-the-way-backward)
     (define-key paredit-mode-map (kbd "C-M-m")
       'paredit-delete-region)))

(require 'undo-tree)
(global-undo-tree-mode)

(require 'yasnippet)
(yas-global-mode 1)

(defun eval-sexp-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (backward-kill-sexp)
    (insert (format "%s" value))))


(defun my-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(global-set-key (kbd "C-x C-.") 'eval-sexp-and-replace)

(global-set-key (kbd "C-c C-y") 'x-clipboard-yank)

;;; Cursor color -> Saddle Brown
(set-cursor-color "#8b4513")

(provide 'setup-editing)
;;; setup-editing.el ends here
