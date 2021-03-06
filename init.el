;;; package --- Summary
;;; Commentary:
;;; Code:

(add-to-list
 'load-path
 "/home/emmanuel/.emacs.d/my-git-packages/benchmark-init-el/")

(require 'benchmark-init-loaddefs)
(benchmark-init/activate)

(require 'package)
(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-enable-at-startup nil)
(package-initialize)
;; add your modules path
(add-to-list 'load-path "~/.emacs.d/custom/")

(eval-when-compile
  (require 'cl))
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;;; Load and execute the code every .el file in the custom sub directory.
;;; Also load the custom.el file.
;;; If there are any errors, print a message to the back trace buffer.
(let ((debug-on-error t)
      (custom-directory (concat user-emacs-directory "custom/")))

  (setq custom-file
        (concat user-emacs-directory "custom.el"))

  (when (file-exists-p custom-file)
    (load custom-file))

  (cl-loop for file in (directory-files custom-directory t)
           unless (file-directory-p file)
           do (require (intern (file-name-base file)) file)))

(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
