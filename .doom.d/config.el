;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Terminess Nerd Font Mono" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Terminess Nerd Font Propo" :size 21)
      doom-symbol-font (font-spec :family "Symbols Nerd Font" :size 20))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; TASKS
(defun krishang/daily-task-file ()
  "Create or open today's daily org file with predefined headings."
  (interactive)
  (let* ((date (format-time-string "%Y-%m-%d"))
         (datetime (format-time-string "%A, %B %e  %H:%M")) ;; e.g., "Friday, April 18  14:52"
         (filename (expand-file-name (concat date ".org") "~/Documents/org/daily/")) ;; change this if needed
         (content (concat "#+TITLE: " date "\n"
                          "#+AUTHOR: Krishang\n"
                          "#+DESCRIPTION: " datetime "\n\n"
                          "* Physics\n\n"
                          "* Chemistry\n\n"
                          "* Math\n\n"
                          "* Life\n")))
    (unless (file-exists-p filename)
      (make-directory (file-name-directory filename) t)
      (with-temp-file filename
        (insert content)))
    (find-file filename)))

;; Doom uses general.el, so bind the key using `map!`
(map! :leader
      :desc "Open/Create daily org file"
      "o d" #'krishang/daily-task-file)

(map! :after org
      :map org-mode-map
      :leader
      :desc "Open habit stats view"
      "o h" #'org-habit-stats-view-habit-at-point)

(map! :leader
      :desc "Open JEE Checklist file"
      "o j" (lambda () (interactive) (find-file "~/Documents/org/jee_checklist.org")))

;; Automatically add CLOSED timestamp when marking TODO as DONE
(setq org-log-done 'time)
