(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 (quote
		("91b1b8ec7d5ff7c11b5dce20423e646f2322dbff8decb3f13dc5c19784317a58" default)))
 '(gnus-alias-add-identity-menu t)
 '(gnus-alias-default-identity "posteo")
 '(gnus-alias-identity-alist
	 (quote
		(("mathphys" "" "Fabian Grünig <fabian@mathphys.fsk.uni-heidelberg.de>" ""
			(("Gcc" . message-archive-group-mathphys))
			"" "")
		 ("privat" "" "Fabian Grünig <fabi-g@posteo.de>" ""
			(("Gcc" . message-archive-group-posteo))
			"" "")
		 ("anonym" "" "Bibi <bibi@posteo.de>" ""
			(("Gcc" . message-archive-group-posteo))
			"" "")
		 ("stud" "" "Fabian Grünig <gruenig@stud.uni-heidelberg.de>" ""
			(("Gcc" . message-archive-group-mathphys))
			"" "")
		 ("posteo" "" "Fabian Grünig <gruenig@posteo.de>" ""
			(("Gcc" . message-archive-group-posteo))
			"" ""))))
 '(gnutls-min-prime-bits 1024)
 '(send-mail-function (quote smtpmail-multi-send-it))
 '(smtpmail-default-smtp-server "extmail.urz.uni-heidelberg.de")
 '(smtpmail-multi-accounts
	 (quote
		((Posteo "gruenig@posteo.de" "posteo.de" 587 nil starttls nil nil nil)
		 (URZextmail "cx025" "extmail.urz.uni-heidelberg.de" 25 nil nil nil nil nil))))
 '(smtpmail-multi-associations
	 (quote
		(("^.*uni-heidelberg\\.de.*" URZextmail)
		 ("^.*posteo\\.de.*" Posteo))))
 '(smtpmail-multi-default-account (quote Posteo))
 '(smtpmail-queue-dir "~/.ail/queued-mail/")
 '(smtpmail-smtp-server "posteo.de")
 '(smtpmail-smtp-service 587)
 '(smtpmail-smtp-user "gruenig@posteo.de"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face))))
 '(font-latex-sectioning-5-face ((t (:inherit variable-pitch :foreground "yellow")))))
