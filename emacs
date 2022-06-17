;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initilize packaging and install use-package ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Configure packages ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(setq use-package-always-ensure t)

(use-package magit
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package gruvbox-theme
  :ensure gruvbox-theme
  :config (load-theme 'gruvbox t))

(use-package counsel
  :init
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  :config
  (ivy-mode 1))

(use-package which-key
  :config (which-key-mode))

(use-package projectile
  :config (projectile-mode))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;;;;;;;;;;;;;;;;;
;; Misc Config ;;
;;;;;;;;;;;;;;;;;

;; Use separate custom-file, so emacs doesn't touch this one
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file :noerror)

;; Hide GUI elements
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Backup preferences
(setq backup-directory-alist `(("." . "~/.backups"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 5
      kept-old-versions 2
      version-control t)

(defalias 'yes-or-no-p 'y-or-n-p)

(windmove-default-keybindings 'meta)
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
