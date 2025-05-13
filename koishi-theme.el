;;; koishi-theme.el --- A sweet dark theme for koishimacs  -*- lexical-binding: t -*-

;; Author: gynamics
;; Maintainer: gynamics
;; Package-Version: 0.1
;; Package-Requires: ( )
;; URL: https://github.com/gynamics/koishi-theme.el
;; Keywords: theme


;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.


;;; Commentary:

;; A simple dark-color theme based on green-yellow-purple colors.
;; This is the exclusive theme for Koishimacs (my Emacs config).
;; Inspired by Touhou Project's character Komeiji Koishi's color tone.

;;; Code:

;;;###theme-autoload
(deftheme koishi
  "A sweet dark theme for koishimacs."
  :family 'koishi
  :kind 'color-scheme
  :background-mode 'dark
  )

(custom-theme-set-faces
 'koishi
 ;; basic colors
 '(default                          ((t (:foreground "#F7F7F7" :background "#2D2D2D"))))
 '(cursor                           ((t (:background "#C6CC96"))))
 '(fixed-pitch                      ((t (:foreground "#F7E7D7"))))
 '(variable-pitch                   ((t (:foreground "#E7F7D7"))))
 '(escape-glyph                     ((t (:foreground "#CF88A8"))))
 '(homoglyph                        ((t (:foreground "#C76888"))))
 '(minibuffer-prompt                ((t (:foreground "#8E44AD" :background "#2D2D2D"))))
 '(region                           ((t (:extend t :background "#535456"))))
 '(highlight                        ((t (:background "#434962"))))
 '(shadow                           ((t (:foreground "#EBDB87"))))
 '(secondary-selection              ((t (:extend t :foreground "#F7E7D7" :background "#555555"))
                                     (t (:inverse-video t))))
 '(error                            ((t (:foreground "#F078B8"))))
 '(warning                          ((t (:foreground "#FBEB87"))))
 '(success                          ((t (:foreground "#7FFF76"))))
 ;; font locks
 '(font-lock-keyword-face           ((t (:foreground "#F7DC64"))))
 '(font-lock-builtin-face           ((t (:foreground "#A7CEEB"))))
 '(font-lock-bracket-face           ((t (:foreground "#A8B0A8"))))
 '(font-lock-operator-face          ((t (:foreground "#F7E7A7"))))
 '(font-lock-function-name-face     ((t (:foreground "#C5A8FB"))))
 '(font-lock-function-call-face     ((t (:foreground "#A7A8EA"))))
 '(font-lock-variable-name-face     ((t (:foreground "#87CEEB"))))
 '(font-lock-variable-use-face      ((t (:foreground "#94B8FB"))))
 '(font-lock-type-face              ((t (:foreground "#C2F03C"))))
 '(font-lock-string-face            ((t (:foreground "#B7DC9C"))))
 '(font-lock-constant-face          ((t (:foreground "#85D062"))))
 '(font-lock-number-face            ((t (:foreground "#C7DC3C"))))
 '(font-lock-comment-face           ((t (:foreground "#F7D7E7"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#DFA8CB"))))
 '(font-lock-doc-face               ((t (:foreground "#A7DCCB"))))
 '(font-lock-doc-markup-face        ((t (:foreground "#B57EDC"))))
 '(font-lock-escape-face            ((t (:foreground "#C5917F"))))
 '(font-lock-warning-face           ((t (:foreground "#FBEB87"))))
 '(font-lock-preprocessor-face      ((t (:inherit (font-lock-builtin-face)))))
 '(font-lock-property-name-face     ((t (:inherit (font-lock-variable-name-face)))))
 '(font-lock-property-use-face      ((t (:inherit (font-lock-property-name-face)))))
 '(font-lock-misc-punctuation-face  ((t (:inherit (font-lock-punctuation-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 ;; decorations
 '(underline                        ((t (:underline t))))
 '(link                             ((t (:inherit (underline) :foreground "#A1EFDF"))))
 '(link-visited                     ((t (:foreground "#B57EDC"))))
 '(fringe                           ((t (:background "#393346"))))
 '(header-line                      ((t (:underline (:color foreground-color :style line :position nil)
                                         :box nil :inverse-video nil :foreground "white" :background "black"))))
 '(tooltip                          ((t (:inherit (variable-pitch) :background "#343434"))))
 '(button                           ((t (:inherit (link)
                                         :box (:line-width 2 :color "#99DD66" :style released-button)))))
 '(line-number                      ((t (:foreground "#777777" :background "#222222"))))
 '(show-paren-match                 ((t (:foreground "#FFFFFF" :background "#8E44AD"))))
 '(mode-line                        ((t (:foreground "#FFFFFF" :background "#5C3F8E"))))
 '(mode-line-inactive               ((t (:foreground "#CCCCCC" :background "#4B3869"))))
 '(completions-common-part          ((t (:foreground "#F1C40F" :background "#343434"))))
 '(completions-first-difference     ((t (:foreground "#8BC34A" :background "#2D2D2D"))))
 ;; company
 '(company-tooltip                  ((t (:foreground "#FFFFFF" :background "#2D2D2D"))))
 '(company-tooltip-selection        ((t (:foreground "#8BC34A" :background "#6C497F"))))
 '(company-tooltip-common           ((t (:foreground "#F1C40F" :background "#343434"))))
 '(company-tooltip-common-selection ((t (:foreground "#CCFF99" :background "#7A5F9E"))))
 ;; isearch
 '(isearch                          ((t (:foreground "#FFFFFF" :background "#436224"))))
 '(isearch-fail                     ((t (:foreground "#FFFFFF" :background "#FF0033"))))
 '(match                            ((t (:foreground "#FFFFFF" :background "#8E44AD"))))
 '(next-error                       ((t (:foreground "#FFFFFF" :background "#E74CAC"))))
 '(query-replace                    ((t (:foreground "#FFFFFF" :background "#256225"))))
 ;; org-mode
 '(org-document-title               ((t (:foreground "#AEEEEE" :weight bold :height 1.5))))
 '(org-document-info                ((t (:foreground "#A1CEBE"))))
 '(org-level-1                      ((t (:foreground "#C7B8EA" :weight bold :height 1.25))))
 '(org-level-2                      ((t (:foreground "#A7DCCB" :weight bold :height 1.2))))
 '(org-level-3                      ((t (:foreground "#97CEEB" :weight bold :height 1.15))))
 '(org-level-4                      ((t (:foreground "#C7DC3C" :weight bold :height 1.1))))
 '(org-level-5                      ((t (:foreground "#F1C40F" :weight bold :height 1.0))))
 '(org-tag                          ((t (:foreground "#F7DC64"))))
 '(org-link                         ((t (:foreground "#AAF0CC" :underline t))))
 '(org-date                         ((t (:foreground "#8CE5DB" :underline t))))
 '(org-footnote                     ((t (:foreground "#7CD5EB"))))
 '(org-done                         ((t (:foreground "#8BC34A" :strike-through t))))
 '(org-todo                         ((t (:foreground "#FBEB87" :weight bold))))
 '(org-headline-done                ((t (:foreground "#90A0B0"))))
 '(org-block                        ((t (:foreground "#F7F7F7" :background "#343434"))))
 '(org-block-begin-line             ((t (:foreground "#C7B8EA" :weight bold))))
 '(org-block-end-line               ((t (:foreground "#C7B8EA" :weight bold))))
 '(org-quote                        ((t (:foreground "#F2C464" :slant italic))))
 '(org-verse                        ((t (:foreground "#F2C464" :slant italic))))
 '(org-code                         ((t (:foreground "#B7DC9C" :background "#343434"))))
 '(org-latex-and-related            ((t (:foreground "#D7E7F7"))))
 '(org-special-keyword              ((t (:foreground "#C7B8EA"))))
 '(org-meta-line                    ((t (:foreground "#F7D7E7"))))
 '(org-priority                     ((t (:foreground "#E3A9B5"))))
 '(org-checkbox                     ((t (:foreground "#E2C464" :box (:line-width 1 :style released-button)))))
 '(org-checkbox-statistics-todo     ((t (:foreground "#FBEB87" :box (:line-width 1 :style released-button)))))
 '(org-checkbox-statistics-done     ((t (:foreground "#8BC34A" :box (:line-width 1 :style released-button)))))
 '(org-list-dt                      ((t (:foreground "#C0C0E1"))))
 )

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'koishi)

;;; koishi-theme.el ends here
