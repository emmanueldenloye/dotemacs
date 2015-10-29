;;; package -- Summary
;;; Commentary:
;;; Code:

;; You won't need any of those UI "innovations"!
;; Turn it off to save screen real estate.

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(require 'color-theme-sanityinc-tomorrow)
(require 'color-theme-sanityinc-solarized)

;; (color-theme-sanityinc-solarized-light)

;; the blinking cursor is nothing but an annoyance
(blink-cursor-mode -1)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-step 1
      scroll-preserve-screen-position 1)

(size-indication-mode t)

;; more useful frame title, that show either a file or a
; buffer name (if the buffer isn't visiting a file)
;; taken from prelude-ui.el
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
					    (abbreviate-file-name (buffer-file-name))
					  "%b"))))

;; (setq default-frame-alist '((font . "Monaco-11")))
;; (setq default-mode-line-format
;; set italic font for italic face, since Emacs does not set italic
;; face automatically
;; (set-face-attribute 'italic nil
;; 		    :family "Monaco")

(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(require 'highlight-symbol)

(highlight-symbol-nav-mode)

(add-hook 'prog-mode-hook
          (lambda ()
            (highlight-symbol-mode)))

(setq highlight-symbol-idle-delay 0.5
      highlight-symbol-on-navigation-p t)

(global-set-key [(control shift mouse-1)]
		(lambda (event)
		  (interactive "e")
		  (goto-char (posn-point (event-start event)))
		  (highlight-symbol-at-point)))

;; (global-set-key (kbd "M-n") 'highlight-symbol-next)
;; (global-set-key (kbd "M-p") 'highlight-symbol-prev)

;; use setq-default to set it for /all/ modes
;; (setq-default mode-line-format
;;   (list
;;     ;; the buffer name; the file name as a tool tip
;;     '(:eval (propertize "%b " 'face 'font-lock-keyword-face
;;         'help-echo (buffer-file-name)))

;;     ;; line and column
;;     "(" ;; '%02' to set to 2 chars at least; prevents flickering
;;       (propertize "%02l" 'face 'font-lock-type-face) ","
;;       (propertize "%02c" 'face 'font-lock-type-face)
;;     ") "

;;     ;; relative position, size of file
;;     " ["
;;     (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
;;     "/"
;;     (propertize "%I" 'face 'font-lock-constant-face) ;; size
;;     "] "

;;     ;; the current major mode for the buffer.
;;     " ("

;;     '(:eval (propertize "%m" 'face 'font-lock-string-face
;;               'help-echo buffer-file-coding-system))
;;     ") "


;;     "[" ;; insert vs overwrite mode, input-method in a tooltip
;;     '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
;;               'face 'font-lock-preprocessor-face
;;               'help-echo (concat "Buffer is in "
;;                            (if overwrite-mode "overwrite" "insert") " mode")))

;;     ;; was this buffer modified since the last save?
;;     '(:eval (when (buffer-modified-p)
;;               (concat ","  (propertize "Mod"
;;                              'face 'font-lock-warning-face
;;                              'help-echo "Buffer has been modified"))))

;;     ;; is this buffer read-only?
;;     '(:eval (when buffer-read-only
;;               (concat ","  (propertize "RO"
;;                              'face 'font-lock-type-face
;;                              'help-echo "Buffer is read-only"))))
;;     "] "

;;     ;; add the time, with the date and the emacs uptime in the tooltip
;;     '(:eval (propertize (format-time-string "%H:%M")
;;               'help-echo
;;               (concat (format-time-string "%c; ")
;;                       (emacs-uptime "Uptime:%hh"))))

;;     ;; " --"
;;     ;; i don't want to see minor-modes; but if you want, uncomment this:
;;     ;; minor-mode-alist  ;; list of minor modes
;;     ;; "%-" ;; fill with '-'
;;     ))
(provide 'setup-faces-and-ui)
;;; setup-faces-and-ui.el ends here
