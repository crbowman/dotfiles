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
;; Appearance
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Powerline Configs
(setq powerline-height 40)
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
;; Miscellaneous
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Temp Files

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating .#lock files

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Keybindings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable windmove as an alternative to other-window
;; Use super-<left>|<right>|<up>|<down> to change windows
(windmove-default-keybindings 'super)

(global-set-key (kbd "C-x p") (lambda ()
                                (interactive)
                                (other-window 1)))

(global-set-key (kbd "C-x o") (lambda ()
                                (interactive)
                                (other-window -1)))

;; Search and Replace
(global-set-key (kbd "C-s") 'isearch-forward-regex)
(global-set-key (kbd "C-r") 'isearch-backward-regex)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-%") 'isearch-query-replace-regex)
(global-set-key (kbd "C-M-%") 'isearch-query-replace)

;; OSX Specific
(if (equal system-type 'darwin)
    (progn
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier 'super)
      (setq mac-function-modifier 'hyper)))

;; Function Keys
(global-set-key [f1] 'spacemacs/cycle-spacemacs-theme)
(global-set-key [f2] 'smartparens-strict-mode)
(global-set-key [f3] 'delete-trailing-whitespace)
(global-set-key [f4] 'comment-or-uncomment-region)
(global-set-key [f5] 'helm-projectile)
(global-set-key [f6] 'magit-status)
(global-set-key [f7] 'spacemacs/default-pop-shell)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "<f9>") (lambda ()
                                (interactive)
                                (other-window -1)))
(global-set-key (kbd "<f10>") (lambda ()
                                (interactive)
                                (other-window 1)))
(global-set-key [f11] 'toggle-frame-fullscreen)
(global-set-key [f12] 'undo-tree-undo)

;; Logitech G710+ G-keys
(global-set-key [s-f1] 'isearch-backward)
(global-set-key [s-f2] 'isearch-forward)
(global-set-key [s-f3] 'isearch-query-replace)
(global-set-key [s-f4] 'org-babel-tangle)
(global-set-key (kbd "<s-f5>") (lambda ()
                                 (interactive)
                                 (find-file "~/code/dotfiles/editor/emacs/config.org")))
(global-set-key (kbd "<s-f6>") (lambda ()
                                 (interactive)
                                 (find-file "~/code/dotfiles/editor/emacs/.myspacemacs")))

;; Miscellaneous
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Helm
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;; Python
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; setup pyenv
(setq exec-path (append '("/home/curtis/.config/pyenv/bin" "/home/curtis/.config/pyenv/shims" ) exec-path))

;; use ipython as python interpreter
(setq python-shell-interpreter-args "--simple-prompt -i" )
(setq python-shell-interpreter "/home/curtis/.config/pyenv/shims/ipython")

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
;; Which-Key
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq which-key-side-window-location 'right)
(setq which-key-side-window-max-width 0.33)
(setq which-key-side-window-max-height 0.25)
(setq which-key-add-column-padding 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; GPG
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'epa-file)
(custom-set-variables '(epg-gpg-program "/usr/bin/gpg"))
(epa-file-enable)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Multiple Major Modes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(mmm-add-classes '((markdown-clojure
                      :submode clojure-mode
                      :face mmm-declaration-submode-face
                      :front "^{% highlight clojure %}[\n\r]+"
                      :back "^{% endhighlight %}$")))

  (mmm-add-classes '((markdown-latex
                      :submode TeX-mode
                      :face mmm-declaration-submode-face
                      :front "^\\$\\$[\n\r]+"
                      :back "^\\$\\$$")))

  (mmm-add-mode-ext-class 'markdown-mode nil 'markdown-clojure)
  (mmm-add-mode-ext-class 'markdown-mode nil 'markdown-latex)

  (setq mmm-parse-when-idle 't)

(cond ((>= 3840 (display-pixel-width)) 20)
      ((>= 2560 (display-pixel-width)) 16)
      ((>= 1980 (display-pixel-width)) 14)
      ((>= 1440 (display-pixel-width)) 12))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Spotify.el
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/code/spotify.el/")

(use-package spotify
  :config
  (setq spotify-oauth2-client-secret "8021211038534fbc8c3041e32e7f966c")
  (setq spotify-oauth2-client-id "7d7e10746824419ea6a4129dd42839d8"))
