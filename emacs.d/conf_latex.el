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
(setq-default TeX-master "main")

(setq TeX-open-quote "\"`")
(setq Tex-close-quote "\"'")

;; ---

;; Hooks
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

;; RefTeX
(add-hook 'LaTeX-mode-hook 'reftex-mode)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

(add-hook 'TeX-mode-hook 'zotelo-minor-mode)

;; ---

;; Math-Mode & stuff
(setq TeX-electric-sub-and-superscript t)
(setq LaTeX-math-menu-unicode t)

(setq LaTeX-math-abbrev-prefix "@")

;; Preview LaTeX
(setq preview-image-type "png")

;; --- Auto Complete -------------------------------------------------

(require 'company-auctex)
(company-auctex-init)

;; (require 'auto-complete-auctex)

;; ---

;; (require 'ac-math)
;; (add-to-list 'ac-modes 'LaTeX-mode)   ; make auto-complete aware of `latex-mode`
;; (defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
;;   (setq ac-sources
;;      (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
;;                ac-sources)))
;; (add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)

;; ;; ---

;; (ac-flyspell-workaround)

;; --- Commands -------------------------------------------------------

(require 'tex)
(TeX-global-PDF-mode t)

;; --- SyncTex ---

(defun un-urlify (fname-or-url)
  "Transform file:///absolute/path from Gnome into /absolute/path with very limited support for special characters"
  (if (string= (substring fname-or-url 0 8) "file:///")
      (url-unhex-string (substring fname-or-url 7))
    fname-or-url))

(defun urlify-escape-only (path)
  "Handle special characters for urlify"
  (replace-regexp-in-string " " "%20" path))

(defun urlify (absolute-path)
  "Transform /absolute/path to file:///absolute/path for Gnome with very limited support for special characters"
  (if (string= (substring absolute-path 0 1) "/")
      (concat "file://" (urlify-escape-only absolute-path))
    absolute-path))


(defun th-evince-sync (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: Could not open %s" fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))

(defvar *dbus-evince-signal* nil)

(defun enable-evince-sync ()
  (require 'dbus)
  (require 'cl)
  (when (and
         (eq window-system 'x)
         (fboundp 'dbus-register-signal))
    (unless *dbus-evince-signal*
      (setf *dbus-evince-signal*
            (dbus-register-signal
             :session nil "/org/gnome/evince/Window/0"
             "org.gnome.evince.Window" "SyncSource"
             'th-evince-sync)))))

(add-hook 'LaTeX-mode-hook 'enable-evince-sync)

;; universal time, need by evince
(defun utime ()
  (let ((high (nth 0 (current-time)))
        (low (nth 1 (current-time))))
    (+ (* high (lsh 1 16) ) low)))

;; Forward search.
;; Adapted from http://dud.inf.tu-dresden.de/~ben/evince_synctex.tar.gz
(defun auctex-evince-forward-sync (pdffile texfile line)
  (let ((dbus-name
         (dbus-call-method :session
                           "org.gnome.evince.Daemon"  ; service
                           "/org/gnome/evince/Daemon" ; path
                           "org.gnome.evince.Daemon"  ; interface
                           "FindDocument"
                           (urlify pdffile)
                           t     ; Open a new window if the file is not opened.
                           )))
    (dbus-call-method :session
                      dbus-name
                      "/org/gnome/evince/Window/0"
                      "org.gnome.evince.Window"
                      "SyncView"
                      (urlify-escape-only texfile)
                      (list :struct :int32 line :int32 1)
                      (utime))))

(defun auctex-evince-view ()
  (let ((pdf (file-truename (concat default-directory
                                    (TeX-master-file (TeX-output-extension)))))
        (tex (buffer-file-name))
        (line (line-number-at-pos)))
    (auctex-evince-forward-sync pdf tex line)))

;; New view entry: Evince via D-bus.
(setq TeX-view-program-list '())
(add-to-list 'TeX-view-program-list
             '("EvinceDbus" auctex-evince-view))

;; Prepend Evince via D-bus to program selection list
;; overriding other settings for PDF viewing.
(setq TeX-view-program-selection '())
(add-to-list 'TeX-view-program-selection
             '(output-pdf "EvinceDbus"))
