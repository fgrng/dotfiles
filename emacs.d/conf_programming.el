;; ====================================================================
;; === Emacs Config Files =============================================
;; ====================================================================
;; --- Description:   Init File for Emacs.
;; ---                File for programming settings, loaded by .emacs
;; ---

;; --------------------------------------------------------------------
;; --- Python ---------------------------------------------------------
;; --------------------------------------------------------------------

(smart-tabs-advice python-indent-line-1 python-indent)
    (add-hook 'python-mode-hook
              (lambda ()
                (setq indent-tabs-mode t)
                (setq tab-width (default-value 'tab-width))))


;; --------------------------------------------------------------------
;; --- Javascript -----------------------------------------------------
;; --------------------------------------------------------------------

(smart-tabs-advice js2-indent-line js2-basic-offset)

;; --------------------------------------------------------------------
;; --- Ruby/Rails -----------------------------------------------------
;; --------------------------------------------------------------------

;; RVM support
(require 'rvm)
(rvm-use-default)
(rvm-autodetect-ruby)

;; Robe
(add-hook 'ruby-mode-hook 'robe-mode)
;; (add-hook 'robe-mode-hook 'ac-robe-setup)
(eval-after-load 'company
  '(push 'company-robe company-backends))
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-inf-ruby))
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

;; Syntax Checking
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Sane indentation
(setq ruby-deep-indent-paren nil)

;; Smart-Tabs-Mode
(smart-tabs-advice ruby-indent-line ruby-indent-level)
(setq ruby-indent-tabs-mode t)

;; Project Management
(projectile-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; RuboCop Style Guide
(add-hook 'ruby-mode-hook #'rubocop-mode)

;; --------------------------------------------------------------------
;; --- Golang ---------------------------------------------------------
;; --------------------------------------------------------------------

(setenv "GOPATH" "/home/fabian/repos/golang")
(setq exec-path (cons "/usr/local/go/bin" exec-path))
(add-hook 'before-save-hook 'gofmt-before-save)

;; --------------------------------------------------------------------
;; --- ESS (R) --------------------------------------------------------
;; --------------------------------------------------------------------

(setq ess-eval-visibly nil) ; ESS will not print the evaluated commands, also speeds up the evaluation 
(setq ess-ask-for-ess-directory t) ;if you don't want to be prompted each time you start an interactive R session

(set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
(set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
(set-face-attribute 'popup-tip-face    nil   :background "#003A4E" :foreground "light gray")

(setq comint-input-ring-size 1000)
(setq ess-indent-level 4)
(setq ess-arg-function-offset 4)
(setq ess-else-offset 4)
