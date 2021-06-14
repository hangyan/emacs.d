;;; init-golang.el --- Support for the golang language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'go-mode)
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(provide 'init-golang)
;;; init-rust.el ends here
