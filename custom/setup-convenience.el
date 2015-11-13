;;; package -- Summary
;;; Commentary:
;;; Code:


(eval-when-compile
  (defvar ibuffer-use-other-window))

;; GROUP: Convenience -> Workgroups
(require 'workgroups)
;; Change some settings
;; (workgroups-mode 1)

(when (eq major-mode 'emacs-lisp-mode)
  (diminish 'workgroups-mode))

;; update any change made on file to the current buffer
(global-auto-revert-mode)

;; hippie-expand is a better version of dabbrev-expand
;; While dabbrev-expand searches for words you already tyed, in
;; current buffer and other buffers, hippie-expand includes more sources,
;; such as filenames, kill ring...
(global-set-key (kbd "M-/") 'hippie-expand) ; replace dabbrev-expand
(setq
 hippie-expand-try-functions-list
 '(try-expand-dabbrev ;; Try to  expand word "dynamically", searching the entire buffer.
   try-expand-dabbrev-all-buffers ;; Try to expand word "dynamically", searching all other buffers.
   try-expand-dabbrev-from-kill ;; Try to expand word "dynamically", searching the kill ring.
   try-complete-file-name-partially ;; Try to complete text as a file name, as many characters as unique.
   try-complete-file-name ;; Try to complete text as a file name.
   try-expand-all-abbrevs ;; Try to expand word before point according to all abbrev tables.
   try-expand-list ;; Try to complete list to an entire list in the buffer.
   try-expand-line ;; Try to complete the current line to an entire line in the buffer.
   try-complete-lisp-symbol-partially ;; Try to complete as an Emacs Lisp symbol, as many characters as unique
   try-complete-lisp-symbol)) ;; Try to complete word as an Emacs Lisp symbol.

(global-hl-line-mode)

(setq ibuffer-use-other-window t) ;; always display ibuffer in another window.

;; (require 'hackernews)


(require 'linum-relative)

(add-hook 'prog-mode-hook (lambda ()
                            (linum-mode)
                            (linum-relative-on)
                            (setq linum-relative-current-symbol "")))
;; enable linum only in programming modes or when said so at a later time.
(global-set-key (kbd "C-c C-l t") 'linum-relative-toggle)

;; Align regexp is a beautiful function.
;; Include this function as an operator in evil-mode.

(global-set-key (kbd "C-x /") 'align-regexp)

;; whenever you create useless whitespace, the whitespace is highlighted
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; activate whitespace-mode to view all whitepsace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

(show-paren-mode 1)

(if (fboundp 'with-eval-after-load)
    (defmacro after-load (feature &rest body)
      "After FEATURE is loaded, evaluate BODY"
      (declare (indent defun))
      `(with-eval-after-load ,feature ,@body))
  (defmacro after-load (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent  defun))
    `(eval-after-load ,feature
       '(progn ,@body))))




(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (if (get-buffer-new-name)
        (message "A buffer named '%s' already exists!" new-name)
      (progn
        (when (file-exists-p filename)
          (rename-file filename new-name 1))
        (rename-buffer new-name)
        (set-visited-file-name new-name)))))

(defun delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (or (buffer-file-name) (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
      (delete-file (buffer-file-name))
      (kill-this-buffer)))

(defun my-goto-scratch-buffer ()
  "Create a new scratch buffer."
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (emacs-lisp-mode))

(defun my-insert-last-kbd-macro ()
  "Insert the last keyboard macro into current buffer."
  (interactive)
  (name-last-kbd-macro 'my-last-macro)
  (insert-kbd-macro 'my-last-macro))

(defun sanityinc/string-all-matches (regex str &optional group)
  "Find all matches for `REGEX' within `STR', returning the full match string or group `GROUP'."
  (let ((result nil)
        (pos 0)
        (group (or group 0)))
    (while (string-match regex str pos)
      (push (match-string group str) result)
      (setq pos  (match-end group)))
    result))

(defun sanityinc/string-rtrum (str)
  "Remove trailing whitespace from `STR'."
  (replace-regexp-in-string "[ \t\n]+$" "" str))

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))


(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION. If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install package '%s': %S" package err)
     nil)))

(defun sanityinc/set-tabulated-list-column-width (col-name width)
  "Set any column with name COL-NAME to the given WIDTH."
  (cl-loop for column across tabulated-list-format
           when (string= col-name (car column))
           do (setf (elt column 1) width)))

(defun sanityinc/maybe-widen-package-menu-columns ()
  "Widen some columns of the package menu table to avoid truncation."
  (when (boundp 'tabulated-list-format)
    (sanityinc/set-tabulated-list-column-width "Version" 13)
    (let ((longest-archive-name (apply 'max (mapcar 'length (mapcar 'car package-archives)))))
      (sanityinc/set-tabulated-list-column-width "Archive" longest-archive-name))))

(add-hook 'package-menu-mode-hook 'sanityinc/maybe-widen-package-menu-columns)

;; (defalias 'yes-or-no-p 'yes-or-no-p)

(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "C-x C-m") 'execute-extended-command)

(global-set-key (kbd "C-c h k") 'helm-descbinds)

(global-set-key (kbd "C-c J") 'join-line)

(global-set-key (kbd "C-c j") 'eod/join-next-line)

(projectile-global-mode)

(defun switch-to-previous-buffer ()
"Switch to previous buffer. What else do you need to know?"
 (interactive)
 (switch-to-buffer (other-buffer (current-buffer) 1)))


(require-package 'multiple-cursors)
;; multiple-cursors
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)

(global-set-key (kbd "C-c c r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c c c") 'mc/edit-lines)
(global-set-key (kbd "C-c c e") 'mc/edit-end-of-lines)
(global-set-key (kbd "C-c c a") 'mc/edit-beginnings-of-lines)

(add-hook 'emacs-lisp-mode-hook (lambda () (highlight-symbol-mode -1)))
(add-hook 'ielm-mode-hook (lambda () (highlight-symbol-mode -1)))
(add-hook 'lisp-mode-hook (lambda () (highlight-symbol-mode -1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (highlight-symbol-mode -1)))

(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))

(global-set-key (kbd "C-M-@") 'kill-back-to-indentation)

(require-package 'page-break-lines)
(dolist (hook '(org-mode-hook LaTeX-mode-hook))
  (add-hook hook 'page-break-lines-mode))
;; (diminish 'page-break-lines-mode)

(require-package 'highlight-escape-sequences)
(hes-mode)

(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "xx" 'helm-M-x)
(key-chord-define-global "JJ" 'switch-to-previous-buffer)
(key-chord-define-global "uu" 'undo-tree-visualize)
(key-chord-define-global "xb" 'helm-mini)
(key-chord-define-global "xf" 'helm-find-files)
(key-chord-define-global "yy" 'browse-kill-ring)

(require-package 'flycheck)
(require 'flycheck)

(setq flycheck-check-syntax-automatically '(save-mode-enabled))
(setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
(global-flycheck-mode t)

(require 'avy)
(avy-setup-default)

(setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
(setq avy-all-windows 'all-frames)
(setq avy-background t)

;; key chords are nice
(key-chord-define-global "jc" 'avy-goto-char-in-line)
(key-chord-define-global "jj" 'avy-goto-char)
(key-chord-define-global "jk" 'avy-goto-word-or-subword-1)
(key-chord-define-global "jl" 'avy-goto-line)
(global-set-key (kbd "C-c a c") 'avy-copy-line)
(global-set-key (kbd "C-C a p") 'avy-pop-mark)
(global-set-key (kbd "C-c a m") 'avy-move-line)
(global-set-key (kbd "C-c a r") 'avy-copy-region)
(global-set-key (kbd "C-c a s") 'avy-isearch)

;; Modify this code to perform avy-save-kill-region... That would be sweet!
;; (defun avy-copy-region ()
;;   "Select two lines and copy the text between them here."
;;   (interactive)
;;   (avy-with avy-copy-region
;;     (let ((beg (avy--line))
;;           (end (avy--line))
;;           (pad (if (bolp) "" "\n")))
;;       (move-beginning-of-line nil)
;;       (save-excursion
;;         (insert
;;          (buffer-substring-no-properties
;;           beg
;;           (save-excursion
;;             (goto-char end)
;;             (line-end-position)))
;;          pad)))))

(key-chord-define-global "xk" 'eod-kill-buffer)

(defun eod-kill-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'org-mode-hook #'rainbow-delimiters-mode)

(require-package 'elisp-slime-nav)
(require 'elisp-slime-nav)
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'turn-on-elisp-slime-nav-mode))

(setq frame-title-format '(buffer-file-name "%f" ("%b")))

(mouse-avoidance-mode 'banish)

(require 'anzu)

(defun dont-kill-emacs ()
  (interactive)
  (error (substitute-command-keys "To exit emacs: \\[kill-emacs]")))

(global-set-key "\C-x\C-c" 'dont-kill-emacs)

(defun mplayer ()
  "An interface to mplayer."
  (interactive)
  (shell-command (concat "xterm -e mplayer "
                         (shell-quote-argument
                          (expand-file-name
                           (read-file-name "Filename: ")))
                         "& ")))

(defun unpop-to-mark-command ()
  "Unpop off mark ring. Does nothing if mark ring is empty."
  (interactive)
  (when mark-ring
    (let ((pos (marker-position (car (last mark-ring)))))
      (if (not (= (point) pos))
          (goto-char pos)
        (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
        (set-marker (mark-marker) pos)
        (setq mark-ring (nbutlast mark-ring))
        (goto-char (marker-position (car (last mark-ring))))))))

(global-set-key (kbd "C-S-SPC") 'unpop-to-mark-command)

(defun date (&optional insert)
  "Display the current date and time.
With a prefix arg, INSERT it into the buffer."
  (interactive "p")
  (funcall (if insert 'insert 'message)
           (format-time-string "%a, %d, %b, %Y, %T, %Z" (current-time))))

(global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
(global-set-key (kbd "C-M-%") 'anzu-query-replace)
(setq anzu-lighter "")
(setq anzu-deactivate-region t)
(setq anzu-search-threshold 1000)
(setq anzu-replace-to-string-separator " => ")

(defun reload-init-file ()
  "Reload init.el file"
  (interactive)
  (load user-init-file)
  (message "Reloaded init.el OK."))

(defun open-init-file ()
  (interactive)
  (find-file user-init-file))

(defun open-as-root ()
  "Open a file as root."
  (find-file (concat "/sudo:root@localhost:" filename)))


(defun open-buffer-as-root ()
  (interactive)
  (let ((filename (buffer-file-name (current-buffer)))
        (bufname (buffer-name (current-buffer))))
    (progn
      (kill-buffer bufname)
      (open-as-root filename))))

(defun prelude-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard. " filename ))))

(setq ispell-dictionary "american")

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)


;;; set up smartparens for config files
(add-hook 'conf-space-mode-hook 'turn-on-smartparens-mode)
(remove-hook 'conf-space-mode-hook #'disable-paredit-mode)
(provide 'setup-convenience)
;;; setup-convenience.el ends here
