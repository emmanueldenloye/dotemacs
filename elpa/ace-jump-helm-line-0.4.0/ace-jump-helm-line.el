;;; ace-jump-helm-line.el --- Ace-jump to a candidate in helm window

;; Copyright (C) 2015  Junpeng Qiu

;; Author: Junpeng Qiu <qjpchmail@gmail.com>
;; URL: https://github.com/cute-jumper/ace-jump-helm-line
;; Package-Version: 0.4.0
;; Keywords: extensions
;; Version: 0.4.0
;; Package-Requires: ((avy "0.4.0") (helm "1.6.3"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;                           ____________________

;;                            ACE-JUMP-HELM-LINE

;;                               Junpeng Qiu
;;                           ____________________


;; Table of Contents
;; _________________

;; 1 Setup
;; 2 Usage
;; .. 2.1 Keys & UI
;; .. 2.2 Different Actions: move-only, persistent or select
;; 3 Example settings
;; 4 Demos(only showing the basic feature)
;; 5 Similar Package
;; 6 Acknowledgment


;; [[file:http://melpa.org/packages/ace-jump-helm-line-badge.svg]]
;; [[file:http://stable.melpa.org/packages/ace-jump-helm-line-badge.svg]]

;; *Ace-jump to a candidate in helm window.*

;; This package makes use of the `avy.el'.


;; [[file:http://melpa.org/packages/ace-jump-helm-line-badge.svg]]
;; http://melpa.org/#/ace-jump-helm-line

;; [[file:http://stable.melpa.org/packages/ace-jump-helm-line-badge.svg]]
;; http://stable.melpa.org/#/ace-jump-helm-line


;; 1 Setup
;; =======

;;   ,----
;;   | (add-to-list 'load-path "/path/to/ace-jump-helm-line.el")
;;   | (require 'ace-jump-helm-line)
;;   `----

;;   You can use the following code to bind `ace-jump-helm-line' to a
;;   key(say, C-'):
;;   ,----
;;   | (eval-after-load "helm"
;;   | '(define-key helm-map (kbd "C-'") 'ace-jump-helm-line))
;;   `----


;; 2 Usage
;; =======

;;   When in a helm session, for example, after you call `helm-M-x', you
;;   can use your key binding(for example, C-') to invoke
;;   `ace-jump-helm-line'. See the following demos.

;;   *Note*: Since *2016-02-19*, you can configure `ace-jump-helm-line' in
;;   a similar way as `avy'. The old-fashioned variable
;;   `ace-jump-helm-line-use-avy-style' is discarded now. There is no
;;   effect by setting this variable(I dropped this variable because `avy'
;;   has become much more configurable since I first developed this
;;   package).


;; 2.1 Keys & UI
;; ~~~~~~~~~~~~~

;;   You can customize following variables:
;;   1. `ace-jump-helm-line-keys': the keys to be used for
;;      `ace-jump-helm-line'. If you don't set this variable, `avy-keys'
;;      will be used.
;;   2. `ace-jump-helm-line-style': You can set the styles to be used for
;;      `ace-jump-helm-line'. The values can be `pre', `at', `at-full',
;;      `post', and `de-bruijn', the same as `avy-style'. If you don't set
;;      this variable, `avy-style' will be used.
;;   3. `ace-jump-helm-line-background': Whether you want to use a
;;      background or not. The default value is `nil'.

;;   For old version users: if you want to achieve the same effect of
;;     `(setq ace-jump-helm-line-use-avy-style nil)', use the following
;;     code:
;;   ,----
;;   | (setq ace-jump-helm-line-keys (number-sequence ?a ?z))
;;   | (setq ace-jump-helm-line-style 'at)
;;   | (setq ace-jump-helm-line-background t)
;;   `----


;; 2.2 Different Actions: move-only, persistent or select
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;   You can now specify the action that will be executed after the cursor
;;   has been moved to the candidate. This is controlled by the value of
;;   `ace-jump-helm-line-default-action'. Three different kinds of values
;;   are available:
;;   1. `nil' or `move-only': This is the default one. Just move the cursor
;;      to the candidate and do nothing.
;;   2. `persistent': After the cursor has been moved to the candidate,
;;      execute the persistent action on that candidate.
;;   3. `select': After the cursor has been moved to the candidate, select
;;      the candidate and exit the helm session.

;;   Thanks to `avy' 0.4.0, we can now switch the action after we see the
;;   avy prompt. Three different keys can be used to switch the action:
;;   1. `ace-jump-helm-line-move-only-key'
;;   2. `ace-jump-helm-line-persistent-key'
;;   3. `ace-jump-helm-line-select-key'

;;   For example, if we have following settings:
;;   ,----
;;   | (setq ace-jump-helm-line-default-action 'select)
;;   | ;; The following line is not needed
;;   | (setq ace-jump-helm-line-select-key ?e)
;;   | (setq ace-jump-helm-line-move-only-key ?o)
;;   | (setq ace-jump-helm-line-persistent-key ?p)
;;   `----

;;   Say after we invoke `ace-jump-helm-line', we can use f to jump to a
;;   candidate. Since the default action is `select', the candidate will be
;;   automatically selected and the helm session will be ended after the
;;   cursor has been moved to it. But suddenly I change my mind and only
;;   want to move to it. Instead of pressing f, I can press of where o is
;;   defined by the `ace-jump-helm-line-move-only-key' and is used to
;;   switch the action to `move-only'. Similarly, if I press pf, then the
;;   persistent action on the candidate will be executed.

;;   Note in this example, setting `ace-jump-helm-line-select-key' has no
;;   effect because the default action is `select'. It makes no senses that
;;   we need to have an extra key to switch to the `select' action. So if
;;   your default action is `nil' or `move-only',
;;   `ace-jump-helm-line-move-only-key' is not needed and
;;   `ace-jump-helm-line-persistent-key' is not needed if your default
;;   action is `persistent'. However, you're *safe* to set these variables
;;   regardless of your default action since the variable corresponding to
;;   your default action will just be ignored.

;;   For compatibility issues, there are also two identical pre-defined
;;   commands: `ace-jump-helm-line-and-select' and
;;   `ace-jump-helm-line-execute-action'. Their default action is to select
;;   the candidate and exit the helm session. Now you can achieve the same
;;   effect using `ace-jump-helm-line' by the following setting:
;;   ,----
;;   | (setq ace-jump-helm-line-default-action 'select)
;;   `----


;; 3 Example settings
;; ==================

;;   ,----
;;   | (eval-after-load "helm"
;;   | '(define-key helm-map (kbd "C-'") 'ace-jump-helm-line))
;;   | ;; or if using key-chord-mode
;;   | ;; (eval-after-load "helm"
;;   | ;;  '(key-chord-define helm-map "jj" 'ace-jump-helm-line))
;;   | (setq ace-jump-helm-line-style 'pre)
;;   | (setq ace-jump-helm-line-background t)
;;   | (setq ace-jump-helm-line-default-action 'select)
;;   | ;; The following line is not needed
;;   | (setq ace-jump-helm-line-select-key ?e)
;;   | (setq ace-jump-helm-line-move-only-key ?o)
;;   | (setq ace-jump-helm-line-persistent-key ?p)
;;   `----


;; 4 Demos(only showing the basic feature)
;; =======================================

;;   The following demo are recorded in pre-0.4 version. It's a little
;;   out-dated.

;;   Use `avy' style to jump to a helm candidate:
;;   [./screencasts/avy-jump-style.gif]

;;   Or use a different style similar to `ace-jump-mode' (by setting the
;;   values of `ace-jump-helm-line-keys', `ace-jump-helm-line-style' and
;;   `ace-jump-helm-line-background'):
;;   [./screencasts/ace-jump-mode-style.gif]

;;   The new features after v0.4 are not recorded yet.:-(


;; 5 Similar Package
;; =================

;;   [This issue of Helm] has been solved by adding a new minor mode
;;   `helm-linum-relative-mode' to `linum-relative'. You can take a look if
;;   you don't like `avy' and want to find an alternative. As a heavy user
;;   of `avy', I don't find the way that `helm-linum-relative-mode'
;;   provides very appealing. Thanks to `avy', this package provides more
;;   customizations and more consistent user experience for `avy' users.


;;   [This issue of Helm] https://github.com/emacs-helm/helm/issues/1257


;; 6 Acknowledgment
;; ================

;;   - Thank [Oleh Krehel] for the awesome [avy] package.
;;   - Thank @hick for the original idea.


;;   [Oleh Krehel] https://github.com/abo-abo/

;;   [avy] https://github.com/abo-abo/avy

;;; Code:

(require 'avy)
(require 'helm)

(defvar ace-jump-helm-line-keys nil
  "Keys used for `ace-jump-helm-line'.")
(defvar ace-jump-helm-line-style nil
  "Style used for `ace-jump-helm-line'.")
(defvar ace-jump-helm-line-background nil
  "Use background or not in `ace-jump-helm-line'.")

(defvar ace-jump-helm-line-use-avy-style t
  "Useless variable since v0.4.
Please set `ace-jump-helm-line-keys', `ace-jump-helm-line-style'
and `ace-jump-helm-line-background' instead.")

(defvar ace-jump-helm-line-persistent-key nil
  "The key to perform persistent action.")

(defvar ace-jump-helm-line-select-key nil
  "The key to select.
Used for `ace-jump-helm-line'.")

(defvar ace-jump-helm-line-move-only-key nil
  "The key to only move the selection.
 Used for `ace-jump-helm-line-and-select'.")

(defvar ace-jump-helm-line-default-action nil
  "The default action when jumping to a candidate.")

(defvar ace-jump-helm-line--action-type nil)

(defun ace-jump-helm-line-action-persistent (pt)
  (goto-char pt)
  (setq ace-jump-helm-line--action-type 'persistent)
  (ace-jump-helm-line--move-selection)
  (helm-execute-persistent-action))

(defun ace-jump-helm-line-action-select (pt)
  (goto-char pt)
  (setq ace-jump-helm-line--action-type 'select)
  (ace-jump-helm-line--move-selection)
  (helm-exit-minibuffer))

(defun ace-jump-helm-line-action-move-only (pt)
  (goto-char pt)
  (setq ace-jump-helm-line--action-type 'move-only)
  (ace-jump-helm-line--move-selection))

(defun ace-jump-helm-line--move-selection ()
  (let ((orig-point (point)))
    (helm-move-selection-common :where 'line :direction 'previous)
    (unless (= (point) orig-point)
      (helm-move-selection-common :where 'line :direction 'next))))

(defun ace-jump-helm-line--get-dispatch-alist ()
  (when (boundp 'avy-dispatch-alist)
    (let* ((default-action (or ace-jump-helm-line-default-action
                               'move-only))
           (full-list (list 'persistent 'select 'move-only))
           (action-list (delete default-action full-list))
           dispatch-alist)
      (dolist (w action-list dispatch-alist)
        (let ((key-sym (intern (format "ace-jump-helm-line-%s-key" w)))
              (action-sym (intern (format "ace-jump-helm-line-action-%s" w))))
          (eval `(and ,key-sym
                      (push (cons ,key-sym ',action-sym) dispatch-alist))))))))

(defun ace-jump-helm-line--collect-lines ()
  "Select lines in helm window."
  (let (candidates)
    (save-excursion
      (save-restriction
        (narrow-to-region (window-start) (window-end (selected-window) t))
        (goto-char (point-min))
        (while (or (helm-pos-header-line-p)
                   (helm-pos-candidate-separator-p))
          (forward-line 1))
        (while (< (point) (point-max))
          (push (cons (point) (selected-window))
                candidates)
          (forward-line 1)
          (while (and (or (helm-pos-header-line-p)
                          (helm-pos-candidate-separator-p))
                      (< (point) (point-max)))
            (forward-line 1)))))
    (nreverse candidates)))

(defun ace-jump-helm-line--do ()
  (if helm-alive-p
      (let* ((orig-window (selected-window))
             (avy-background ace-jump-helm-line-background)
             (avy-keys (or ace-jump-helm-line-keys
                           avy-keys))
             (avy-dispatch-alist (ace-jump-helm-line--get-dispatch-alist))
             avy-action
             avy-all-windows)
        (unwind-protect
            (with-selected-window (helm-window)
              (avy--process (ace-jump-helm-line--collect-lines)
                            (avy--style-fn
                             (or ace-jump-helm-line-style
                                 avy-style)))
              (or avy-action
                  (ace-jump-helm-line--move-selection))))
        (select-window orig-window))
    (error "No helm session is running")))

(defun ace-jump-helm-line--post ()
  (and helm-alive-p
       (eq ace-jump-helm-line-default-action
           ace-jump-helm-line--action-type)
       (cond
        ((eq ace-jump-helm-line-default-action 'select)
         (helm-maybe-exit-minibuffer))
        ((eq ace-jump-helm-line-default-action 'persistent)
         (helm-execute-persistent-action)))))

;;;###autoload
(defun ace-jump-helm-line ()
  "Jump to a candidate and execute the default action."
  (interactive)
  (let ((ace-jump-helm-line--action-type
         ace-jump-helm-line-default-action))
    (ace-jump-helm-line--do)
    (ace-jump-helm-line--post)))

;;;###autoload
(defun ace-jump-helm-line-and-select ()
  "Jump to and select the candidate in helm window."
  (interactive)
  (let ((ace-jump-helm-line-default-action 'select))
    (ace-jump-helm-line)))

;;;###autoload
(defalias 'ace-jump-helm-line-execute-action 'ace-jump-helm-line-and-select)

(make-obsolete-variable 'ace-jump-helm-line-use-avy-style nil "0.4")

(provide 'ace-jump-helm-line)
;;; ace-jump-helm-line.el ends here
