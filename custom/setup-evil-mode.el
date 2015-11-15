;;; package -- Summary
;;; Commentary:
;;; Code:

(eval-when-compile
  (defvar evil-emacs-state-cursor)
  (defvar evil-normal-state-cursor)
  (defvar evil-visual-state-cursor)
  (defvar evil-insert-state-cursor)
  (defvar evil-motion-state-cursor)
  (defvar evil-want-C-u-scroll))

(require-package 'evil)
(require 'evil)
(require-package 'evil-surround)
(require 'evil-surround)
(require-package 'evil-anzu)
(require 'evil-anzu)
(require-package 'evil-numbers)
(require 'evil-numbers)
(require-package 'evil-easymotion)
(require 'evil-easymotion)
(require-package 'evil-mark-replace)
(require-package 'evil-jumper)
(require 'evil-jumper)
(require-package 'evil-visualstar)
(require 'evil-visualstar)
(require-package 'evil-leader)
(require 'evil-leader)
(require-package 'evil-org)
(require 'evil-org)
(require-package 'evil-commentary)
(require 'evil-commentary)
(require-package 'evil-tabs)
;; (load "elscreen" "ElScreen" t)

;; (defun my-enable-evil-mode ()
;;   "An interactive command to enable evil-mode in my own way."
;;   (interactive)
;;   (progn
;;     (evil-mode t)
;;     (global-evil-leader-mode)
;;     (global-evil-visualstar-mode)
;;     (global-evil-surround-mode)
;;     (global-evil-jumper-mode)
;;     ;; (evil-tabs-mode t)
;;     (evil-commentary-mode)
;;     (turn-on-evil-visualstar-mode)
;;     (powerline-center-evil-theme)
;;     (key-chord-mode nil)
;;     (structured-haskell-mode -1)
;;     (evil-paredit-mode -1)
;;     (message "Evil mode activated.")))

;; (defun my-disable-evil-mode ()
;;   "An interactive command to disable evil-mode in my own way."
;;   (interactive)
;;   (progn
;;     (evil-mode nil)
;;     (global-evil-leader-mode nil)
;;     (global-evil-visualstar-mode nil)
;;     (global-evil-surround-mode nil)
;;     (global-evil-jumper-mode nil)
;;     ;; (turn-off-evil-tabs-mode)
;;     (evil-commentary-mode nil)
;;     (turn-off-evil-visualstar-mode)
;;     (key-chord-mode t)
;;     (set-cursor-color "#8b4513")
;;     (powerline-revert)
;;     (evil-paredit-mode -1)
;;     (structured-haskell-mode 1)
;;     (message "Evil mode deactivated.")))

(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key  keymap-from key))
  (define-key keymap-from key nil))

(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")

(setq evil-want-C-u-scroll nil)
(setq evil-emacs-state-cursor '("white" box))
(setq evil-normal-state-cursor '("yellow" box))
(setq evil-visual-state-cursor '("purple" box))
(setq evil-insert-state-cursor '("green" box))
(setq evil-motion-state-cursor '("blue" box))

;; (defun my-evil-mode-line-hook ()
;;   "Enable a mode-line for evil"
;;   (interactive)
;;   (add-hook 'post-command-hook
;;     (lambda ()
;;         (let ((color (cond ((minibufferp) default-color)
;;                             ((evil-insert-state-p) '("#e80000" . "#ffffff"))
;;                             ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
;;                             ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
;;                             (t default-color))))
;;         (set-face-background 'mode-line (car color))
;;         (set-face-foreground 'mode-line (cdr color))))))

(define-key evil-normal-state-map ";"             'evil-ex)
(define-key evil-motion-state-map ":"             'evil-repeat-find-char)
(define-key evil-normal-state-map (kbd "C-e")     'evil-end-of-line)
(define-key evil-normal-state-map (kbd "C-c +")   'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -")   'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "C-c a")   'evil-avy-goto-char)
(define-key evil-normal-state-map (kbd "C-c o")   'evil-avy-goto-subword-1)
(define-key evil-insert-state-map (kbd "C-c C-a") 'evil-paste-last-insertion)
(define-key evil-insert-state-map (kbd "C-c C-e") 'evil-copy-from-below)
(define-key evil-insert-state-map (kbd "C-a")     'smarter-move-beginning-of-line)
(define-key evil-insert-state-map (kbd "C-e")     'end-of-line)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
    "e"  'helm-find-files
    "b"  'helm-mini
    "J"  'switch-to-previous-buffer
    "x"  'helm-M-x
    "k"  'kill-buffer
    "cc" 'flycheck-compile
    "cC" 'flycheck-clear
    "cl" 'flycheck-list-errors
    "cn" 'flycheck-previous-error
    "cp" 'flycheck-next-error)

(provide 'setup-evil-mode)
;;; setup-evil-mode.el ends here

;; (eval-after-load 'evil-mode '(progn))
;; ;; change mode-line color by evil state
;; (lexical-let ((default-color (cons (face-background 'mode-line)
;;                                    (face-foreground 'mode-line))))
;; (defun my/evil-normal-state-open-above ()
;;   "Open a line below the current and stay in normal mode"
;;   (interactive)
;;   (progn
;;     (evil-open-below)
;;     (evil-force-normal-state)))
;; (define-key evil-normal-state-map (kbd "RET") )
;; (require 'evil-lisp-state)
;; (require 'evil-mark-replace)
;; (require 'evil-matchit)
;; (elscreen-start)
;; (global-evil-tabs-mode)
;; (require 'elscreen)
