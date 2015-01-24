;; ====================================================================
;; === Emacs Config File ==============================================
;; ====================================================================
;; --- Filename:      .emacs
;; --- Description:   Init File for Emacs.
;; ---                Libarry paths, load other emacs-files
;; ---                

;; --------------------------------------------------------------------
;; --- Libraries and generic settings ---------------------------------
;; --------------------------------------------------------------------

;; Plugins
(add-to-list 'load-path "~/.elisp/")
(add-to-list 'load-path "~/.emacs.d/lisp")

(let ((default-directory "~/.emacs.d/elpa/")) 
  (normal-top-level-add-subdirs-to-load-path))

;; Server and Client
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x C-c") 'server-edit))))

;; (setq server-socket-dir (format "/home/fabian/tmp/.emacs_server"))

;; Backups
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
(setq delete-old-versions t)

;; Elpa
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/") 
                         ("sunrise-commander" . "http://joseito.republika.pl/sunrise-commander/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
                         ))
(package-initialize)

(require 'ujelly-theme)

;; --------------------------------------------------------------------
;; --- Editor Bevavior ------------------------------------------------
;; --------------------------------------------------------------------

;; encoding
(set-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq mm-coding-system-priorities '(mule-utf-8))
(setq gnus-default-charset (quote utf-8)
      gnus-default-posting-charset (quote utf-8))

(require 'mm-util)
 (defun mm-read-charset (prompt)
   "Return a charset."
   'utf-8)

(setq gnus-default-posting-charset (quote utf-8))
(setq gnus-article-decode-mime-words t)
(setq gnus-article-decode-charset 1)

;; fill-mode
(setq-default fill-column 75)
(setq fill-column 75)
(setq-default auto-fill-mode 1)
(setq auto-fill-mode 1)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'message-mode-hook 'turn-on-auto-fill)
(add-hook 'latex-mode-hook 'turn-on-auto-fill)

;; Indention
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq standard-indent 2)
(setq c-default-style "linux"
      c-basic-offset 2)
(defvaralias 'c-basic-offset 'tab-width)	
(defvaralias 'cperl-indent-level 'tab-width)

;; spell checking
(setq-default ispell-program-name "aspell")
(setq ispell-dictionary "de_DE")

;; scrolling
;; (setq scroll-margin 9999)
;; (setq scroll-preserve-screen-position nil)
;; (setq auto-window-vscroll nil)
;; (require 'smooth-scroll)
(require 'centered-cursor-mode)
(global-centered-cursor-mode t)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq redisplay-dont-pause t)

;; yank
(setq mouse-yank-at-point t)

;; parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Open files via ssh
(setq tramp-default-method "ssh")

;; Open compressed files
(auto-compression-mode 1)

;; Asking
(defalias 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)

;; --------------------------------------------------------------------
;; --- X11 Integration ------------------------------------------------
;; --------------------------------------------------------------------

(defun show-frame (&optional frame)
  (raise-frame)
  ; yes, you have to call this twice. Don’t ask me why…
  ; select-frame-set-input-focus calls x-focus-frame and does a bit of
  ; additional magic.
  (select-frame-set-input-focus (selected-frame))
  (select-frame-set-input-focus (selected-frame)))

(defun x-urgency-hint (frame arg &optional source)
  (let* ((wm-hints (append (x-window-property 
                            "WM_HINTS" frame "WM_HINTS" 
                            source nil t) nil))
         (flags (car wm-hints)))
    ; (message flags)
    (setcar wm-hints
            (if arg
                (logior flags #x00000100)
              (logand flags #x1ffffeff)))
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

(defun x-urgent (&optional arg)
  (interactive "P")
  (let (frame (car (car (cdr (current-frame-configuration)))))
  (x-urgency-hint frame (not arg))))

;; --------------------------------------------------------------------
;; --- Load other files -----------------------------------------------
;; --------------------------------------------------------------------

;; M-x customize changes to different file
(setq custom-file "~/.emacs.d/conf_custom.el")
(load custom-file 'noerror)

(load-file "~/.emacs.d/conf_apperiance.el")

(load-file "~/.emacs.d/conf_functions.el")
(load-file "~/.emacs.d/conf_hotkeys.el")
(load-file "~/.emacs.d/conf_stuff.el")
(load-file "~/.emacs.d/conf_orgmode.el")
(load-file "~/.emacs.d/conf_gnus.el")
(load-file "~/.emacs.d/conf_latex.el")
