;;; package --- Summary
;;; Commentary:
;;; Code:

(setq large-file-warning-threshold 100000000) ;; size in bytes


(defvar backup-directory "~/.backups")
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))

(setq
 make-backup-files t
 backup-directory-alist `((".*" . ,backup-directory)) ;; save backup files in ~/.backups
 backup-by-copying t
 version-control t
 delete-old-versions  t
 kept-old-versions 6
 kept-new-versions 9
 auto-save-default t
 auto-save-timeout 20
 auto-save-interval 200
 vc-make-backup-files t
 auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))
)



(setq
 dired-dwim-target t
 dired-recursive-copies 'always
 dired-recursive-deletes 'top
 dired-listing-switches "-lha"
)

;; automatically refresh dired buffer on changes
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; if it is not Windows, use the following listing switches
(when (not (eq system-type 'windows-nt))
  (setq dired-listing-switches "-lha --group-directories-first"))

;; KEY BINDINGS.
;; (define-key ctl-x-4-map "\C-j" 'dired-jump-other-window)
;; (define-key dired-mode-map "\C-x\M-o" 'dired-omit-mode)
;; (define-key dired-mode-map "*O" 'dired-mark-omitted)
;; (define-key dired-mode-map "\M-(" 'dired-mark-sexp)
;; (define-key dired-mode-map "*(" 'dired-mark-sexp)
;; (define-key dired-mode-map "*)" 'dired-mark-extension)
;; (define-key dired-mode-map "\M-!" 'dired-smart-shell-command)
;; (define-key dired-mode-map "\M-G" 'dired-goto-subdir)
;; (define-key dired-mode-map "F" 'dired-do-find-marked-files)
;; (define-key dired-mode-map "Y" 'dired-do-relsymlink)
;; (define-key dired-mode-map "%Y" 'dired-do-relsymlink-regexp)
;; (define-key dired-mode-map "V" 'dired-do-run-mail)
(require 'dired-x) ; provide extra commands dired


(require 'wdired)
(setq
 wdired-allow-to-change-premissions t 	; allow to edit permission bits
 widred-allow-to-redirect-links		; allow to edit symlinks
 )

(recentf-mode)
(setq
 recentf-max-menu-items 30
 recentf-max-saved-items 5000 )

(require 'dired+)
(require 'recentf-ext)

(after-load 'vc-git
  (require-package 'magit)
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (setq magit-section-show-child-count t)
  (setq magit-diff-arguments '("--histogram"))
  (setq magit-push-always-verify nil))

(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)

(require 'use-package)
;; (use-package auto-compile
;;              :ensure t
;;              :init (auto-compile-on-load-mode))
;; (setq load-prefer-newer t)

;; (require 'whitespace)
;; (setq whitespace-style '(face empty tabs lines-tail trailing))
;; (global-whitespace-mode nil)

(provide 'setup-files)
;;; setup-files.el ends here
