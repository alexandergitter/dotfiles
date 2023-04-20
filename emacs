;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initilize packaging and install use-package ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

; use-package comes included with Emacs 29, so this can probably be removed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Configure packages ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(use-package move-text
  :config (move-text-default-bindings))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package gruvbox-theme
  :config (load-theme 'gruvbox t))

(use-package counsel
  :bind (("C-s" . swiper))
  :init
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  :config
  (ivy-mode 1)
  (counsel-mode 1))

(use-package which-key
  :config (which-key-mode))

(use-package projectile
  :config (projectile-mode))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package markdown-mode
  :hook (markdown-mode . display-fill-column-indicator-mode))

;;;;;;;;;;;;;;;;;
;; Misc Config ;;
;;;;;;;;;;;;;;;;;

;; Use separate custom-file, so emacs doesn't touch this one
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file :noerror)

;; Don't show Emacs start page
(setq inhibit-startup-message t)

;; Hide GUI elements
(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Backup preferences
(setq backup-directory-alist '(("." . "~/.backups"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 5
      kept-old-versions 2
      version-control t)

(defalias 'yes-or-no-p 'y-or-n-p)

(windmove-default-keybindings '(meta shift))
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain)
(setq dired-listing-switches "-aho --group-directories-first")
(add-hook 'before-save-hook 'delete-trailing-whitespace)
