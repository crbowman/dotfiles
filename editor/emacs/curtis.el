;;; -*- lexical-binding: t -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Personal Information
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name "Curtis Bowman"
      user-mail-address "curtis@partiallyappllied.io")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Visuals
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Powerline Configs
(setq powerline-height 25)
(setq ns-use-srgb-colorspace t)
(setq powerline-default-separator 'utf8)
(setq powerline-default-separator 'wave)
(spaceline-compile)

;; Doom Themes Configuration
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(doom-themes-neotree-config)
(setq doom-neotree-file-icons 'simple)
(doom-themes-org-config)

;; Changes the background color to create contrast between file buffers and
;; pop-up buffers like neotree/helm/etc..
(use-package solaire-mode
  :hook ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
  :config
  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Keybindings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable windmove as an alternative to other-window
;; Use super-<left>|<right>|<up>|<down> to change windows
(windmove-default-keybindings 'super)

;; Window Switching: back one
(global-set-key (kbd "C-x o") (lambda ()
                                (interactive)
                                (other-window -1)))

;; Window Switching: forward one
(global-set-key (kbd "C-x p") (lambda ()
                                (interactive)
                                (other-window 1)))

;; Search and Replace 
(global-set-key (kbd "C-s") 'isearch-forward-regex)
(global-set-key (kbd "C-r") 'isearch-backward-regex)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-%") 'isearch-query-replace-regex)
(global-set-key (kbd "C-M-%") 'isearch-query-replace-regex)

;; OSX Specific
(if (equal system-type 'darwin)
    (progn
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier 'super)
      (setq mac-function-modifier 'hyper)))

;; Hide boring buffers by regex
(setq helm-boring-buffer-regexp-list 
      (quote
       ("\\*.+\\*"
        "\\` \\*"
        "magit.+")))

;; Hide additional buffers based on mode
(defun my-filter-dired-buffers (buffer-list)
  (delq nil (mapcar
             (lambda (buffer)
               (if (eq (with-current-buffer buffer major-mode)  'dired-mode)
                   nil
                 buffer))
             buffer-list)))

(advice-add 'helm-skip-boring-buffers :filter-return 'my-filter-dired-buffers)

;; Whitelist buffers that shouldn't be hidden
(setq helm-white-buffer-regexp-list 
      (quote
       ("\\*Messages\\*"
        "\\*ansi-term"
        "\\*cider-repl.+\\*"
        "\\*cider-error.+\\*"
        "magit:.+")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Clojure
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Represent annonymous functions, partial functions, and sets with greek symbols
(setq clojure-enable-fancify-symbols t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Smartparens
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Smartparens keybindings
(global-set-key (kbd "C-M-f") 'sp-forward-sexp)
(global-set-key (kbd "C-M-b") 'sp-backward-sexp)

(global-set-key (kbd "C-M-d") 'sp-down-sexp)
(global-set-key (kbd "C-M-a") 'sp-backward-down-sexp)
(global-set-key (kbd "C-S-d") 'sp-beginning-of-sexp)
(global-set-key (kbd "C-S-a") 'sp-end-of-sexp)

(global-set-key (kbd "C-M-e") 'sp-up-sexp)
(global-set-key (kbd "C-M-u") 'sp-backward-up-sexp)
(global-set-key (kbd "C-M-t") 'sp-transpose-sexp)

(global-set-key (kbd "C-M-n") 'sp-forward-hybrid-sexp)
(global-set-key (kbd "C-M-p") 'sp-backward-hybrid-sexp)

(global-set-key (kbd "C-M-k") 'sp-kill-sexp)
(global-set-key (kbd "C-M-w") 'sp-copy-sexp)

(global-set-key (kbd "M-<delete>") 'sp-unwrap-sexp)
(global-set-key (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

(global-set-key (kbd "C-<right>") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-<left>") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-<right>") 'sp-backward-barf-sexp)

(global-set-key (kbd "M-D") 'sp-splice-sexp)
(global-set-key (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
(global-set-key (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(global-set-key (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(global-set-key (kbd "C-]") 'sp-select-next-thing-exchange)
(global-set-key (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(global-set-key (kbd "C-M-]") 'sp-select-next-thing)

(global-set-key (kbd "M-F") 'sp-forward-symbol)
(global-set-key (kbd "M-B") 'sp-backward-symbol)

(global-set-key (kbd "C-\"") 'sp-change-inner)
(global-set-key (kbd "M-i") 'sp-change-enclosing)

(bind-key "C-c f" (lambda () (interactive) (sp-beginning-of-sexp 2)) smartparens-mode-map)
(bind-key "C-c b" (lambda () (interactive) (sp-beginning-of-sexp -2)) smartparens-mode-map)

(global-set-key (kbd "H-<delete>") (lambda ()
                              (smartparens-strict-mode nil)
                              (delete-backward-char)
                              (smartparens-strict-mode t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Flyspell
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default dotspacemacs-configuration-layers
  '((spell-checking :variables spell-checking-enable-by-default nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Which-Key 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq which-key-side-window-location 'right)
(setq which-key-side-window-max-width 0.33)
(setq which-key-side-window-max-height 0.25)
(setq which-key-add-column-padding 2)

(require 'epa-file)
(custom-set-variables '(epg-gpg-program "/usr/local/MacGPG2/bin/gpg2"))
(epa-file-enable)
