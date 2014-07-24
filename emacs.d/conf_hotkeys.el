;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      hotkeys.emacs
;; --- Author:        Fabian Grünig
;; ---                fabian@mathphys.fsk.uni-heidelebrg.de
;; --- Description:   Init File for Emacs.
;; ---                Key Settings, loaded by .emacs
;; ---                

;; --------------------------------------------------------------------
;; --- Key Defs -------------------------------------------------------
;; --------------------------------------------------------------------

;; F-Keys
(global-set-key [f1] 'help)
(global-set-key [f2] 'tmms-menubar)
(global-set-key [f3] 'sunrise)
(global-set-key [f4] 'mingus)

(global-set-key [f5] 'copy-region-as-kill) ; Copy 
(global-set-key [f6] 'kill-region)         ; Cut 
(global-set-key [f7] 'yank)                ; Paste 
(global-set-key [f8] 'my/switch-dictionary)

(global-set-key [f9]  'gnus)
(global-set-key [f10] 'org-agenda)
(global-unset-key [f11])
(global-set-key (kbd "<f11> i") 'my/punch-in)
(global-set-key (kbd "<f11> o") 'my/punch-out)
(global-set-key (kbd "<f11> <f11>") 'org-clock-in)
(global-set-key (kbd "<f11> r") 'my/visit-org-refile)
(global-set-key (kbd "<f11> n") 'my/visit-org-notes)
(global-set-key (kbd "<f11> d") 'my/visit-org-dates)
(global-set-key [f12] 'my/visit-org-refile)

;; Meta (i3-like?)
(global-unset-key (kbd "M-<return>"))
(global-set-key (kbd "M-<return>") 'split-window-horizontally)
(global-unset-key "\M-X")
(global-set-key "\M-X" 'delete-window)

(global-unset-key "\M-n")
(global-set-key "\M-n" 'other-window)
(global-unset-key "\M-N")
(global-set-key "\M-N" 'previous-buffer)
(global-unset-key "\M-d")
(global-set-key "\M-d" 'other-window)
(global-unset-key "\M-D")
(global-set-key "\M-D" 'next-buffer)

(global-unset-key "\M-m")
(global-set-key "\M-m" 'buffer-menu)

;; C
(global-unset-key (kbd "C-<tab>"))
(global-set-key (kbd "C-<tab>") 'yas/expand)
(global-unset-key (kbd "C-x b"))
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

;; C-M
(global-set-key (kbd "C-M-r") 'org-capture)
(global-set-key (kbd "C-M-<return>") 'multi-term-dedicated-toggle)
(global-set-key (kbd "C-M-n") 'message-mail-other-window)

