(setq-default fill-column 80)                             ; set width to 80
(global-display-line-numbers-mode)                ; display line numbers
(global-display-fill-column-indicator-mode)       ; line on right for width
(column-number-mode)                              ; display column number
(load-theme 'misterioso)                          ; theme
(global-hl-line-mode)                             ; highlight the current line
(setq display-line-numbers-type 'relative)
; (text-scale-adjust -1)


(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

;; packages installation
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
; (package-refresh-contents) ;; enable when need to refresh package list

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   '(("melpa-stable" . "https://stable.melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(gnuplot gnuplot-mode company multiple-cursors magit markdown-preview-mode markdown-toc markdown-mode auto-correct)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'after-init-hook 'global-company-mode)
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-:") 'goto-line)
