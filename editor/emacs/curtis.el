;;; -*- lexical-binding: t -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Personal Information
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name "Curtis Bowman"
      user-mail-address "curtis@partiallyappllied.tech")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Appearance
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Doom Modeline
(setq doom-modeline-buffer-file-name-style 'relative-from-project)

;; Display Time
(setq display-time-default-load-average nil)
(display-time-mode)

;; Doom Themes Configuration
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(doom-themes-neotree-config)
(doom-themes-org-config)

;; Changes the background color to create contrast between file buffers and
;; pop-up buffers like neotree/helm/etc..
(use-package solaire-mode
  :hook ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
  :hook (minibuffer-setup . solaire-mode-in-minibuffer)
  :config
  (setq solaire-mode-auto-swap-bg nil)
  (solaire-global-mode +1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Miscellaneous
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Temp Files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating .#lock files

;; set org-babel default sh command to zsh
(setq org-babel-sh-command "zsh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Keybindings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; OSX Specific
(if (equal system-type 'darwin)
    (progn
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier 'super)
      (setq mac-function-modifier 'hyper)))

;; Emacs window switching
(global-set-key (kbd "C-x o") (lambda ()
                                (interactive)
                                (other-window -1)))

(global-set-key (kbd "C-x p") (lambda ()
                                (interactive)
                                (other-window 1)))

;; Enable windmove as an alternative to other-window
;; Use super-<left>|<right>|<up>|<down> to change windows
(windmove-default-keybindings 'super)

;;Function Keys
(global-set-key [f1] 'spacemacs/cycle-spacemacs-theme)
(global-set-key [f2] 'smartparens-strict-mode)
(global-set-key [f3] 'delete-trailing-whitespace)
(global-set-key [f4] 'comment-or-uncomment-region)
(global-set-key [f5] 'projectile-dired)
(global-set-key [C-f5] 'helm-projectile)
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
(global-set-key [f13] 'evil-toggle-fold)
(global-set-key [C-f13] 'spacemacs/fold-transient-state/body)
(global-set-key [f14] 'evil-close-folds)
(global-set-key [f15] 'evil-open-folds)

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

;;Miscellaneous
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
        "\\*Warnings\\*"
        "\\*ansi-term"
        "\\*cider-repl.+\\*"
        "\\*cider-error.+\\*"
        "\\*spacemacs\\*"
        "magit:.+")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Clojure
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package clojure-mode
  :bind (:map clojure-mode-map
              ([C-f7] . cider-jack-in)
              ([C-M-f7] . cider-eval-buffer)))

;; Represent annonymous functions, partial functions, and sets with greek symbols
(setq clojure-enable-fancify-symbols t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Python
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Setup pyenv
(cond ((equal system-type 'darwin)
       (defvar pyenv-home "/Users/curtis/.pyenv"))
      ((equal system-type 'gnu/linux)
       (defvar pyenv-home "/home/curtis/.config/pyenv")))

(setq exec-path (append
                 `(,(concat pyenv-home "/bin")
                   ,(concat pyenv-home "/shims"))
                 exec-path))

;; Python interpreter to use for repl
(setq python-shell-interpreter-args "--simple-prompt -i" )
(setq python-shell-interpreter (concat pyenv-home "/shims/ipython"))

;; Hooks
(use-package python-mode
  :bind (:map python-mode-map
              ([C-f7] . spacemacs/python-start-or-switch-repl)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Smartparens
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Keybindings
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

(global-set-key (kbd "C-0") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-M-0") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-9") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-9") 'sp-backward-barf-sexp)

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

(use-package epa-file
  :config
  (cond ((equal system-type 'darwin)
         (custom-set-variables '(epg-gpg-program "/usr/local/MacGPG2/bin/gpg2")))
        ((equal system-type 'gnu/linux)
         (custom-set-variables '(epg-gpg-program "/usr/bin/gpg"))))
  (epa-file-enable))

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
