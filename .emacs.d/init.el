;;; init.el --- Emacs config file by Cierpliwy
;;; Commentary:
;; All packages are defined in Cask file

;;; Code:
(require 'cask "~/.cask/cask.el")
(cask-initialize)

; Load Leuven theme
(load-theme 'zenburn t)

; Disable buckups
(setq make-backup-files nil)
(setq auto-save-default nil)

; Enable ido mode
(ido-mode t)

; Disable GUI
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

; Enable vim emulation
(evil-mode 1)

; Turn off wrap
(toggle-truncate-lines)

; Enable flycheck for every buffer
(add-hook 'after-init-hook #'global-flycheck-mode)

; Enable company mode for every buffer
(add-hook 'after-init-hook 'global-company-mode)

(defun indent-or-complete ()
  "Complete or indent after tab is pressed."
    (interactive)
    (if (looking-at "\\_>")
        (company-complete-common)
      (indent-according-to-mode)))
(global-set-key (kbd "TAB") 'indent-or-complete)

; ====== Programming related ======
(yas-global-mode 1)

; ============ C/C++ ==============
(require 'ycmd)
(defun setup-ycmd ()
  "Setup ycmd."
  (set-variable 'ycmd-server-command '("python" "/home/cierpliwy/git/ycmd/ycmd"))
  (set-variable 'ycmd-extra-conf-whitelist '("~/git/*"))
  (ycmd-mode)
  (ycmd-toggle-force-semantic-completion)
  (company-ycmd-setup)
  (flycheck-ycmd-setup))
(add-hook 'c-mode-common-hook 'setup-ycmd)

; Move between buffers using shift arrows
(global-set-key (kbd "S-<up>")       'windmove-up)
(global-set-key (kbd "S-<down>")     'windmove-down)
(global-set-key (kbd "S-<left>")     'windmove-left)
(global-set-key (kbd "S-<right>")    'windmove-right)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

; Format full source code using C-c f macro or after
; file is saved in C/C++ mode
(global-set-key (kbd "C-c f") 'clang-format-buffer)

(add-hook 'c-mode-common-hook
	  (lambda ()
	  (add-hook 'before-save-hook 'clang-format-buffer nil 'local)))

; Guess indent style for C/C++
(add-hook 'c-mode-common-hook 'c-guess)

; ============ GO ==============
(require 'go-mode)
(add-hook 'go-mode-hook (lambda ()
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode)))
(add-hook 'go-mode-hook
	  (lambda ()
	  (add-hook 'before-save-hook 'gofmt-before-save nil 'local)))

; Show line numbers on left side
(global-linum-mode 1)

; Highlight matched parens
(show-paren-mode 1)

; Enable git gutter
(require 'git-gutter-fringe+)
(global-git-gutter+-mode t)

; Enable smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

; Ace jump mode
(define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode)
(define-key evil-motion-state-map (kbd "C-SPC") #'evil-ace-jump-word-mode)

; Font settings
(set-face-attribute 'default nil :height 100)

;; END OF CONFIG FILE
(provide 'init)
;;; init.el ends here
