

(add-to-list 'load-path (concat dotfiles-dir "/vendor/ensime/elisp/"))
(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(add-hook 'scala-mode-hook '(lambda ()
  (require 'whitespace)

  ;; clean-up whitespace at save
  (make-local-variable 'before-save-hook)
  (add-hook 'before-save-hook 'whitespace-cleanup)

  ;; turn on highlight. To configure what is highlighted, customize
  ;; the *whitespace-style* variable. A sane set of things to
  ;; highlight is: face, tabs, trailing
  (whitespace-mode)
  ))

(provide 'starter-kit-scala)
