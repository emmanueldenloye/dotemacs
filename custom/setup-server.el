;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'server)
(unless (server-running-p)
  (server-start))


(provide 'setup-server)
;;; setup-server.el ends here
