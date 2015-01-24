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
(add-to-list 'auto-mode-alist '("\\.slim\\'" . slim-mode))

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
;; (load "~/.elisp/nxhtml/autostart.el")
;; (setq mumamo-background-colors nil)

;; Workaround the annoying warnings:
;; Warning (mumamo-per-buffer-local-vars):
;; Already 'permanent-local t: buffer-file-name
;; (when (and (>= emacs-major-version 24)
;; 	   (>= emacs-minor-version 2))
;;   (eval-after-load "mumamo"
;;     '(setq mumamo-per-buffer-local-vars
;; 	   (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

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
;; --- Helm -----------------------------------------------------------
;; --------------------------------------------------------------------

(require 'helm)
(setq helm-command-prefix-key "C-c h")

(require 'helm-config)
(require 'helm-eshell)
(require 'helm-files)
(require 'helm-grep)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(setq
 helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
 helm-quick-update t ; do not display invisible candidates
 helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
 helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
 helm-candidate-number-limit 200
 helm-M-x-requires-pattern 0
 helm-ff-file-name-history-use-recentf t
 ido-use-virtual-buffers t
 helm-buffers-fuzzy-matching t
)

(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

(helm-mode 1)

;; --------------------------------------------------------------------
;; --- Blogging with jekyll -------------------------------------------
;; --------------------------------------------------------------------

(require 'hyde)
(setq hyde-home "~/projects/awesome_blog")

;; --------------------------------------------------------------------
;; --- FlySpell -------------------------------------------------------
;; --------------------------------------------------------------------

(defun flyspell-emacs-popup-textual (event poss word)
  "A textual flyspell popup menu."
  (require 'popup)
  (let* ((corrects (if flyspell-sort-corrections
		       (sort (car (cdr (cdr poss))) 'string<)
		     (car (cdr (cdr poss)))))
	 (cor-menu (if (consp corrects)
		       (mapcar (lambda (correct)
				 (list correct correct))
			       corrects)
		     '()))
	 (affix (car (cdr (cdr (cdr poss)))))
	 show-affix-info
	 (base-menu  (let ((save (if (and (consp affix) show-affix-info)
				     (list
				      (list (concat "Save affix: " (car affix))
					    'save)
				      '("Accept (session)" session)
				      '("Accept (buffer)" buffer))
				   '(("Save word" save)
				     ("Accept (session)" session)
				     ("Accept (buffer)" buffer)))))
		       (if (consp cor-menu)
			   (append cor-menu (cons "" save))
			 save)))
	 (menu (mapcar
		(lambda (arg) (if (consp arg) (car arg) arg))
		base-menu)))
    (cadr (assoc (popup-menu* menu :scroll-bar t) base-menu))))

(eval-after-load "flyspell"
  '(progn
     (fset 'flyspell-emacs-popup 'flyspell-emacs-popup-textual)))
