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
    (kill-buffer (current-buffer))))

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

(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

(defun switch-to-previous-buffer ()
  "Switch to previous buffer. What else do you need to know?"
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun eod-kill-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun eod-insert-buffer-directory ()
  "Insert the directory of the current bufer (FILENAME)"
  (interactive)
  (let ((filename (buffer-file-name)))
    (when (and
           (not (file-directory-p filename))
           (file-exists-p filename)
           (eq major-mode 'dired-mode))
      (insert (file-name-directory filename)))))

(defun eod-view-buffer-directory ()
  "View the directory of the current bufer (FILENAME)"
  (interactive)
  (let ((filename (buffer-file-name)))
    (when (and
           (not (file-directory-p filename))
           (file-exists-p filename)
           (eq major-mode 'dired-mode))
      (message (file-name-directory filename)))))

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

(defun dont-kill-emacs ()
  (interactive)
  (error (substitute-command-keys "To exit emacs: \\[kill-emacs]")))

(global-set-key "\C-x\C-c" 'dont-kill-emacs)

(defun mplayer ()
  "An interface to mplayer."
  (interactive)
  (shell-command (concat "gnome-term -e mplayer "
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

(defun eod/join-next-line ()
  "Join the next line with the current one."
  (interactive)
  (join-line 1))

(defun eod/dropbox-status-message ()
  "Get the current dropbox status."
  (interactive)
  (if (equal 1 (shell-command "dropbox running"))
      (message "Dropbox is running.")
    (message "Dropbox is not running.")))

(defun eod/dropbbox-print-puburl-file ()
  "Print the public url of the current file."
  (interactive)
  (when (file-in-directory-p
         (buffer-file-name)
         "~/Dropbox")
    (async-shell-command
     (concat
      "dropbox puburl "
      (buffer-file-name)))))

(defun eod/dropbbox-print-filestatus ()
  "Print the status of the current file."
  (interactive)
  (when (file-in-directory-p
         (buffer-file-name)
         "~/Dropbox")
    (async-shell-command
     (concat
      "dropbox filestatus "
      (buffer-file-name)))))

(defun eod/dropbbox-print-directory-status ()
  "Print the status of the file's current directory."
  (interactive)
  (when (file-in-directory-p
         (buffer-file-name)
         "~/Dropbox")
    (async-shell-command
     (concat "dropbox filestatus "
             (file-name-directory (buffer-file-name))))))

(defun eod/sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file
       (concat
        "/sudo:root@localhost:"
        (helm-read-file-name "File: ")))
    (find-alternate-file
     (concat
      "/sudo:root@localhost:"
      buffer-file-name))))

(defun eod/search-google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                         (read-string "Search Google: "))))))

(global-set-key (kbd "C-c / g") 'eod/search-google)

(defun eod/search-duckduckgo ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "https://duckduckgo.com/?q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                         (read-string "Search DuckDuckGo: ")))
    "&ia=about")))

(global-set-key (kbd "C-c / d") 'eod/search-duckduckgo)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car next-win-edges))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(add-hook 'emacs-startup-hook 'toggle-window-split)

(global-set-key (kbd "C-c C-.") 'toggle-window-split)

(defun try-expand-flexible-abbrev (old)
  "Try to complete word using flexible matching. Flexible matching works by
taking the search string and then interspersing it with a regexp for any
character. So, if you try to do a flexible match for `foo' it will match the
word `findOtherOtter' but also `fixTheBoringOrange' and
`ifthisisboringstopreadingnow'. The argument OLD has to be nil the first call
of this function, and t for subsequent calls (for further possible completions
of the same string). It returns t if a new completion is found, nil otherwise."
  (if (not old)
      (progn
        (he-init-string (he-lisp-symbol-beg) (point))
        (if (not (he-string-member he-search-string he-tried-table))
            (setq he-tried-table (cons he-search-string he-tried-table)))
        (setq he-expand-list
              (and (not (equal he-search-string ""))
                   (he-flexible-abbrev-collect he-search-string)))))
  (while (and he-expand-list
              (he-string-member (car he-expand-list) he-tried-table))
    (setq he-expand-list (cdr he-expand-list)))
  (if (null he-expand-list)
      (progn
        (if old (he-reset-string))
        ())
    (progn
      (he-substitute-string (car he-expand-list))
      (setq he-expand-list (cdr he-expand-list))
      t)))

(defun he-flexible-abbrev-collect (str)
  "Find and collect all words that flex-matches STR.
 See docstring for `try-expand-flexible-abbrev' for information about what
flexible matching means in this context."
  (let ((collection nil)
        (regexp (he-flexible-abbrev-create-regexp str)))
    (save-excursion
      (goto-char (point-min))
      (while (search-forward-regexp regexp nil t)
        ;; Is there a better or quicker way than using
        ;; `thing-at-point' here?
        (setq collection (cons (thing-at-point 'word) collection))))
    collection))

(defun he-flexible-abbrev-create-regexp (str)
  "Generate regexp for flexible matching of STR.
See docstring for `try-expand-flexible-abbrev' for information
about what flexible matching means in this context."
  (concat "\\b" (mapconcat (lambda (x) (concat "\\w*" (list x))) str "")
          "\\w*" "\\b"))

(add-to-list 'hippie-expand-try-functions-list 'try-expand-flexible-abbrev)

(defun eod-comment-or-uncomment-line (arg)
  "Comment or uncomment the current line. This command's inner
  operations do not pay attention to the current major mode, so be
  mindful about parentheses getting clobbered in lisp modes."
  (interactive "p")
  (let (start end)
    (save-excursion
      (when (not (eq arg 0))
        (if (< arg 0)
            (progn
              (end-of-line)
              (setq end (point))
              (forward-line arg)
              (setq start (point)))
          (progn
            (beginning-of-line)
            (setq start (point))
            (forward-line arg)
            (setq end (point))))
        (comment-or-uncomment-region start end)))))

(global-set-key (kbd "C-c C-;") 'eod-comment-or-uncomment-line)

(defun eod-insert-dollar ()
  "Insert a dollar into the buffer. If you are in an org or latex
buffer, perform the desirable action."
  (interactive)
  (if (member major-mode
              '(org-mode latex-mode))
      (progn
        (insert "$$")
        (backward-char))
    (insert "$")))

(provide 'init-defuns)
;; init-defuns.el ends here
