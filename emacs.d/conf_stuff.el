;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      stuff.emacs
;; --- Author:        Fabian Grünig
;; ---                fabian@mathphys.fsk.uni-heidelebrg.de
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
;; --- IRC Chat -------------------------------------------------------
;; --------------------------------------------------------------------

;; (require 'jabber-autoloads)
;; (require 'tls)
;; (require 'erc)

;; (defun start-irc ()
;;    "Connect to IRC."
;;    (interactive)
;;    (erc-tls :server "irc.twice-irc.de" :port 6697
;;         :nick "fbi" :full-name "fabian")
;;    (erc :server "localhost" :port 6667
;;         :nick "fabian" :full-name "fabian")
;;    (setq erc-autojoin-channels-alist '(("localhost" "&bitlbee")
;;                                        ("twice-irc.de" "#chaos-hd"))))

;; (define-key erc-mode-map (kbd "C-c C-q")
;;   (lambda (nick)
;;     (interactive (list (completing-read "Nick: " channel-members)))
;;     (erc-cmd-QUERY nick)))

;; (setq erc-prompt (lambda ()
;;   (if (and (boundp 'erc-default-recipients) (erc-default-target))
;;       (erc-propertize (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t 'front-nonsticky t)
;;     (erc-propertize (concat "ERC>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))

;; (setq  erc-server-coding-system '(utf-8 . utf-8))

;; (add-hook 'erc-after-connect
;;           '(lambda (SERVER NICK)
;;              (cond
;;               ((string-match "localhost" SERVER)
;;                (erc-message "PRIVMSG" "#bitlbee identify 87bee")))))

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

;; (require 'yasnippet)
;; ;; (yas/global-mode 1)
;; ;; (yas/initialize)

;; ;; Jump to end of snippet definition
;; (define-key yas/keymap (kbd "<return>") 'yas/exit-all-snippets)

;; (setq yas/root-directory "~/.elisp/yas-snippets")
;; (yas/load-directory yas/root-directory)

;; (setq yas/prompt-functions '(yas/ido-prompt yas/completing-prompt))

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

;; mpd
;; (require 'libmpdee)
;; (require 'mingus)

;; expand region
;; (require 'expand-region)

;; line numbers
;; (global-linum-mode 1)
;; (setq linum-format "%5d")

;; blog
;; (require 'o-blog)

;; markdown 

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

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

(load-file "~/src/emacs-for-python/epy-init.el")
(setq py-load-pymacs-p nil)

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
