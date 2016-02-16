;;; package --- Summary
;;; Commentary:
;;; Code:

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

(provide 'setup-eod-defuns)
;;; setup-eod-defuns.el ends here
