;;; package --- Summary
;;; Commentary:
;;; Code:
(require-package 'guide-key)
(require 'guide-key)

(setq guide-key/guide-key-sequence '("C-c" "C-x 4" "C-x 5" "C-x r" "C-x n" "C-c h"))
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(setq guide-key/idle-delay 2)
(guide-key-mode 1)

(diminish 'guide-key-mode)

(provide 'setup-guide-key)
;;; setup-guide-key.el ends here
