;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      apperiance.emacs
;; --- Description:   Init File for Emacs.
;; ---                Apperiance Settings, loaded by .emacs
;; ---                

;; --------------------------------------------------------------------
;; --- Colors, Menues, Bars, etc. -------------------------------------
;; --------------------------------------------------------------------

;; (require 'color-theme)
;; (setq color-theme-is-global t)
;; (color-theme-initialize)

;; Theme
(load-theme 'ujelly t)

;; Toolbars 'n stuff
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

;; ColorThemes
;; (load-file "~/.elisp/themes/color-theme-empty-void.el")
;; (color-theme-empty-void)

;; Numbers
(line-number-mode 1)
(column-number-mode 1)

;; Fill Column
;; (require 'fill-column-indicator)
;; (setq fci-rule-width 1)
;; (setq fci-rule-color "darkblue")
;; (setq fci-rule-use-dashes 1)

;; Time
(setq display-time-string-forms '("-- [ " 24-hours ":" minutes " ] "))
(display-time)                          ; Show the time in tbe minibuffer

;; Background

(set-background-color "black")
(set-mouse-color "orangered")

(add-hook 'after-make-frame-functions 'set-background-color "black")
(add-hook 'after-make-frame-functions 'set-mouse-color "orangered")
(add-hook 'after-make-frame-functions 'set-default-font "Inconsolata-10")
