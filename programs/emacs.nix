{ pkgs }:

{
  enable = true;
  package = pkgs.emacs-nox;

  extraPackages = epkgs: with epkgs; [
    # Vim bindings
    evil

    # Direnv integration (buffer-local environments for per-project tools)
    envrc

    # QoL for beginners
    which-key      # Shows available keybindings
    company        # Autocompletion
    vertico        # Better minibuffer completion
    marginalia     # Annotations for completions
    doom-modeline  # Clean status bar

    # Git gutter annotations (lightweight, no magit needed)
    diff-hl
  ];

  extraConfig = ''
    ;; Disable startup screens/messages
    (setq inhibit-startup-screen t)
    (setq inhibit-startup-message t)
    (setq inhibit-startup-echo-area-message t)
    (setq initial-scratch-message nil)
    (setq initial-buffer-choice nil)

    ;; Hide UI chrome
    (menu-bar-mode -1)

    ;; Theme - modus-vivendi (dark, built-in, accessible, wide package support)
    (load-theme 'modus-vivendi t)

    ;; Doom modeline (uses text fallbacks in terminal)
    (require 'doom-modeline)
    (setq doom-modeline-icon t)
    (setq doom-modeline-major-mode-icon t)
    (doom-modeline-mode 1)

    ;; Evil mode (vim bindings)
    (require 'evil)
    (evil-mode 1)

    ;; Envrc (buffer-local direnv integration)
    (require 'envrc)
    (envrc-global-mode)

    ;; Diff-hl (git gutter - lightweight, works without magit)
    (require 'diff-hl)
    (global-diff-hl-mode)
    (diff-hl-flydiff-mode)

    ;; Agda info window at top instead of bottom
    (setq display-buffer-alist
      '(("\\*Agda information\\*"
         (display-buffer-reuse-window display-buffer-in-side-window)
         (side . top)
         (slot . 0)
         (window-height . 0.25))))

    ;; Agda mode - loaded dynamically from project's PATH via direnv
    (defun my/load-agda-mode ()
      "Load agda-mode from the agda-mode executable in PATH."
      (interactive)
      (let ((agda-mode-path (shell-command-to-string "agda-mode locate")))
        (when (and agda-mode-path (not (string-empty-p agda-mode-path)))
          (load-file (string-trim agda-mode-path)))))

    ;; Auto-load agda-mode for .agda files
    (add-to-list 'auto-mode-alist '("\\.agda\\'" . (lambda ()
      (my/load-agda-mode)
      (agda2-mode))))
    (add-to-list 'auto-mode-alist '("\\.lagda.md\\'" . (lambda ()
      (my/load-agda-mode)
      (agda2-mode))))

    ;; Agda customization (after agda2-mode loads)
    (with-eval-after-load 'agda2-mode
      ;; Evil keybinding for go-to-definition
      (evil-define-key 'normal agda2-mode-map (kbd "gd") 'agda2-goto-definition-keyboard))

    ;; Which-key (shows available keybindings)
    (require 'which-key)
    (which-key-mode)
    (setq which-key-idle-delay 0.5)

    ;; Company (autocompletion)
    (require 'company)
    (global-company-mode)
    (setq company-idle-delay 0.2)
    (setq company-minimum-prefix-length 2)

    ;; Vertico (better minibuffer completion)
    (require 'vertico)
    (vertico-mode)

    ;; Marginalia (annotations for completions)
    (require 'marginalia)
    (marginalia-mode)

    ;; Basic conveniences
    (global-display-line-numbers-mode 1)
    (electric-pair-mode 1)
    (show-paren-mode 1)
    (setq-default indent-tabs-mode nil)
    (setq make-backup-files nil)
    (setq auto-save-default nil)
  '';
}
