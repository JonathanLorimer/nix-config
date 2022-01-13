;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;
(setq doom-theme 'doom-nord)
(setq doom-font (font-spec :family "PragmataProLiga Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "PragmataProLiga Nerd Font" :size 24))
(setq display-line-numbers-type t)
(load-file (let ((coding-system-for-read 'utf-8))
                 (shell-command-to-string "agda-mode locate")))
;;; config.el ends here
