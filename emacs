;; Initilize packaging and install use-package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Configure packages
(setq use-package-always-ensure t)

(use-package magit
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package monokai-theme
  :ensure monokai-theme
  :config (load-theme 'monokai t))

(use-package counsel
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line))

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
