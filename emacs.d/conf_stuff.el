;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      stuff.emacs
;; --- Description:   Init File for Emacs.
;; ---                File for small settings, loaded by .emacs
;; ---

;; --------------------------------------------------------------------
;; --- Sunrise Commander ----------------------------------------------
;; --------------------------------------------------------------------

(setq find-directory-functions (cons 'sr-dired find-directory-functions))

;; --------------------------------------------------------------------
;; --- Terminal -------------------------------------------------------
;; --------------------------------------------------------------------

(require 'multi-term)
(setq multi-term-dedicated-select-after-open-p t)

;; --------------------------------------------------------------------
;; --- Buffers --------------------------------------------------------
;; --------------------------------------------------------------------

;; Switch Buffer with iSwitchBuffer
(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^ "
                               "*imap log*" 
                               "*gnus trace*" 
                               "*Calendar*" 
                               "*Completions*"
                               "*Messages*"
                               "*Buffer List*"
                               "*Mingus*"
                               "*Mingus Help*"
                               "*Mingus Browser*"))

(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)

;; --------------------------------------------------------------------
;; --- Template Snippets ----------------------------------------------
;; --------------------------------------------------------------------

(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "~/.emacs.d/abbrev_defs")    ;; definitions from...

(setq default-abbrev-mode t)
(quietly-read-abbrev-file)
(setq save-abbrevs t)

;; --------------------------------------------------------------------
;; --- Stuff ----------------------------------------------------------
;; --------------------------------------------------------------------

;; cycle through completion
;; (require 'icicles)
;; (icy-mode 1) 

;; expand region
;; (require 'expand-region)

;; line numbers
;; (global-linum-mode 1)
;; (setq linum-format "%5d")

;; markdown 
;; (autoload 'markdown-mode "markdown-mode"
;;    "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . hyde-markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . hyde-markdown-mode))

(global-hl-line-mode 1)
(set-face-background 'hl-line "#222")

;; Spell Checking
(setq flyspell-issue-message-flag nil)

(defun my/switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "de_DE") "english" "de_DE")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

;; Python
;; (load-file "~/src/emacs-for-python/epy-init.el")
;; (setq py-load-pymacs-p nil)

;; Auto Completion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/fabian/.elisp//ac-dict")
(ac-config-default)

;; --------------------------------------------------------------------
;; --- Ruby/Rails -----------------------------------------------------
;; --------------------------------------------------------------------

;; Robe
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)

;; Web Devel
(load "~/.elisp/nxhtml/autostart.el")
(setq mumamo-background-colors nil)

;; Workaround the annoying warnings:
;; Warning (mumamo-per-buffer-local-vars):
;; Already 'permanent-local t: buffer-file-name
(when (and (>= emacs-major-version 24)
	   (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
	   (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; Syntax Checking
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Sane indentation
(setq ruby-deep-indent-paren nil)

;; Project Management
(projectile-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; --------------------------------------------------------------------
;; --- IDO ------------------------------------------------------------
;; --------------------------------------------------------------------

(require 'ido)
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-case-fold nil
      ido-auto-merge-work-directories-length -1
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10)

;; --------------------------------------------------------------------
;; --- Blogging with jekyll -------------------------------------------
;; --------------------------------------------------------------------

(require 'hyde)
(setq hyde-home "~/projects/awesome_blog")
