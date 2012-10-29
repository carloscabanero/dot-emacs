;; General setup
(setq-default indent-tabs-mode nil)
(setq delete-key-deletes-forward t)
(setq mouse-yank-at-point t)
(line-number-mode t)
(column-number-mode t)
(tool-bar-mode -1)
(scroll-bar-mode nil)

(iswitchb-mode t)

(add-to-list 'load-path "~/.emacs.d")
(progn (cd "~/.emacs.d") (normal-top-level-add-subdirs-to-load-path))

;; Configure themes
(set-default-font "Monospace-10")
;; Set color scheme (set lconfig-dark-bg-scheme to t for reverse color scheme)
(set-foreground-color "#f8f8f2")
(set-background-color "#272822")
(defconst cursor-color "#f8f8f0")
(set-face-foreground 'font-lock-comment-face "#95917E")
(set-face-foreground 'font-lock-string-face "#e6db74")
(set-face-foreground 'font-lock-keyword-face "#F92672")
(set-face-foreground 'font-lock-function-name-face "#A6E22E")
(set-face-foreground 'font-lock-variable-name-face "#98fbff")
(set-face-foreground 'font-lock-type-face "#A6E22E")
(set-face-foreground 'region "#272822")
(set-face-background 'region "#66D9EF")
(set-face-foreground 'font-lock-constant-face "#66d9ef")
()

;;(require 'color-theme)
;;(color-theme-initialize)
;;(color-theme-twilight)

;; Setup save options (auto and backup) -- still buggy need new Replace func
(setq auto-save-timeout 2000)
(setq make-backup-files t)

;; Full screen toggle mode
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(define-key global-map "\C-cf" 'toggle-fullscreen)

;; Printing setup
(setq ps-n-up-printing 2)
(setq ps-print-header nil)


;; Global Key Bindings
(define-key global-map "\C-xw" 'what-line)
;; (define-key global-map "\C-z" 'undo)
(define-key global-map [delete] 'delete-char)
(define-key global-map [backspace] 'delete-backward-char)
(define-key global-map [f1] 'help-command)
(define-key global-map [f2] 'undo)
(define-key global-map [f3] 'isearch-forward)
(define-key global-map [f4] 'other-window)
(define-key global-map [f12] 'revert-buffer)
(define-key global-map [button4] 'previous-line)
(define-key global-map [button5] 'next-line)

;; Setup time mode
(autoload 'display-time "time" "Display Time" t)
(condition-case err
    (display-time)
  (error (message "Unable to load Time package.")))
(setq display-time-24hr-format nil)
(setq display-time-day-and-date t)

;; Setup text mode
(add-hook 'text-mode-hook '(lambda() (auto-fill-mode 1)))
(add-hook 'text-mode-hook '(lambda() (setq fill-column 78)))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)

;; (defun toolbox-python-mode-hook ()
;;   ;; Setup Pymacs
;;   (autoload 'pymacs-apply' "pymacs")
;;   (autoload 'pymacs-call' "pymacs")
;;   (autoload 'pymacs-eval' "pymacs" nil t)
;;   (autoload 'pymacs-exec "pymacs" nil t)
;;   (autoload 'pymacs-load "pymacs" nil t)
;;   ;;(eval-after-load "pymacs"
;;   ;;  '(add-to-list 'pymacs-load-path "YOUR-PYMACS-DIR"))

;;   ;; Setting up ropemacs
;;   (require 'pymacs)
;;   (pymacs-load "ropemacs" "rope-")
;;   (setq ropemacs-enable-autoimport 't)
;;   (setq ropemacs-autoimport-modules '("google.appengine"))

;;   ;;(flymake-mode 1)
;;   ;; Setting up flymake to use pyflakes
 
;;   (when (load "flymake" t) 
;;     (defun flymake-pyflakes-init () 
;;       (let* ((temp-file (flymake-init-create-temp-buffer-copy 
;;                          'flymake-create-temp-inplace)) 
;;              (local-file (file-relative-name 
;;                           temp-file 
;;                           (file-name-directory buffer-file-name)))) 
;;         (list "pyflakes" (list local-file)))) 

;;     (add-to-list 'flymake-allowed-file-name-masks 
;;                  '("\\.py\\'" flymake-pyflakes-init)))

;;   (flymake-mode 1)
;; )

;; (add-hook 'python-mode-hook 'toolbox-python-mode-hook)

;; Load nxml-mode for files ending in .xml, .xsl, .rng, .xhtml
(add-to-list 'auto-mode-alist '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode))

(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

;; Setting up js2
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Setup Common Lisp mode
(condition-case err
    (require 'cl)
  (error (message "Unable to load Common Lisp package.")))

;; Setup SCons
(setq auto-mode-alist
      (cons '("SConstruct" . python-mode) auto-mode-alist))
 (setq auto-mode-alist
      (cons '("SConscript" . python-mode) auto-mode-alist))

;; Setup nxhtml mode
;; (load "~/.emacs.d/nxhtml/autostart.el")

;; Setup C mode
(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode" t)
(autoload 'c-mode-common-hook "cc-mode" "C Mode Hooks" t)
(autoload 'c-add-style "cc-mode" "Add coding style" t)


;; Associate extensions with modes
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;; Create my own coding style
;; No space before { and function sig indents 4 if argument overflow
(setq bws-c-style
      '((c-auto-newline                 . nil)
        (c-basic-offset                 . 4)
        (c-comment-only-line-offset     . 0)
        (c-echo-syntactic-information-p . nil)
        (c-hungry-delete-key            . t)
        (c-tab-always-indent            . t)
        (c-toggle-hungry-state          . t)
        (c-hanging-braces-alist         . ((substatement-open after)
                                          (brace-list-open)))
        (c-offsets-alist                . ((arglist-close . c-lineup-arglist)
                                           (case-label . 4)
                                           (substatement-open . 0)
                                           (block-open . 0) ; no space before {
                                           (knr-argdecl-intro . -)))
        (c-hanging-colons-alist         . ((member-init-intro before)
                                           (inher-intro)
                                           (case-label after)
                                           (label after)
                                           (access-label after)))
        (c-cleanup-list                 . (scope-operator
                                           Empty-defun-braces
                                           defun-close-semi))))
        


;; Construct a hook to be called when entering C mode
(defun lconfig-c-mode ()
  (progn (define-key c-mode-base-map "\C-m" 'newline-and-indent)
         (define-key c-mode-base-map "\C-z" 'undo)
         (define-key c-mode-base-map [f4] 'speedbar-get-focus)
         (define-key c-mode-base-map [f5] 'next-error)
         (define-key c-mode-base-map [f6] 'run-program)
         (define-key c-mode-base-map [f7] 'compile)
         (define-key c-mode-base-map [f8] 'set-mark-command)
         (define-key c-mode-base-map [f9] 'insert-breakpoint)
         (define-key c-mode-base-map [f10] 'step-over)
         (define-key c-mode-base-map [f11] 'step-into)
         (c-add-style "Brad's Coding Style" bws-c-style t)))
(add-hook 'c-mode-common-hook 'lconfig-c-mode)

;; Setup Javadoc-help
(require 'javadoc-help)

;; Setup JDE, the Java Development Environment for Emacs
;; Add load paths to development versions of jde
;; (add-to-list 'load-path (expand-file-name "~/elisp/jde/lisp"))
;; (add-to-list 'load-path (expand-file-name "~/elisp/ede"))
;; (add-to-list 'load-path (expand-file-name "~/elisp/eieio"))
;; (add-to-list 'load-path (expand-file-name "~/elisp/elib"))
;; (add-to-list 'load-path (expand-file-name "~/elisp/semantic"))
;; (add-to-list 'load-path (expand-file-name "~/elisp/speedbar"))
;; (defun lconfig-jde-mode-hook ()
;;   (progn (define-key jde-mode-map "\M-." 'jde-complete-at-point-menu)
;;          (define-key jde-mode-map "\M-," 'jde-complete-at-point)
;;          (define-key jde-mode-map [f4] 'speedbar-frame-mode)
;;          (define-key jde-mode-map [f5] 'next-error)
;;          (define-key jde-mode-map [f6] 'jde-run)
;;          (define-key jde-mode-map [f7] 'jde-compile)
;;          (define-key jde-mode-map [f8] 'set-mark-command)
;;          (define-key jde-mode-map [f9] 'insert-breakpoint)
;;          (define-key jde-mode-map [f10] 'step-over)
;;          (define-key jde-mode-map [f11] 'step-into)
;;          (setq c-basic-offset 4)))

;; (autoload 'jde-mode "jde" "JDE mode" t)
;; (condition-case err
;;     (progn (add-to-list 'auto-mode-alist '("\\.java$" . jde-mode))
;;            (setq jde-complete-use-menu nil)
;;            (add-hook 'jde-mode-hook 'lconfig-jde-mode-hook))
;;   (error (message "Unable to load JDEE package.")))


;; Setup CPerl mode
(setq cperl-brace-offset -4)
(setq cperl-indent-level 4)


;; Setup func-menu, the function menu quicklink package (XEmacs only)
(autoload 'function-menu "func-menu" "Load the parsing package" t)
(autoload 'fume-add-menubar-entry "func-menu" "Add function menu" t)
(autoload 'fume-list-functions "func-menu" "List functions in window" t)
(autoload 'fume-prompt-function-goto "func-menu" "Goto function" t)
(setq fume-max-items 35)
(setq fume-fn-window-position 3)
(setq fume-auto-position-popup t)
(setq fume-display-in-modeline-p t)
(setq fume-menubar-menu-location "Info")
(setq fume-buffer-name "Function List*")
(setq fume-no-prompt-on-valid-default nil)
;(global-set-key [f8] 'function-menu)
;(define-key global-map "\C-cl" 'fume-list-functions)
;(define-key global-map "\C-cg" 'fume-prompt-function-goto)
(condition-case err
    (progn (function-menu)
           (add-hook 'c-mode-common-hook 'fume-add-menubar-entry))
  (error (message "Unable to load Function Menu package")))


;; Setup speedbar, an additional frame for viewing source files
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
(autoload 'speedbar-toggle-etags "speedbar" "Add argument to etags command" t)
(setq speedbar-frame-plist '(minibuffer nil
                             border-width 0
                             internal-border-width 0
                             menu-bar-lines 0
                             modeline t
                             name "SpeedBar"
                             width 24
                             unsplittable t))
(condition-case err
    (progn (speedbar-toggle-etags "-C"))
  (error (message "Unable to load Speedbar package.")))


;; GNU specific general setup
(if (not (featurep 'xemacs))
  (condition-case err
      (progn (set-scroll-bar-mode 'right)
             (global-font-lock-mode t))
    (error (message "Not running GNU emacs 20.4 or above."))))


;; Setup my own packages
;(add-to-list 'load-path (expand-file-name "~/elisp/"))
;(require 'cpp-font-lock)

;; Add final message so using C-h l I can see if .emacs failed
(message ".emacs loaded successfully.")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/Next.org")))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
