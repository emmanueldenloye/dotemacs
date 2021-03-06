;;; package --- Summary
;;; Commentary:
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#4d4d4c" "#c82829" "#718c00" "#eab700" "#4271ae" "#8959a8" "#3e999f" "#ffffff"))
 '(avy-all-windows (quote all-frames))
 '(company-ghc-show-info t)
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(erc-keywords
   (quote
    ("(\"emmanuel_erc *[,:;]\" \"\\\\bemmanuel[!?.]+$\" \"hey emmanuel\")")))
 '(evil-jumper-mode t)
 '(evil-want-C-u-scroll t)
 '(fci-rule-color "#eee8d5")
 '(gfci-rule-color "#d6d6d6")
 '(global-evil-surround-mode t)
 '(global-evil-visualstar-mode t)
 '(global-prettify-symbols-mode nil)
 '(haskell-complete-module-preferred nil)
 '(haskell-indent-thenelse 2)
 '(haskell-interactive-popup-errors nil)
 '(haskell-process-arg-cabal-repl nil)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-generate-tags t)
 '(haskell-process-log t)
 '(haskell-process-suggest-haskell-docs-imports t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(hindent-style "gibiansky")

 '(save-place t nil (saveplace))
 '(send-mail-function (quote smtpmail-send-it))
 '(set-mark-command-repeat-pop t)
 '(shm-indent-point-after-adding-where-clause t)
 '(shm-lambda-indent-style 0)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#c82829")
     (40 . "#f5871f")
     (60 . "#eab700")
     (80 . "#718c00")
     (100 . "#3e999f")
     (120 . "#4271ae")
     (140 . "#8959a8")
     (160 . "#c82829")
     (180 . "#f5871f")
     (200 . "#eab700")
     (220 . "#718c00")
     (240 . "#3e999f")
     (260 . "#4271ae")
     (280 . "#8959a8")
     (300 . "#c82829")
     (320 . "#f5871f")
     (340 . "#eab700")
     (360 . "#718c00"))))
 '(vc-annotate-very-old-color nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "Source Code Pro"))))
 '(cursor ((t (:background "#Ff69b4"))))
 '(shm-current-face ((t (:background "#eee8d5"))))
 '(shm-quarantine-face ((t (:background "
lemon chiffon")))))
