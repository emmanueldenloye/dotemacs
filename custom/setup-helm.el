;;; package --- Summary
;;; Commentary:
;;; Code:

(require-package 'helm)
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite  close to "C-x C-c", which  quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)   ; make TAB works in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action)		    ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p t	;open helm buffer inside current winow, not occupy whole other window
      helm-move-to-line-cycle-in-source t ;move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-libray-in-sexp t     ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount t                ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(helm-autoresize-mode t)

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ; optional fuzzy matching for helm-M-x

;; I have (key-chord y y) set up to do helm-show-kill-ring
;; (global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;;  I am reverting back to the default.
(global-set-key (kbd "M-y") 'yank-pop)

(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-mini)

(global-set-key (kbd "C-c h M-g g") 'helm-do-grep)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack grep -Hn --no-group --no-color %e %p %f"
	helm-grep-default-recurse-command "ack grep -H --no-group --no-color %e %p %f"))

(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t)

(setq helm-file-cache-fuzzy-match t)
(setq helm-lisp-fuzzy-completion t)
(setq helm-apropos-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)
(setq helm-mode-fuzzy-match t)

(setq helm-input-idle-delay 0.02)
(setq helm-candidate-number-limit 100)

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(setq helm-locate-fuzzy-match t)

(global-set-key (kbd "C-c h k") 'helm-descbinds)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h x") 'helm-register)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)
(global-set-key (kbd "C-c h M-:") 'helm-eval-expression-with-eldoc)
(add-hook 'eshell-mode-hook #'(lambda () (define-key eshell-mode-map (kbd "C-c C-l") 'helm-eshell-history)))
(define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)

(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)

(global-set-key (kbd "C-c h C-b") 'helm-bibtex)

(require-package 'helm-descbinds)
(require 'helm-descbinds)
(helm-descbinds-mode)
(diminish 'helm-mode)

(require-package 'helm-unicode)
(require 'helm-unicode)

(provide 'setup-helm)
;;; setup-helm.el ends here
