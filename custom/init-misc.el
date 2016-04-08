;; update any change made on file to the current buffer
(global-auto-revert-mode)

;; (global-hl-line-mode)

;; Align regexp is a beautiful function.
;; Include this function as an operator in evil-mode.

(global-set-key (kbd "C-x a r") 'align-regexp)

;; activate whitespace-mode to view all whitepsace characters
(global-set-key (kbd "C-c C-w") 'whitespace-mode)

(show-paren-mode 1)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "C-c j") 'eod/join-next-line)

(use-package highlight-escape-sequences
  :config
  (hes-mode))

;;; set the time to show partially completed keystrokes to a four tenths of a second.
(setq echo-keystrokes 0.4)

(setq frame-title-format '(buffer-file-name "%f" ("%b")))

(mouse-avoidance-mode 'banish)

(setq ispell-dictionary "american")

(beacon-mode 1)

(use-package expand-region
  :ensure t
  :bind
  (("C-="  . er/expand-region)))

(setq global-mark-ring-max 5000		; increase global mark ring to contain 500 entries
      mark-ring-max 5000		; increase local mark ring to contain 5000 entries
      mode-require-final-newline t	; add a newline to end of file
      )

(setq
 kill-ring-max 5000			; increase kill-ring capacity
 kill-whole-line t			; if NIL, kill whole line and move the next line up
 )

(setq-default tab-width 4)

(setq fill-column 80)

(setq sentence-end-double-space nil)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(delete-selection-mode)

(setq-default indent-tabs-mode nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

(use-package duplicate-thing
  :bind
  (("C-c d" . duplicate-thing)))

(eval-when-compile
  (defvar savehist-additional-variables)
  (defvar savehist-autosave-interval))

(setq initial-scratch-message "")
(setq inhibit-startup-screen t)

(setq savehist-additional-variables '(search ring regexp-search-ring) ; also save your regexp search queries
      savehist-autosave-interval 60)    ; save every minute

(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))

(if (executable-find "aspell")
    (progn
      (setq ispell-program-name "aspell")
      (setq ispell-extra-args '("--sug-mode=ultra")))
  (setq ispell-program-name "aspell"))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(blink-cursor-mode -1)

(setq-default cursor-type 'box)

(setq scroll-margin 0
      scroll-conseratively 100000
      scroll-step 1
      scroll-preserve-screen-position 1)

(size-indication-mode t)

(setq large-file-warning-threshold 100000000) ;; size in bytes

(use-package whitespace
  :config
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode nil))

(setq user-mail-address "emmanuel.denloye@gmail.com"
      user-full-name "Emmanuel Denloye-Ito")

(use-package info+
  :ensure t
  :config
  (global-unset-key (kbd "C-h h"))
  (define-key 'help-command (kbd "h m") 'discover-my-major))

(use-package help+
  :ensure t)


(setq c-default-style "linux"    ;set style to linux
      c-basic-offset 4)

(setq gdb-many-windows t
      gdb-show-main t)

;;; get rid of some items in the mode line
(diminish 'eldoc-mode)
(diminish 'company-mode)
(diminish 'elisp-slime-nav-mode)
(diminish 'undo-tree-mode)
(diminish 'flycheck-mode)
(diminish 'beacon-mode)
(diminish 'global-whitespace-mode)

(add-to-list 'auto-mode-alist (cons "\\.hs\\'" 'haskell-mode))
(add-to-list 'auto-mode-alist (cons "\\.hcr\\'" 'haskell-core-mode))

;;; Cursor color -> Saddle Brown
(set-cursor-color "#Ff69b4")

;; (require 'volatile-highlights)
;; (volatile-highlights-mode t)
;; (diminish 'volatile-highlights-mode)
;; (global-set-key (kbd "RET") 'newline-and-indent)

(setq initial-scratch-message
      (format
       ";; %s\n\n"
       (replace-regexp-in-string
        "\n" "\n;; " ; comment each line
        (replace-regexp-in-string
         "\n$" "" ; remove trailing line break
         (shell-command-to-string "fortune")))))

;;; Place new lines in at the end of the buffer whenever next-line
;;; (C-n) is executed.
(setq next-line-add-newlines t)

(provide 'init-misc)
;;; init-misc.el ends here
