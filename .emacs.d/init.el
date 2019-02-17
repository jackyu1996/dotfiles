; Basic Acceptable Configs
(setq gc-cons-threshold 100000000
      initial-scratch-message ""
      package-enable-at-startup nil
      file-name-handler-alist nil
      inhibit-startup-message t
      load-prefer-newer t
      inhibit-default-init t
      history-length 1000
      use-dialog-box nil
      auto-save-default nil
      auto-save-list-file-prefix nil
      make-backup-files nil
      select-enable-primary t
      indicate-empty-lines t
      require-final-newline t
      )
(menu-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(prefer-coding-system 'utf-8)
(setq-default indent-tabs-mode nil)
(global-display-line-numbers-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(set-frame-font "monospace-12" t t)
(put 'narrow-to-region 'disabled nil)

;Package Configs
(setq custom-file (expand-file-name "custom.el" "~/.emacs.d/"))
(when (file-exists-p custom-file)
  (load custom-file))
(require 'package)
(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("org"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t
      use-package-always-ensure t)
(require 'use-package)

;Actual Configs
(use-package ample-theme
             :ensure t
             :init
             (load-theme 'ample t)
             )

(use-package company
             :ensure t
             :config
             (global-company-mode)
             (setq company-idle-delay 0.2
                   company-selection-wrap-around t)
             )

(use-package dashboard
             :ensure t
             :config
             (dashboard-setup-startup-hook)
             (setq dashboard-banner-logo-title "What to destroy today?"
                   dashboard-items '(
                                     (recents  . 10)
                                     (agenda . 10)
                                     )
                   show-week-agenda-p t
                   dashboard-startup-banner 'logo
                   )
             )

(use-package evil
             :ensure t
             :after company
             :init
             (setq evil-want-keybinding nil
                   evil-want-C-u-scroll t
                   )
             :config
             (evil-mode)
             )

(use-package evil-collection
             :ensure t
             :after (evil company)
             :config
             (evil-collection-init)
             )

(use-package evil-org
             :ensure t
             :after evil
             :config
             (add-hook 'org-mode-hook 'evil-org-mode)
             (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
             (require 'evil-org-agenda)
             (evil-org-agenda-set-keys)
             )

(use-package goldendict
             :ensure t
             :bind ("C-c g" . goldendict-dwim))

(use-package helm
             :ensure t
             :bind
             (
              ("M-x" . helm-M-x)
              ("M-f" . helm-find-files)
              ("M-b" . helm-buffers-list)
              )
             :defer 1
             :config
             (helm-mode)
             (helm-autoresize-mode)
             )

(use-package helm-ag
             :ensure t
             :bind
             ("C-x a a" . helm-ag)
             :after helm
             )

(use-package ob-async
             :ensure t
             )

(use-package org
             :ensure t
             :bind
             ("C-c a" . org-agenda)
             ("C-c b" . org-switchb)
             ("C-c c" . org-capture)
             :config
             (setq org-agenda-files '("~/Documents/notes/")
                   org-capture-templates '(
                                           ("t" "Todo" entry (file+headline "~/Documents/notes/TODO.org" "Daily")
                                            "* TODO %? %i\n")
                                           ("j" "Journal" plain (file+olp+datetree "~/Documents/notes/JOURNAL.org")
                                            "     %? %i\n")
                                           ("h" "Homework" entry (file+headline "~/Documents/notes/TODO.org" "Homework")
                                            "* TODO %? %i\nSCHEDULED: %^t")
                                           )
                   org-goto-interface 'outline-path-completion
                   org-outline-path-complete-in-steps nil
                   )
             )

(use-package org-bullets
             :ensure t
             :after org
             :config
             (add-hook 'org-mode-hook 'org-bullets-mode)
             )

(use-package org-kanban
             :ensure t
             :defer t
             :after org
             )

(use-package ox-pandoc
             :ensure t
             :defer t
             :after org
             )

(use-package powerline
             :ensure t
             :config
             (powerline-center-theme)
             )

(use-package smartparens
             :ensure t
             :config
             (smartparens-global-mode)
             )

(use-package which-key
             :ensure t
             :config
             (which-key-mode)
             (setq which-key-idle-delay 0.2)
             )
