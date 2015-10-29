;; ;;; package --- Summary
;; ;;; Commentary:
;; ;;; Code:


;; (remove-hook 'org-mode-hook (lambda ()
;;                             (linum-mode)
;;                             (linum-relative-on)
;;                             (setq linum-relative-current-symbol "")))


(setq org-src-fontify-natively t)

(require 'ox-latex)
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection\{%s\}")))

;;; Work on this later
;; (defun my/insert-org-export-backend (val)
;;   "Add a backend to org-export-backends,
;; even if  org.el has already been loadede"
;;   (progn
;;     (setq org-export--registered-backends
;;           (org-remove-if-not
;;            (lambda (backend)
;;              (let ((name (org-export-backend-name backend)))
;;                (or (memq name val)
;;                    (catch 'parentp
;;                      (dolist (b val)
;;                        (and (org-export-derived-backend-p b name)
;;                             (throw 'parentp t)))))))
;;            org-export--registered-backends))
;;     (let ((new-list (mapcar 'org-export-backend-name
;;                             org-export--registered-backends)))
;;       (dolist (backend val)
;;         (cond
;;          ((not (load (format "ox-%s" backend) t t))
;;           (message "Problems while trying to load export back-end `%s'"
;;                    backend))
;;          ((not (memq backend new-list)) (push backend new-list))))
;;       (set-default 'org-export-backends new-list))))

;; (when (< emacs-major-version 24)
;;   (require-package 'org))
;; (require-package 'org-fstree)

;; (global-set-key (kbd "C-c a") 'org-agenda)

;; ;;Various preferences
;; (setq org-log-done 'time
;;       org-edit-timestamp-down-means-later t
;;       org-catch-invisible-edits 'show
;;       org-export-coding-system 'utf-8
;;       ;;org-fast-tag-selection-single-key 'expert
;;       org-tags-column 80)


;; ;; (setq  org-support-shift-select t)

;; (global-set-key (kbd "C-c c") 'org-capture)

;; (setq org-capture-templates
;;       `(("t" "todo" entry (file "")     ; " => org-default-notes-file
;;          "* NEXT %?\n%U\n" :clock-resume t)
;;         ("n" "note" entry (file "")
;;          "* %? :NOTE:\n%U\n%a\n" :clock-resume t)))

;; (setq org-refile-use-cache nil)

;; ;; Targets include this file and any file contributing
;; (setq org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5)))

;; (after-load 'org-agenda
;;   (add-to-list 'org-agenda-after-show-hook 'org-show-entry))

;; ;; Exclude DONE state tasks from refile targets
;; (defun sanityinc/verify-refile-target ()
;;   "Exclude todo keywords with a done state from refile targets."
;;   (not (member (nth 2 (org-heading-components)) org-done-keywords)))

;; ;;; Targets start with the file name - allows creating level 1 tasks
;; (setq org-refile-use-outline-path t)
;; (setq org-outline-path-complete-in-steps nil)

;; (setq org-refile-allow-creating-parent-nodes 'confirm)

;; ;; To-do settings

;; (setq org-todo-keywords
;;       (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
;;               (sequence "PROJECT(p)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
;;               (sequence "WAITING(w@/!)" "HOLD(h)" "|" "CANCELLED(c@/!)"))))

;; (setq org-todo-keyword-faces
;;       (quote (("NEXT" :inherit warning)
;;               ("PROJECT" :inherit font-lock-string-face))))

;; ;; Agenda views

;; (let ((activate-project-match "-INBOX/PROJECT"))
;;   (setq org-stuck-projects
;;         `(,active-project-match ("NEXT")))

;;   (setq org-agenda-compact-blocks t
;;         org-agenda-sticky t
;;         org-agenda-start-on-weekday nil
;;         org-agenda-span 'day
;;         org-agenda-include-diary nil
;;         org-agenda-sorting-strategy
;;         '((agenda habit-down time-up )))

;;   )
;;; TO DO AT A LATER TIME.
(provide 'setup-org)
;;; setup-org.el ends here
