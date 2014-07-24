;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      latex.emacs
;; --- Author:        Fabian Grünig
;; ---                fabian@mathphys.fsk.uni-heidelebrg.de
;; --- Description:   Init File for Emacs.
;; ---                LaTeX Settings, loaded by .emacs
;; ---                

;; --- Initialize -----------------------------------------------------

;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

(setq TeX-auto-save nil)
(setq TeX-parse-self t)
;; (setq-default TeX-master nil)

(setq TeX-open-quote "\"`")
(setq Tex-close-quote "\"'")

;; ---

;; Hooks
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; RefTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
(setq reftex-plug-into-AUCTeX t)

;; ---

(require 'tex-site)
(cond ((fboundp 'global-font-lock-mode)
  ;; Turn on font-lock in all modes that support it
  (global-font-lock-mode t)
  ;; Maximum colors
  (setq font-lock-maximum-decoration t)))

;; ---

;; Default env.
(setq LaTeX-default-environment 'align*)

;; Math-Mode & stuff
(setq TeX-electric-sub-and-superscript t)
(setq LaTeX-math-menu-unicode t)

(setq TeX-PDF-mode t)

(setq LaTeX-math-abbrev-prefix "@")

;; Preview LaTeX
(setq preview-image-type "png")

;; --- SyncTex --------------------------------------------------------

(setq TeX-source-correlate-method 'synctex)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

;; --- Commands -------------------------------------------------------

(setq TeX-command-list
      (quote (
        ("XeLaTeX_SyncteX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run XeLaTeX")
        ("pdfLaTeXX_SyncteX" "%`pdflatex -synctex=1%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run pdfLaTeX")
        ("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX")
        ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
        ("Biber" "biber %s" TeX-run-BibTeX nil t :help "Run Biber")
        ("View" "%V" TeX-run-discard-or-function nil t :help "Run Viewer")
        ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file")
        ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness")
        ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
        ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
        ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
        ("Other" "" TeX-run-command t t :help "Run an arbitrary command")
        ("Jump to PDF" "%V" TeX-run-discard-or-function nil t :help "Run Viewer")
        )))

(setq TeX-view-program-list
      (quote (
              ("qpdfview" "/usr/bin/qpdfview --unique %o#src:%t:%n:0")
              ("zathura" "/usr/bin/zathura%o"))))
