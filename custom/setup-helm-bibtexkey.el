;;; package -- Summary
;;; Commentary
;;; Code:

(add-to-list 'load-path "~/.emacs.d/my-git-packages/helm-bibtexkey/")

(require 'helm-bibtexkey)

(setq helm-bibtexkey-filelist '("~/Dropbox/Research_Files/misc/misc.bib"
                                "~/Dropbox/Research_Files/topology/topology.bib"
                                "~/Dropbox/Research_Files/comp_sense/sense.bib"
                                "~/Dropbox/Research_Files/backgroundSubtraction/backgroundSubtraction.bib"
                                "~/Dropbox/Research_Files/functionalData/functionalData.bib"
                                "~/Dropbox/Research_Files/Mutual_Information/Information.bib"
                                "~/Dropbox/Research_Files/mean_shift/shift.bib"
                                "~/Dropbox/Research_Files/WienerHopf/WienerHopf.bib"
                                "~/Dropbox/Research_Files/OpFlow/OpFlow.bib"
                                "~/Dropbox/Research_Files/objectRecog/objectRecog.bib"))

(provide 'setup-helm-bibtexkey)
;;; setup-helm-bibtexkey.el ends here
