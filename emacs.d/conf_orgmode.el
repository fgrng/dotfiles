;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Filename:      orgmode.emacs
;; --- Description:   Init File for Emacs.
;; ---                Org-Mode Settings, loaded by .emacs
;; ---                

(require 'org-protocol)

;; Open with ...
(setq org-file-apps (quote ((auto-mode . emacs)
                            ("\\.x?html?\\'" . system)
                            ("\\.pdf\\'" . system))))

;; (setq org-modules '(org-bbdb 
;;                     org-contacts
;;                     org-gnus
;;                     org-info
;;                     org-jsinfo
;;                     org-habit
;;                     org-irc
;;                     org-mouse
;;                     org-annotate-file
;;                     org-eval
;;                     org-expiry
;;                     org-interactive-query
;;                     org-man
;;                     org-panel
;;                     org-screen
;;                     org-toc))

;; --------------------------------------------------------------------
;; --- Files ----------------------------------------------------------
;; --------------------------------------------------------------------

;; Load org on files:
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;; FILES
;; (setq org-agenda-include-diary nil)
;; (setq org-agenda-diary-file "~/org/diary.org")
(setq org-default-notes-file "~/org/refile.org")

(setq org-agenda-files (list "~/org/todos.org"
                             "~/org/tasks.org"
                             "~/org/dates.org"
                             "~/org/google.org"
                             "~/org/refile.org"
                             ))

(setq org-directory "~/org")

;; --------------------------------------------------------------------
;; --- Capturing ------------------------------------------------------
;; --------------------------------------------------------------------

;; Templates
(setq org-capture-templates
      (quote ((
               "t" "TODO" entry 
               (file "~/org/refile.org")
               "* TODO %? \n- Added: %U\n- Info: " 
               )
              (
               "f" "TASK" entry 
               (file "~/org/refile.org")
               "* TODO %? \n- Added: %U\n- Who: \n- Info: " 
               )
              (
               "l" "TODO+LINK" entry
               (file "~/org/refile.org")
               "* TODO %? \n- Added: %U\n- Link: %a\n- Info: %i"
               )
              (
               "m" "TODO+MAIL" entry
               (file "~/org/refile.org")
               "* TODO %? \n- Added: %U\n- Mail\n  + From: %:from\n  - Thema: %:subject\n  - Link %a\n- Info: %i"
               )
              (
               "r" "READING+LINK" entry 
               (file "~/org/refile.org")
               "* SOMEDAY %? \n- Added: %U\n- Link: %a"
               )
              (
               "S" "SHOPPING" checkitem
               (file+headline "~/org/location.org" "SHOPPING")
               "[ ] %?"
               )
              (
               "s" "SOMEDAY" entry 
               (file+headline "~/org/refile.org" "TASKS")
               "* SOMEDAY %? \n- Added: %U\n- Link: %a\n- Info: " 
               )
              ("w" "ORG-PROT link" entry 
               (file "~/org/refile.org" )
               "* SOMEDAY Stored link: %c\n- %i"
               :immediate-finish t :kill-client t))))
 
; Capture with firefox
(add-to-list 'org-protocol-protocol-alist
             '("Handle for captures through firefox"
               :protocol "fire-capture"
               :function org-protocol-capture
               :kill-client t))

; Refile Targets
(setq my/org-refile-files (list "~/org/todos.org"
                             "~/org/tasks.org"
                             "~/org/dates.org"
                             ))

(setq org-refile-targets (quote ((my/org-refile-files :maxlevel . 1))))



;; --------------------------------------------------------------------
;; --- Stuff ----------------------------------------------------------
;; --------------------------------------------------------------------

;; no sub or sup scripts
(setq org-use-sub-superscripts nil)

;; SAVE org-files
;; (run-at-time "00:58" 3600 'org-save-all-org-buffers)
;; (run-at-time "00:59" 3600 'org-mobile-push)

(setq org-startup-indented t)

;; ARCHIVE org-files
(setq org-archive-mark-done nil)
(setq org-archive-location ".archive/%s_archive::* Archived Tasks")

;; --------------------------------------------------------------------
;; --- Agenda ---------------------------------------------------------
;; --------------------------------------------------------------------

; Overwrite the current window with the agenda
(setq org-agenda-window-setup 'current-window)

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Notes and Tasks to Refile")
                       (org-agenda-overriding-header "Tasks to Refile")))
                (tags-todo "-WAITING-CANCELLED/!NEXT|STARTED"
                           ((org-agenda-overriding-header "Next TODOs")
                            (org-agenda-skip-function 'my/skip-projects-and-habits)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED/!-NEXT-TASK-SOMEDAY-STARTED-WAITING"
                           ((org-agenda-overriding-header "TODOs")
                            (org-agenda-skip-function 'my/skip-projects-and-habits)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-WAITING-CANCELLED/!TASK"
                           ((org-agenda-overriding-header "TASKs")
                            (org-agenda-skip-function 'my/skip-projects-and-habits)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'my/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-REFILE-CANCELLED/!SOMEDAY"
                           ((org-agenda-overriding-header "Procrastinating")
                            (org-agenda-skip-function 'my/skip-projects-and-habits)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-skip-function 'my/skip-non-stuck-projects)))
                (todo "WAITING|HOLD"
                      ((org-agenda-overriding-header "Waiting and Postponed tasks")
                       (org-agenda-skip-function 'my/skip-projects-and-habits)))
                (tags "-REFILE/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'my/skip-non-archivable-tasks))))
               nil
               )
              ;; (
              ;;  "h" "Work todos"
              ;;  tags-todo "-dowith={.+}/!-TASK"
              ;;  ((org-agenda-todo-ignore-scheduled t))
              ;;  )
              ;; ("H" "All work todos"
              ;;  tags-todo "-personal/!-TASK-MAYBE"
              ;;  ((org-agenda-todo-ignore-scheduled nil))
              ;;  )
              ;; ("A" "Work todos with dowith"
              ;;  tags-todo "dowith={.+}/!-TASK"
              ;;  ((org-agenda-todo-ignore-scheduled nil))
              ;;  )
              ;; ("j" "TODO dowith and TASK with"
              ;;  ((org-sec-with-view "TODO dowith")
              ;;   (org-sec-assigned-with-view "TASK with")
              ;;   (org-sec-stuck-with-view "STUCK with"))
              ;;  )
              ;; ("J" "Interactive TODO dowith and TASK with"
              ;;  ((org-sec-who-view "TODO dowith"))
              ;; )
              )))

;; --------------------------------------------------------------------
;; --- Tags/Todos -----------------------------------------------------
;; --------------------------------------------------------------------

; Todo-cycles
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")
        (sequence "TASK(f)" "|" "REPORT(r)" "DONE(d)")
        (sequence "SOMEDAY(m)" "|" "CANCELLED(c)")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "DarkOrange1" :weight bold))
        ("NEXT" . (:foreground "red" :weight bold))
        ("SOMEDAY" . (:foreground "sea green"))
        ("DONE" . (:foreground "light sea green"))
        ("CANCELLED" . (:foreground "forest green"))
        ("TASK" . (:foreground "light blue"))))

; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@UNI" . ?u)
                            ("@HOME" . ?h)
                            ("@LOCATION" . ?l)
                            (:endgroup)
                            ("PHONE" . ?p)
                            ("WICHTIG" . ?w)
                            ("MAIL" . ?m)
                            ("PROJECT" . ?p)
                            ("READING" . ?r)
                            ("EDV" . ?e)
                            )))

;; --------------------------------------------------------------------
;; --- Do with/where --------------------------------------------------
;; --------------------------------------------------------------------

;; --- Hotkeys:
;; With-Variable setzen: C-c + q
;; Dowith-Property setzen: C-c + d
;; Eintrag With-Variable taggen: C-c + j

(defvar org-sec-with "nobody"
  "Value of the :with: property when doing an 
   org-sec-tag-entry. Change it with org-sec-set-with,  
   set to C-c w")

(defvar org-sec-with-history '()
  "History list of :with: properties")

(defun org-sec-set-with ()
  "Changes the value of the org-sec-with variable for use
   in the next call of org-sec-tag-entry."
  (interactive)
  (setq org-sec-with (read-string "With: " nil
                                  'org-sec-with-history "")))

(global-set-key "\C-cq" 'org-sec-set-with)

;; ---

(defun org-sec-set-dowith ()
  "Sets the value of the dowith property."
  (interactive)
  (let ((do-with
         (read-string "Do with: "
                      nil 'org-sec-dowith-history "")))
    (unless (string= do-with "")
      (org-entry-put nil "dowith" do-with))))

(global-set-key "\C-cd" 'org-sec-set-dowith)

;; ---

(defun org-sec-tag-entry ()
  "Adds a :with: property with the value of org-sec-with if
   defined."
  (interactive)
  (save-excursion
    (unless (string= org-sec-with "nobody")
      (org-entry-put nil "with" org-sec-with))))

(global-set-key "\C-cj" 'org-sec-tag-entry)

;; ---

(defun join (lst sep &optional pre post)
  (mapconcat (function (lambda (x)
                         (concat pre x post)))
             lst sep))

;; ---

(defun org-sec-with-view (par &optional who)
  "Select tasks marked as dowith=who, where who 
   defaults to the value of org-sec-with."
  (org-tags-view '(4) (join (split-string (if who
                                              who
                                            org-sec-with))
                            "|" "dowith=\"" "\"")))

(defun org-sec-assigned-with-view (par &optional who)
  "Select tasks assigned to who, by default org-sec-with."
  (org-tags-view '(4)
                 (concat (join (split-string (if who
                                                 who
                                               org-sec-with))
                               "|")
                         "/TASK")))

(defun org-sec-stuck-with-view (par &optional who)
  "Select stuck projects assigned to who, by default 
   org-sec-with."
  (let ((org-stuck-projects
         `(,(concat "+prj+"
                    (join (split-string (if who
                                            who
                                          org-sec-with)) "|")
                    "/-MAYBE-DONE")
           ("TODO" "TASK") ())))
    (org-agenda-list-stuck-projects)))

;; ---

(defun org-sec-who-view (par)
  "Builds agenda for a given user.  Queried. "
  (let ((who (read-string "Build todo for user/tag: "
                          "" "" "")))
    (org-sec-with-view "TODO dowith" who)
    (org-sec-assigned-with-view "TASK with" who)
    (org-sec-stuck-with-view "STUCK with" who)))

;; --------------------------------------------------------------------
;; --- Clocking -------------------------------------------------------
;; --------------------------------------------------------------------

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
;; Show lot sof clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 36)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change task to STARTED when clocking in
(setq org-clock-in-switch-to-state 'my/clock-in-to-started)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq my/keep-clock-running nil)

;; --------------------------------------------------------------------
;; --- Stuff ----------------------------------------------------------
;; --------------------------------------------------------------------

;; Bold, Italique, etc.
(setq org-emphasis-alist (quote (("*" bold "<b>" "</b>")
                                 ("/" italic "<i>" "</i>")
                                 ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
                                 ("=" org-code "<code>" "</code>" verbatim)
                                 ("~" org-verbatim "<code>" "</code>" verbatim))))

;; Cycle Plaintext
(setq org-cycle-include-plain-lists nil)

;; Source Code Highlighting
(setq org-src-fontify-natively t)

;; Use ido
(setq org-completion-use-ido t)

;; --------------------------------------------------------------------
;; --- Publish / Export / Sync  ---------------------------------------
;; --------------------------------------------------------------------

;;(require 'org-contacts)

(require 'org-publish)
;; (require 'org-reprise)

;; (setq org-export-latex-listings t)
;; (setq org-export-htmlize-output-type 'css)
;; (setq org-export-babel-evaluate nil)

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((python . t)
;;    (emacs-lisp . t)
;;    ))

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/mobile/flagged.org")
(setq org-mobile-directory "~/org/mobile/")

(setq org-publish-project-alist
      '(

        ("org-notes"
         :base-extension "org"
         :base-directory "~/org/projects/blog/"
         :publishing-directory "~/org/published/blog/assets/"
         :blog-publishing-directory "~/org/published/blog/"
         :site-root "http://mathphys.fsk.uni-heidelberg.de/~fabian/blog"
         :hyde-sanitize-permalinks t
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-postamble nil
         :auto-preamble t
         :exclude-tags ("ol" "noexport")
         )

        ("org-static"
         :base-directory "~/org/projects/blog/"
         :publishing-directory "~/blog-files/assets/media/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org-weblog"
         ;; Path to your org files.
         :base-directory "~/media/blog/org/"
         :base-extension "org"

         ;; Path to your Jekyll project.
         :publishing-directory "~/media/blog/jekyll/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4
         :html-extension "html"
         :body-only t
         )

        ("org-static-weblog"
          :base-directory "~/media/blog/org/"
          :base-extension "png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
          :publishing-directory "~/media/blog/jekyll/attachments"
          :recursive t
          :publishing-function org-publish-attachment
          )

        ("weblog" :components ("org-weblog"
                               "org-static-weblog")
         )

      ))

(defun publish-blog ()
  (interactive)
  (org-reprise-export-blog "~/org/projects/blog/notes.org"))
