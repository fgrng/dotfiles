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
    (("mathphys" nil "Fabian Grünig <fabian@mathphys.fsk.uni-heidelberg.de>" nil
      (("Gcc" . message-archive-group-mathphys))
      nil nil)
     ("privat" nil "Fabian Grünig <fabi-g@posteo.de>" nil
      (("Gcc" . message-archive-group-posteo))
      nil nil)
     ("anonym" nil "Bibi <bibi@posteo.de>" nil
      (("Gcc" . message-archive-group-posteo))
      nil nil)
     ("stud" nil "Fabian Grünig <gruenig@stud.uni-heidelberg.de>" nil
      (("Gcc" . message-archive-group-mathphys))
      nil nil)
     ("phhd" nil "Fabian Grünig <gruenig@ph-heidelberg.de>" nil
      (("Gcc" . message-archive-group-phHD))
      nil "~/.signature-phhd")
     ("posteo" nil "Fabian Grünig <gruenig@posteo.de>" nil
      (("Gcc" . message-archive-group-posteo))
      nil nil))))
 '(gnutls-min-prime-bits 1024)
 '(org-agenda-files
   (quote
    ("~/doc/org/todos.org" "~/doc/org/tasks.org" "~/doc/org/dates.org" "~/doc/org/refile.org")))
 '(package-selected-packages
   (quote
    (company-php php-mode auctex-latexmk auctex company-jedi zotelo yard-mode yaml-mode xterm-title xterm-color windresize w3m ujelly-theme sunrise-x-tree sunrise-x-mirror ssh-config-mode smtpmail-multi smooth-scrolling smooth-scroll smart-tabs-mode slim-mode simple-mpc scss-mode sass-mode rvm ruby-tools ruby-block rubocop robe projectile-rails powerline org-ref org-caldav openwith nodejs-repl multi-term minimap mingus markdown-toc markdown-mode+ magit iedit hyde highlight-indentation helm-spotify helm-robe helm-rails helm-projectile helm-package helm-go-package helm-git-grep helm-git-files helm-flycheck helm-company helm-bibtexkey go-projectile go-complete gnus-alias git-rebase-mode git-commit-mode fuzzy flymake-shell flymake-sass flymake-ruby flymake-python-pyflakes flymake-less flymake-go flymake-cursor flymake-css flymake-coffee flymake expand-region ess-view ess-smart-underscore ess-smart-equals ess-R-object-popup ess-R-data-view ebib company-web company-shell company-quickhelp company-math company-inf-ruby company-go company-cmake company-c-headers company-auctex coffee-mode centered-cursor-mode ampc)))
 '(send-mail-function (quote mailclient-send-it)))

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
