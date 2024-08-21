;;; init --- personal init -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Enable MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Common modules for Pachemacs
(add-to-list 'load-path "/home/arisu/.emacs.d/lisp/")
;; If you're not an EXWM enjoyer, you can remove or comment the line below
(load "~/.emacs.d/lisp/pache-exwm.el")
(load "~/.emacs.d/lisp/pache-ui.el")
;; If you're not an Evil enjoyer, you might also want to remove pache-evil below
(load "~/.emacs.d/lisp/pache-evil.el")
(load "~/.emacs.d/lisp/pache-keys.el")
(load "~/.emacs.d/lisp/pache-misc.el")
(load "~/.emacs.d/lisp/pache-yas.el")
(load "~/.emacs.d/lisp/pache-programming.el")
(load "~/.emacs.d/lisp/pache-irc.el")

;; Miscellaneous options
(setq-default major-mode
              (lambda () ; guess major mode from file name
                (unless buffer-file-name
                  (let ((buffer-file-name (buffer-name)))
                    (set-auto-mode)))))

(setq confirm-kill-emacs #'yes-or-no-p
      window-resize-pixelwise t
      frame-resize-pixelwise t
      auto-save-default nil
      scroll-step 1
      sentence-end-double-space nil
      backup-directory-alist `(("." . "~/.saves"))
      inhibit-startup-echo-area-message "The shrine isn't a good place for using magic.")

(save-place-mode t)
(savehist-mode t)
(recentf-mode t)
(defalias 'yes-or-no #'y-or-n-p)
(global-display-line-numbers-mode t)
(setq visible-bell 1)

;;; Make Emacs run faster
(setq gc-cons-threshold 100000000
      read-process-output-max (* (* 1024 1024) 3)
      inhibit-compacting-font-caches t)

(run-with-idle-timer 2 t (lambda () (garbage-collect)))

;; Disable some LSP options if Emacs gets too slow
;; (with-eval-after-load 'lsp-mode
;;   (setq lsp-log-io nil
;;         lsp-idle-delay 0.5
;;         lsp-auto-guess-root nil
;;         lsp-restart 'auto-restart
;;         lsp-enable-symbol-highlighting nil
;;         lsp-enable-on-type-formatting nil
;;         lsp-signature-auto-activate nil
;;         lsp-signature-render-documentation nil
;;         lsp-eldoc-hook nil
;;         lsp-modeline-code-actions-enable nil
;;         lsp-modeline-diagnostics-enable nil
;;         lsp-headerline-breadcrumb-enable nil
;;         lsp-semantic-tokens-enable nil
;;         lsp-enable-folding nil
;;         lsp-enable-imenu nil
;;         lsp-enable-snippet nil))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "0d6e6ec6d1070698873f776b4de71438c1a04321b3d1b572b22e026c5ab556dd" default))
 '(package-selected-packages
   '(catppuccin-theme solarized-theme desktop-environment exwm yasnippet yaml-mode which-key vue-mode vertico typescript-mode sudo-edit sly rust-mode php-mode nvm nerd-icons multi-vterm move-text magit lua-mode lsp-mode json-mode gruvbox-theme go-mode flycheck evil-mc emms eglot editorconfig eat diff-hl counsel corfu consult all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
