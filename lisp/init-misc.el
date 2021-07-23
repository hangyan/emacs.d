;;; init-misc.el --- Miscellaneous config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Misc config - yet to be placed in separate files

(add-auto-mode 'tcl-mode "^Portfile\\'")
(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'prog-mode-hook 'goto-address-prog-mode)
(setq goto-address-mail-face 'link)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'after-save-hook 'sanityinc/set-mode-for-new-scripts)

(defun sanityinc/set-mode-for-new-scripts ()
  "Invoke `normal-mode' if this file is a script and in `fundamental-mode'."
  (and
   (eq major-mode 'fundamental-mode)
   (>= (buffer-size) 2)
   (save-restriction
     (widen)
     (string= "#!" (buffer-substring (point-min) (+ 2 (point-min)))))
   (normal-mode)))


(when (maybe-require-package 'info-colors)
  (with-eval-after-load 'info
    (add-hook 'Info-selection-hook 'info-colors-fontify-node)))


;; Handle the prompt pattern for the 1password command-line interface
(with-eval-after-load 'comint
  (setq comint-password-prompt-regexp
        (concat
         comint-password-prompt-regexp
         "\\|^Please enter your password for user .*?:\\s *\\'")))



(when (maybe-require-package 'regex-tool)
  (setq-default regex-tool-backend 'perl))

(with-eval-after-load 're-builder
  ;; Support a slightly more idiomatic quit binding in re-builder
  (define-key reb-mode-map (kbd "C-c C-k") 'reb-quit))

(add-auto-mode 'conf-mode "^Procfile\\'")


;;; dumb-jump
;;; install ag:  brew install the_silver_searcher
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)


(defun my-toggle-ecb ()
  "aaa."
  (interactive)
  (message (concat "rg -n " (thing-at-point 'word 'no-properties)))
  )



(defun my-grep ()
  "Setting up grep-command using current word under cursor as a search string."
  (interactive)
  (let* ((cur-word (thing-at-point 'word))
         (cmd (concat "rg -n -H --no-heading -e " cur-word  " $(git rev-parse --show-toplevel || pwd)")))
    (grep-apply-setting 'grep-command cmd)
    (grep cmd)))


;;; use grep
;;; brew install ripgrep
(global-set-key (kbd "C-x C-g") 'my-grep)

;;; ebpf
(add-to-list 'auto-mode-alist '("\\.ebpf\\'" . c-mode))
(require-package 'bpftrace-mode)


(provide 'init-misc)
;;; init-misc.el ends here
