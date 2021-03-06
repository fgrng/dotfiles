;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      hotkeys.emacs
;; --- Description:   Init File for Emacs.
;; ---                Key Settings, loaded by .emacs
;; ---

;; --------------------------------------------------------------------
;; --- Key Defs -------------------------------------------------------
;; --------------------------------------------------------------------

;; --- F-Keys
(global-set-key [f1] 'help)
(global-set-key [f2] 'hydra-projectile/body)
(global-set-key [f3] 'help)
(global-set-key [f4] 'help)

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
(global-set-key (kbd "<f11> t") 'my/visit-org-todos)
(global-set-key (kbd "<f11> T") 'my/visit-org-tasks)
(global-set-key [f12] 'my/visit-org-refile)

;; --- hydra
(global-set-key (kbd "C-c C-f") 'hydra-projectile/body)
(global-set-key (kbd "C-c C-g") 'hydra-magit/body)
(global-unset-key (kbd "C-x C-x"))
(global-set-key (kbd "C-x C-x") 'hydra-eval/body)

(global-set-key (kbd "M-y") 'hydra-yank-pop/yank-pop)
(global-set-key (kbd "C-y") 'hydra-yank-pop/yank)

;; --- latex / auctex
;; (define-key LaTeX-mode-map (kbd "C-c )") 'reftex-hyperref-autoref)
;; (define-key reftex-mode-map (kbd "C-c )") 'reftex-hyperref-autoref)

;; --- Meta (i3-like?)
(global-unset-key (kbd "M-<return>"))
(global-set-key (kbd "M-<return>") 'multi-term-dedicated-toggle)
(global-unset-key "\M-X")
(global-set-key "\M-X" 'delete-window)

(global-unset-key "\M-n")
(global-set-key "\M-n" 'other-window)
(global-unset-key "\M-d")
(global-set-key "\M-d" 'other-window)

(global-unset-key "\M-N")
(global-set-key "\M-N" 'previous-buffer)
(global-unset-key "\M-D")
(global-set-key "\M-D" 'next-buffer)

(global-unset-key "\M-G")
(global-set-key "\M-G" 'my/ido-goto-symbol)
(global-unset-key "\M-F")
(global-set-key "\M-F" 'iedit-mode)

(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-unset-key "\M-x")
(global-set-key (kbd "M-x") 'helm-M-x)

(global-unset-key "\M-y")
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-unset-key (kbd "M-m"))
(global-set-key (kbd "M-m") 'er/expand-region)


;; --- Control
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") 'repeat)

(global-unset-key (kbd "C-x b"))
(global-set-key (kbd "C-x b") 'helm-mini)

(global-unset-key (kbd "C-x C-f"))
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-unset-key (kbd "C-x C-k"))
(global-set-key (kbd "C-x C-k") 'my/kill-this-buffer)

(global-unset-key (kbd "C-q"))
(global-set-key (kbd "C-q") 'flyspell-correct-word-before-point)

(global-unset-key (kbd "C-Q"))
(global-set-key (kbd "C-Q") 'flymake-display-err-menu-for-current-line)

(global-set-key [C-next] 'text-scale-decrease)
(global-set-key [C-prior] 'text-scale-increase)

;; --- Control-Meta
(global-set-key (kbd "C-M-r") 'org-capture)
(global-set-key (kbd "C-M-n") 'message-mail-other-window)

;; --- Hotkey Hooks

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (define-key LaTeX-mode-map (kbd "C-c )") 'reftex-hyperref-autoref)
            (define-key reftex-mode-map (kbd "C-c )") 'reftex-hyperref-autoref)
            ))

(add-hook 'gnus-started-hook
          (lambda ()
            (define-key gnus-summary-mode-map "r" 'hydra-gnus-reply/body)
            ))

            
 
