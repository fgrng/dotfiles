;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      gnus.emacs
;; --- Author:        Fabian Grünig
;; ---                fabian@mathphys.fsk.uni-heidelebrg.de
;; --- Description:   Init File for Emacs.
;; ---                Gnus settings, loaded by .emacs
;; ---                

;; --------------------------------------------------------------------
;; --- General --------------------------------------------------------
;; --------------------------------------------------------------------

(setq user-full-name "Fabian Gruenig"
      user-mail-address "fabian@mathphys.fsk.uni-heidelberg.de"
      mail-user-agent 'gnus-user-agent)

(require 'gnus-alias)

(setq mm-coding-system-priorities
      '(mule-utf-8 iso-latin-1 iso-latin-9))

;; make gnus faster???
(setq gc-cons-threshold 3500000)
(setq gnus-use-correct-string-widths nil)

;; --------------------------------------------------------------------
;; --- Mail: Send (offline) -------------------------------------------
;; --------------------------------------------------------------------

(require 'smtpmail)
(require 'smtpmail-multi)

(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)

(setq message-send-mail-function 'smtpmail-multi-send-it)

;; --------------------------------------------------------------------
;; --- Mail: Fetch (offline) ------------------------------------------
;; --------------------------------------------------------------------

;; (require 'offlineimap)

(setq gnus-select-method
      '(nnimap "offline_dovecot"
	       (nnimap-address "localhost")
	       (nnimap-stream network)
               (nnimap-authinfo-file “~/.authinfo.gpg”)
               ))

;; --------------------------------------------------------------------
;; --- Mail: Folders and Archives -------------------------------------
;; --------------------------------------------------------------------

(setq gnus-directory "~/.news/")
(setq message-directory "~/.mail/")

(setq gnus-message-archive-method '(nnimap "offline_dovecot"))

(setq message-archive-group-mathphys
      (format-time-string "nnimap+offline_dovecot:MathPhys.Sent.%Y-%m"))

(setq message-archive-group-posteo
      (format-time-string "nnimap+offline_dovecot:Posteo.Sent.%Y-%m"))

;; --------------------------------------------------------------------
;; --- Group Summary Format -------------------------------------------
;; --------------------------------------------------------------------

(setq gnus-thread-sort-functions
           '(gnus-thread-sort-by-number
             gnus-thread-sort-by-subject
             gnus-thread-sort-by-date
             (not gnus-thread-sort-by-total-score)))

(setq gnus-summary-line-format "[%U%R] [%d] %I%(%[ %-23,23f %]%) %s\n")

(setq gnus-group-sort-function
      '(gnus-group-sort-by-real-name))

(setq gnus-group-line-format "%M [%4y] %P%G \n")

;; --------------------------------------------------------------------
;; --- Message Mode and Stuff -----------------------------------------
;; --------------------------------------------------------------------

;; Header Display
(setq message-hidden-headers '("^X-Face" "^X-Draft-From"))

;; add Cc and Bcc headers to the message buffer
(setq message-default-mail-headers "Cc: \nBcc: \n")

;; all mails should be always displayed in the mailbox
(setq gnus-permanently-visible-groups ".*MAIN")
(setq gnus-list-groups-with-ticked-articles t)

;; I hate smileys.
(setq gnus-treat-display-smileys nil)

;; 8bit-Codierung erzwingen
(add-to-list 'mm-body-charset-encoding-alist '(iso-8859-1 . 8bit))

(if (mm-coding-system-p 'iso-8859-15)
    (add-to-list 'mm-body-charset-encoding-alist '(iso-8859-15 . 8bit)))

;; QP-Codierung für UTF-8 erzwingen
(if (mm-coding-system-p 'utf-8)
    (add-to-list 'mm-body-charset-encoding-alist '(utf-8 . quoted-printable)))

;; Signatur nicht zitieren
(setq message-cite-function 'message-cite-original-without-signature)

(defun my-message-load-hook ()
  (gnus-alias-init))

;; Org&Co in messages
(add-hook 'message-mode-hook 'orgstruct++-mode 'append)
(add-hook 'message-mode-hook 'turn-on-auto-fill 'append)
(add-hook 'message-mode-hook 'orgtbl-mode 'append)
(add-hook 'message-mode-hook 'my-message-load-hook 'append)
(add-hook 'message-mode-hook
          '(lambda () (setq fill-column 75))
          'append)

(add-hook 'message-send-hook 'gnus-alias-select-identity 'append)

;; --------------------------------------------------------------------
;; --- Encryption GnuPG -----------------------------------------------
;; --------------------------------------------------------------------

(require 'epa-file)
(epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(require 'epg-config)
 (setq mml2015-use 'epg

       mml2015-verbose t
       epg-user-id "3EEE8EF5"
       mml2015-encrypt-to-self t
       mml2015-always-trust nil
       mml2015-cache-passphrase t
       mml2015-passphrase-cache-expiry '36000
       mml2015-sign-with-sender t

       gnus-message-replyencrypt t
       gnus-message-replysign t
       gnus-message-replysignencrypted t
       gnus-treat-x-pgp-sig t
 
       mm-sign-option 'guided
       mm-encrypt-option 'guided
       mm-verify-option 'always
       mm-decrypt-option 'always

       gnus-buttonized-mime-types
       '("multipart/alternative"
         "multipart/encrypted"
         "multipart/signed")

       epg-debug t ;;  then read the *epg-debug*" buffer
)

;; auto-sign
;; (add-hook 'message-send-hook 'mml-secure-message-sign-smime)

;; --------------------------------------------------------------------
;; --- BigBrother -----------------------------------------------------
;; --------------------------------------------------------------------

(require 'bbdb)
(bbdb-initialize 'gnus 'message)

(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
;; (bbdb-insinuate-message)

