((org-mode
  . ((lexical-binding . t)
     (system-pkg-mode . t)
     (org-confirm-babel-evaluate . nil)
     (after-save-hook . org-babel-tangle)
     (before-save-hook . delete-trailing-whitespace)
     (eval . (add-hook 'org-babel-pre-tangle-hook #'org-babel-execute-buffer nil t))
     (eval . (add-hook 'org-babel-tangle-finished-hook #'system-pkg-install-queued nil t)))))
