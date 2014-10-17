;;
;; Ricty
;;
(add-to-list 'default-frame-alist '(font . "ricty-13.5"))
(custom-set-faces
 '(variable-pitch ((t (:family "Ricty"))))
 '(fixed-pitch ((t (:family "Ricty"))))
 )

;;
;; Package
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;
;; Auto-save-buffers
;;
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 0.5)
(auto-save-buffers-enhanced t)

;;
;; clmemo
;;
(autoload 'clmemo "clmemo" "ChangeLog MEMO mode." t)
(define-key ctl-x-map "M" 'clmemo)
(setq clmemo-file-name "~/Dropbox/clmemo/ChangeLog")
(setq add-log-mailing-address "nobsun@sampou.org")
(setq add-log-full-name "Nobuo Yamashita")

;;
;; GHC
;;
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;;
;; Linum
;;
(require 'linum)
(global-linum-mode)
;;(global-hl-line-mode)
;;(setq hl-line-face 'underline)

;;
;; SKK
;;
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(autoload 'skk-mode "skk" nil t)
(autoload 'skk-isearch-mode-setup "skk-isearch" nil t)
(autoload 'skk-isearch-mode-cleanup "skk-isearch" nil t)
(add-hook 'isearch-mode-hook
	  (function (lambda ()
	     (and (boundp 'skk-mode) skk-mode
		  (skk-isearch-mode-setup)))))
(add-hook 'isearch-mode-end-hook
	  (function (lambda ()
		      (and (boundp 'skk-mode) skk-mode
			   (skk-isearch-mode-cleanup)
			   (skk-set-cursor-color-properly)))))
(setq skk-kutouten-type 'en)
;(setq skk-kutouten-type 'jp)

;;
;; yatex-mode
;;
(setq auto-mode-alist
      (cons '("\\.tex$" . yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode." t)
(setq YaTeX-kanji-code 4)
(setq tex-command "platex")
(add-hook 'yatex-mode-hook
	  '(lambda () (auto-fill-mode 0))
	  )
(setq dviprint-command-format "dvipdfmx %s")
(setq makeindex-command "mendex")

;;
;; yahtml-mode
;;
(setq auto-mode-alist
      (cons '("\\.html$" . yahtml-mode) auto-mode-alist))
(setq yahtml-kanji-code 4)
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)

(add-hook 'yahtml-mode-hook
	  '(lambda () (auto-fill-mode 0))
	  )

;;
;; misc
;;
(mouse-wheel-mode t)
(global-font-lock-mode t)
(auto-compression-mode t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-scroll-bar-mode nil)

;(set-default indent-tabs-mode nil)

(setq visible-bell t)
(setq line-number-mode t)
(setq column-number-mode t)
(setq frame-title-format (concat "%b (%f)"))
(setq next-line-add-newlines nil)
(setq inhibit-startup-message t)

(global-set-key "\C-z" 'undo)
