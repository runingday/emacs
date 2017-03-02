(setq inhibit-startup-message t)
(tool-bar-mode -1)
(electric-pair-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "M-x") 'helm-M-x)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Org-mode stuff
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defalias 'list-buffers 'ibuffer)
;; (defalias 'list-buffers 'ibuffer-other-window)

;; If you like a tabbar

;(use-package tabbar
;  :ensure t
;  :config
;  (tabbar-mode 1))


(use-package ace-window
  :ensure t
  :init
  (progn
    (setq aw-dispatch-always t)
    (global-set-key (kbd "M-p") 'ace-window)
    ;(custom-set-char-faces
     ;'(aw-leading-char-face
     ; ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))
    

;; winner mode 
(require 'winner)

(defun winner-mode-settings ()
  "Settings for `winner-mode'."

  ;; disable default winner-mode keybindings
  (setq winner-dont-bind-my-keys t)
  (winner-mode t)
  ;; bind `winner-undo' to `Ctrl-x 4'
  (define-key ctl-x-map "4" 'winner-undo)
  ;; bind `winner-redo' to `Ctrl-x 5'
  (define-key ctl-x-map "5" 'winner-redo)
  )

(eval-after-load "winner"
  `(winner-mode-settings))


(provide 'winner-mode-settings)


(use-package counsel
  :ensure t
  )

(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package color-theme
  :ensure t)

;(use-package zenburn-theme
 ; :ensure t
  ;:config (load-theme 'zenburn t))


(use-package solarized-theme
  :ensure t
  :config (load-theme 'solarized-light t))

(use-package ox-reveal
:ensure ox-reveal)

(setq org-reveal-root "https://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(defvar local-packages '(projectile auto-complete epc jedi))

(defun uninstalled-packages (packages)
 (delq nil
 (mapcar (lambda (p) (if (package-installed-p p nil) nil p)) packages)))

 ;; This delightful bit adapted from:
 ;; http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/

 (let ((need-to-install (uninstalled-packages local-packages)))
 (when need-to-install
 (progn
 (package-refresh-contents)
 (dolist (p need-to-install)
 (package-install p)))))

(require 'package)
(add-to-list 'package-archives
           '("elpy" . "https://jorgenschaefer.github.io/packages/"))
(package-initialize)
(elpy-enable)
(setq elpy-rpc-python-command "python3")
(setq python-check-command "pyflakes")
(eval-after-load "company"
'(add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go))
  :config (setq dumb-jump-selector 'ivy)
  :ensure)

(unless (package-installed-p 'imenu-list)
  (package-refresh-contents)
  (package-install 'imenu-list)
  (setq imenu-list-focus-after-activation t)
  
)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

(require 'helm)
(add-to-list 'load-path "~/.emacs/elpa/async/async")
(add-to-list 'load-path "~/.emacs/elpa/helm-core-2.5.2")
(require 'helm-config)

(add-to-list 'load-path "~/.emacs.d/elpa/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(require 'all-the-icons)
;; or
(use-package meterial-design-icons)

(add-to-list 'load-path "~/.emacs.d/elpa/shell-pop-20170223.222")
(require 'shell-pop)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shell-pop-default-directory "/Users/runningday/")
 '(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/bash")
 '(shell-pop-universal-key "C-t")
 '(shell-pop-window-size 30)
 '(shell-pop-full-span t)
 '(shell-pop-window-position "bottom"))
