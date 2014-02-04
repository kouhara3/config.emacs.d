;; E Address
(setq user-mail-address "takahara.gregory@gmail.com")

;; Load path
(defconst self-lisp "~/.emacs.d/site-lisp" "The directory for my elisp file.")
(dolist (dir (let ((dir (expand-file-name self-lisp)))
               (list dir (format "%s%d" dir emacs-major-version))))
  (when (and (stringp dir) (file-directory-p dir))
    (let ((default-directory dir))
      (add-to-list 'load-path default-directory)
      (normal-top-level-add-subdirs-to-load-path))))

;; Set background color and transparency(设置背景颜色以及透明效果)
(custom-set-faces
 '(default ((t (:background "#000022" :foreground "#EEEEEE"))))
 '(cursor (
					 (((class color) (background dark )) (:background "#00AA00"))
					 (((class color) (background light)) (:background "#999999"))
					 (t ())
					 )))
;;フレーム透過設定
(add-to-list 'default-frame-alist '(alpha . (0.90 0.90)))

;; Inhibit Backup file
(setq backup-inhibited t)

;; autoinsert
(require 'autoinsert)
(defconst templates "~/.emacs.d/templates")
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory templates)
(setq auto-insert-alist
      (append '(
                ("\\.html" . "html-template")
                ("\\-rec.txt" . "record-template")
                ("\\-wly.txt" . "weekly-template")
                ) auto-insert-alist)
      )
(setq auto-insert-query nil)

;; iswitch-mode
(iswitchb-mode 1)

;; Key bind of iswitch-mode
(add-hook 'iswitchb-define-mode-map-hook
		  (lambda ()
		    (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
		    (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
		    )
		  )

;; Indicate File Name in Title Bar
(setq frame-title-format (format "%%f - emacs " (system-name)))

;; Hide Menu Bar
(menu-bar-mode 0)

;; Set Default Encoding
(set-default-coding-systems 'utf-8)

;; Japanese Environment
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

;; Make Tab as 4 spaces
(setq default-tab-width 4)
(setq indent-line-function 'indent-relative-maybe)

;; Set C-h as BackSpace
(global-set-key "\C-h" 'delete-backward-char)

;; auto-complete-mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete-1.3.1/ac-dict")
(ac-config-default)

;; Parentheses Highlighting
(show-paren-mode 1)
(setq show-paren-delay 1)
(setq show-paren-style 'epression)
(set-face-attribute 'show-paren-match-face nil
		    :background "black"
		    :foreground nil
		    :underline t
		    ;;		    :weight 'bold
		    )
(set-face-attribute 'show-paren-mismatch-face nil
		    :background "black"
		    :foreground "DarkRed"
		    
		    ;;		    :weight 'bold
		    )

;; hl-line-mode
(require 'hl-line)
(custom-set-faces 
 '(hl-line
   ((((class color)
      (background dark))
     (:background "MidnightBlue"))
    (((class color)
     (background light))
     (:background "MidnightBlue"))))
)
(global-hl-line-mode)

;; Cursor Design
(add-to-list 'default-frame-alist '(cursor-type . (bar . 4)))


;; Linum
(require 'linum)
(global-linum-mode t)
(setq linum-format "%5d ")

;; color-theme
;;(require 'color-theme)
;;(when (require 'color-theme)
;; 	(when (require 'color-theme-solarized)
;; 		(color-theme-solarized-dark)))
(load-file "~/.emacs.d/site-lisp/tomorrow-theme-master/tomorrow-night-theme.el")
;; column-number-mode
(column-number-mode t)

;; ruby-mode
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))
(setq show-trailing-whitespace 0)

;; rubydb
(autoload 'ruby "rubydb2x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;; ruby-electric.el --- electric editing commands for ruby files
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
(setq minor-mode-map-alist (append (delete rel minor-mode-map-alist) (list rel))))
(setq ruby-electric-expand-delimiters-list nil)
(setq ruby-indent-level 4)
(setq ruby-indent-tabs-mode nil)
(modify-coding-system-alist 'file "\\.rb$" 'utf-8)
(modify-coding-system-alist 'file "\\.rhtml$" 'utf-8)

;; ruby-block
(require 'ruby-block)
(defun ruby-mode-hook-ruby-block()
(ruby-block-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-block)
(setq ruby-block-highlight-toggle t)
(put 'upcase-region 'disabled nil)

;; set display-time
(display-time)

;; nxml-mode
;; (add-to-list 'auto-mode-alist '("\\.php$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . nxml-mode))
(add-hook 'nxml-mode-hook
          (lambda ()
			(setq nxml-slash-auto-complete-flag t)
            (setq nxml-bind-meta-tab-to-complete-flag t)
            (setq nxml-child-indent 2)
            (setq nxml-attribute-indent 2)
            (setq tab-width 2)
            (setq indent-tabs-mode nil)
            ))


;; js2-mode(mooz)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


;; css-mode
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(setq cssm-indent-level 4)
(setq cssm-indent-function #'cssm-c-style-indenter)


;; php-mode
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-hook 'php-mode-hook
          '(lambda ()
             (setq c-basic-offset 4)
             (setq c-tab-width 4)
             (setq c-indent-level 4)
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq-default tab-width 4)
             ))

;; Auto complete parentheses
;; (global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "<") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "\*") 'skeleton-pair-insert-maybe)
;; (setq skeleton-pair 1)


(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(require 'direx)
(setq direx:leaf-icon " "
	  direx:open-icon "[-]"
	  direx:closed-icon "[+]")
(push '(direx:direx-mode :position left :width 30 :dedicated t)
	  popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
;; (global-set-key (kbd "C-x C-j") 'direx-project:jump-to-project-root-other-window)
