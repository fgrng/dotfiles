;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      latex.emacs
;; --- Description:   Init File for Emacs.
;; ---                LaTeX Settings, loaded by .emacs
;; ---                

;; --- Initialize -----------------------------------------------------

(load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

(setq TeX-auto-save nil)
(setq TeX-parse-self t)
;; (setq-default TeX-master nil)

(setq TeX-open-quote "\"`")
(setq Tex-close-quote "\"'")

;; ---

;; Hooks
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; RefTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
(setq reftex-plug-into-AUCTeX t)

;; ---

;; Math-Mode & stuff
(setq TeX-electric-sub-and-superscript t)
(setq LaTeX-math-menu-unicode t)

(setq LaTeX-math-abbrev-prefix "@")

;; Preview LaTeX
(setq preview-image-type "png")

;; --- Auto Complete -------------------------------------------------

(require 'auto-complete-auctex)

;; ---

(require 'ac-math)

(add-to-list 'ac-modes 'LaTeX-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))

(add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)

;; ---

(ac-flyspell-workaround)

;; --- Commands -------------------------------------------------------

(require 'tex)
(TeX-global-PDF-mode t)

;; --- SycTex ---

(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
