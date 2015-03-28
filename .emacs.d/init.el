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

; Enable ido mode
(ido-mode t)

; Disable GUI
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

; Enable vim emulation
(evil-mode 1)

; Enable flycheck for every buffer
(add-hook 'after-init-hook #'global-flycheck-mode)

; Enable company mode for every buffer
(add-hook 'after-init-hook 'global-company-mode)

(defun complete-or-indent ()
  "Complete or indent after tab is pressed."
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
  (indent-according-to-mode)))
(global-set-key (kbd "TAB") 'complete-or-indent)

; Enable ycm for C/C++
(ycmd-setup)
(ycmd-toggle-force-semantic-completion)
(add-hook 'c++-mode-hook 'ycmd-mode)
(set-variable 'ycmd-server-command '("python" "/home/cierpliwy/Git/ycmd/ycmd"))
(set-variable 'ycmd-extra-conf-whitelist '("~/Git/*"))
(company-ycmd-setup)
(flycheck-ycmd-setup)

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

(add-hook 'c++-mode-hook
	  (lambda ()
	  (add-hook 'before-save-hook 'clang-format-buffer nil 'local)))
(add-hook 'c-mode-hook
	  (lambda ()
	  (add-hook 'before-save-hook 'clang-format-buffer nil 'local)))

; Guess indent style for C/C++
(add-hook 'c-mode-hook 'c-guess)
(add-hook 'c++-mode-hook 'c-guess)

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
