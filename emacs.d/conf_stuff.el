;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      stuff.emacs
;; --- Description:   Init File for Emacs.
;; ---                File for small settings, loaded by .emacs
;; ---

;; Epa Bug fix
;; https://bbs.archlinux.org/viewtopic.php?id=190497

(defun epg--list-keys-1 (context name mode)
  (let ((args (append (if (epg-context-home-directory context)
			  (list "--homedir"
				(epg-context-home-directory context)))
		      '("--with-colons" "--no-greeting" "--batch"
			"--with-fingerprint" "--with-fingerprint")
		      (unless (eq (epg-context-protocol context) 'CMS)
			'("--fixed-list-mode"))))
	(list-keys-option (if (memq mode '(t secret))
			      "--list-secret-keys"
			    (if (memq mode '(nil public))
				"--list-keys"
			      "--list-sigs")))
	(coding-system-for-read 'binary)
	keys string field index)
    (if name
	(progn
	  (unless (listp name)
	    (setq name (list name)))
	  (while name
	    (setq args (append args (list list-keys-option (car name)))
		  name (cdr name))))
      (setq args (append args (list list-keys-option))))
    (with-temp-buffer
      (apply #'call-process
	     (epg-context-program context)
	     nil (list t nil) nil args)
      (goto-char (point-min))
      (while (re-search-forward "^[a-z][a-z][a-z]:.*" nil t)
	(setq keys (cons (make-vector 15 nil) keys)
	      string (match-string 0)
	      index 0
	      field 0)
	(while (and (< field (length (car keys)))
		    (eq index
			(string-match "\\([^:]+\\)?:" string index)))
	  (setq index (match-end 0))
	  (aset (car keys) field (match-string 1 string))
	  (setq field (1+ field))))
      (nreverse keys))))

;; --------------------------------------------------------------------
;; --- Sunrise Commander ----------------------------------------------
;; --------------------------------------------------------------------

(setq find-directory-functions (cons 'sr-dired find-directory-functions))

(add-to-list  'mm-inhibit-file-name-handlers 'openwith-file-handler)
(when (require 'openwith nil 'noerror)
	(setq openwith-associations
				(list
				 (list (openwith-make-extension-regexp
								'("mpg" "mpeg" "mp3" "mp4"
									"avi" "wmv" "wav" "mov" "flv"
									"ogm" "ogg" "mkv"))
							 "mpv"
							 '(file))
				 (list (openwith-make-extension-regexp
								'("xbm" "pbm" "pgm" "ppm" "pnm"
									"png" "gif" "bmp" "tif" "jpeg" "jpg"))
							 "feh"
							 '(file))
				 (list (openwith-make-extension-regexp
								'("doc" "docx" "xls" "ppt" "odt" "ods" "odg" "odp"))
							 "libreoffice"
							 '(file))
				 (list (openwith-make-extension-regexp
								'("pdf" "ps" "ps.gz" "dvi"))
							 "evince"
							 '(file))
				 ))
	(openwith-mode 1))

;; --------------------------------------------------------------------
;; --- Terminal -------------------------------------------------------
;; --------------------------------------------------------------------

(require 'multi-term)
(setq multi-term-dedicated-select-after-open-p t)

;; --------------------------------------------------------------------
;; --- Buffers --------------------------------------------------------
;; --------------------------------------------------------------------

;; Switch Buffer with iSwitchBuffer
;; (iswitchb-mode 1)
;; (setq iswitchb-buffer-ignore '("^ "
;;                                "*imap log*" 
;;                                "*gnus trace*" 
;;                                "*Calendar*" 
;;                                "*Completions*"
;;                                "*Messages*"
;;                                "*Buffer List*"
;;                                "*Mingus*"
;;                                "*Mingus Help*"
;;                                "*Mingus Browser*"))

;; (add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)

;; --------------------------------------------------------------------
;; --- Template Snippets ----------------------------------------------
;; --------------------------------------------------------------------

;; (setq default-abbrev-mode t)
;; (quietly-read-abbrev-file)
;; (setq save-abbrevs t)

;; (require 'yasnippet)

;; (setq yas-snippet-dirs
;;       '("~/.emacs.d/snippets"
;;         "~/src/yasnippet-snippets"
;; 				))

;; (yas-global-mode nil)

;; --------------------------------------------------------------------
;; --- Stuff ----------------------------------------------------------
;; --------------------------------------------------------------------

(put 'narrow-to-region 'disabled nil)

;; cycle through completion
;; (require 'icicles)
;; (icy-mode 1) 

;; expand region
(require 'expand-region)

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

;; Auto Completion
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "/home/fabian/.elisp/ac-dict")
;; (ac-config-default)
(add-hook 'after-init-hook 'global-company-mode)

;; Smart Tabs
;; (smart-tabs-insinuate 'javascript 'python 'ruby)

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


;; --------------------------------------------------------------------
;; --- Hydra ----------------------------------------------------------
;; --------------------------------------------------------------------

(defhydra hydra-zoom (:color teal)
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))

;; --------------------------------------------------------------------

(defhydra hydra-projectile-other-window (:color teal)
  "projectile-other-window"
  ("f"  projectile-find-file-other-window        "file")
  ("g"  projectile-find-file-dwim-other-window   "file dwim")
  ("d"  projectile-find-dir-other-window         "dir")
  ("b"  projectile-switch-to-buffer-other-window "buffer")
  ("q"  nil                                      "cancel" :color blue))

(defhydra hydra-projectile (:color teal :hint nil)
  "
     PROJECTILE: %(projectile-project-root)

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
_s-f_: file            _a_: ag                _i_: Ibuffer           _c_: cache clear
 _ff_: file dwim       _g_: update gtags      _b_: switch to buffer  _x_: remove known project
 _fd_: file curr dir   _o_: multi-occur     _s-k_: Kill all buffers  _X_: cleanup non-existing
  _r_: recent file                                               ^^^^_z_: cache current
  _d_: dir

"
  ("a"   projectile-ag)
  ("b"   projectile-switch-to-buffer)
  ("c"   projectile-invalidate-cache)
  ("d"   projectile-find-dir)
  ("s-f" projectile-find-file)
  ("ff"  projectile-find-file-dwim)
  ("fd"  projectile-find-file-in-directory)
  ("g"   ggtags-update-tags)
  ("s-g" ggtags-update-tags)
  ("i"   projectile-ibuffer)
  ("K"   projectile-kill-buffers)
  ("s-k" projectile-kill-buffers)
  ("m"   projectile-multi-occur)
  ("o"   projectile-multi-occur)
  ("s-p" projectile-switch-project "switch project")
  ("p"   projectile-switch-project)
  ("s"   projectile-switch-project)
  ("r"   projectile-recentf)
  ("x"   projectile-remove-known-project)
  ("X"   projectile-cleanup-known-projects)
  ("z"   projectile-cache-current-file)
  ("`"   hydra-projectile-other-window/body "other window")
  ("q"   nil "cancel" :color blue))

;; --------------------------------------------------------------------

(defhydra hydra-yank-pop ()
  "yank"
  ("C-y" yank nil)
  ("M-y" yank-pop nil)
  ("y" (yank-pop 1) "next")
  ("Y" (yank-pop -1) "prev")
  ("l" helm-show-kill-ring "list" :color blue))   ; or browse-kill-ring

;; --------------------------------------------------------------------

(defhydra hydra-eval (:color blue :columns 8)
  "Eval"
  ("e" eval-expression "expression")
  ("d" eval-defun "defun")
  ("r" eval-region "region")
  ("b" eval-buffer "buffer")
  ("l" eval-last-sexp "last sexp")
  ("s" async-shell-command "shell-command"))

;; --------------------------------------------------------------------

(defhydra hydra-magit (:color blue :columns 8)
  "Magit"
  ("s" magit-status "status")
  ("l" magit-log "log")
  ("d" magit-diff "diff")
  ("c" magit-commit "commit")
  ("C" magit-checkout "checkout")
  ("v" magit-branch-manager "branch manager")
  ("m" magit-merge "merge")
  ("!" magit-git-command "command")
  ("$" magit-process "process"))

;; --------------------------------------------------------------------

(defhydra hydra-gnus-reply (:color blue)
  "reply"
  ("o" gnus-summary-reply-with-original "one")
  ("O" gnus-summary-reply)
  ("a" gnus-summary-wide-reply-with-original "all")
  ("A" gnus-summary-wide-reply)
  ("u" gnus-summary-very-wide-reply-with-original "universe")
  ("U" gnus-summary-very-wide-reply)
  ("q" nil "quit"))

(define-key gnus-summary-mode-map "r" 'hydra-gnus-reply/body)
