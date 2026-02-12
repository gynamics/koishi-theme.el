;;; koishi-theme.el --- A sweet theme inspired by Koishi's color tone  -*- lexical-binding: t -*-

;; Author: gynamics
;; Maintainer: gynamics
;; Package-Version: 3.0
;; Package-Requires: ((emacs "24.1"))
;; URL: https://github.com/gynamics/koishi-theme.el
;; Keywords: faces


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

;; A simple color theme based on green-yellow-purple colors.
;; This is the official theme for Koishimacs (my Emacs config).
;; Inspired by Touhou Project's character Komeiji Koishi's color tone.

;;; Code:


(require 'color)

;;;###theme-autoload
(deftheme koishi
  "A sweet dark theme for koishimacs."
  :family 'koishi
  :kind 'color-scheme)

;;;###autoload
(defcustom koishi-theme-mode 'nil
  "Set this variable to t to use complementary color."
  :type '(choice (const :tag "Dark" nil)
                 (const :tag "Light" t))
  :group 'koishi)

(defun koishi-theme-effect--complement (color)
  "Complement COLOR if `koishi-theme-mode' is set.
COLOR should be an RGB color string."
  (if koishi-theme-mode (color-complement-hex color) color))

;;;###autoload
(defcustom koishi-theme-afterglow-color nil
  "Experimental Feature: RGB Color of afterglow for all initial colors."
  :type '(string :tag "Afterglow Color"
                 :match (lambda (_ val) (not (null (color-name-to-rgb val))))
                 :type-error "Afterglow color should be a RGB color string.")
  :group 'koishi)

;;;###autoload
(defcustom koishi-theme-afterglow-level 0
  "Experimental Feature: Blend degree of afterglow for all initial colors."
  :type '(number :tag "Afterglow Level"
                 :match (lambda (_ val) (and val (<= 0 val) (>= 1 val)))
                 :type-error "Afterglow level should between 0 and 1.")
  :group 'koishi)

(defun koishi-theme-effect--afterglow (color)
  "Blend COLOR with layers in `koishi-theme-afterglow-level'."
  (if (and koishi-theme-afterglow-color
           (< 0 koishi-theme-afterglow-level))
      (let ((rgb (color-name-to-rgb color))
            (rgb1 (color-name-to-rgb koishi-theme-afterglow-color)))
        (apply
         #'color-rgb-to-hex
         (mapcar (lambda (n)
                   (let ((p koishi-theme-afterglow-level)
                         (c (nth n rgb)))
                     (let ((res (+ (* p (- (nth n rgb1) c))
                                   (* (- 1 p) c))))
                       (cond ((< 1 res) 1) ((< res 0) 0) (t res)))))
                 '(0 1 2))))
    color))

;;;###autoload
(defcustom koishi-theme-hsl-bias '(0 0 0)
  "Experimental Feature: HSL bias value for all initial colors."
  :type '(list
          (number :tag "Hue"
                  :match (lambda (_ val) (and val (<= -1 val) (>= 1 val)))
                  :type-error "Hue should between -1 and 1.")
          (number :tag "Saturation"
                  :match (lambda (_ val) (and val (<= -1 val) (>= 1 val)))
                  :type-error "Saturation should between -1 and 1.")
          (number :tag "Luminance"
                  :match (lambda (_ val) (and val (<= -1 val) (>= 1 val)))
                  :type-error "Luminance should between -1 and 1."))
  :group 'koishi)

;;;###autoload
(defcustom koishi-theme-hsl-bias-random 0
  "Experimental Feature: Random range of HSL bias for all initial colors."
  :type '(number :tag "Random Range"
                 :match (lambda (_ val) (and val (<= 0 val) (>= 1 val)))
                 :type-error "Random range should between 0 and 1.")
  :group 'koishi)

(defun koishi-theme-effect--hsl-bias (color)
  "Bias COLOR in HSL space."
  (if (and (equal koishi-theme-hsl-bias '(0 0 0))
           (= 0 koishi-theme-hsl-bias-random))
      color
    (let ((hsl (apply #'color-rgb-to-hsl (color-name-to-rgb color))))
      (apply
       #'color-rgb-to-hex
       (apply
        #'color-hsl-to-rgb
        (let ((bias (if (< 0 koishi-theme-hsl-bias-random)
                        (mapcar (lambda (v)
                                  (let ((d (* v koishi-theme-hsl-bias-random)))
                                    (+ v (- (/ d 2) (random d)))))
                                koishi-theme-hsl-bias)
                      koishi-theme-hsl-bias)))
          (mapcar (lambda (n)
                    (let ((res (+ (nth n hsl) (nth n bias))))
                      (cond ((< 1 res) 1) ((< res 0) 0) (t res))))
                  '(0 1 2))))))))

;;;###autoload
(defcustom koishi-theme-effects '(koishi-theme-effect--complement
                                  koishi-theme-effect--hsl-bias
                                  koishi-theme-effect--afterglow)
  "A list of effects to be applied to RGB color strings one by one.
Set this variable to nil if you think it slowed down your startup."
  :type '(repeat function)
  :group 'koishi)

(defun koishi-theme-apply-effects (sexp)
  "Apply color effects to all RGB color strings in SEXP and replace them."
  (cond
   ((and (stringp sexp)
         (string-match "^#\\([0-9A-Fa-f]\\{3\\}\\)\\{1,2\\}$" sexp))
    (let ((res sexp))
      (dolist (f koishi-theme-effects)
        (setq res (funcall f res)))
      res))
   ((listp sexp)
    (mapcar #'koishi-theme-apply-effects sexp))
   (t sexp)))

(defvar koishi-theme-term-face-names
  '(term-color-black
    term-color-red
    term-color-green
    term-color-yellow
    term-color-blue
    term-color-magenta
    term-color-cyan
    term-color-white
    term-color-bright-black
    term-color-bright-red
    term-color-bright-green
    term-color-bright-yellow
    term-color-bright-blue
    term-color-bright-magenta
    term-color-bright-cyan
    term-color-bright-white)
  "Face names for terminal, defined in term.el .")

(defcustom koishi-theme-term-colors
  '("#2d2d2d" "#e9b9c9" "#b9e9b9" "#e9e9b9" "#b9d9f9" "#c9b9e9" "#b9f9e9" "#f9f9f9"
    "#5d5d5d" "#f97969" "#79f979" "#f9d979" "#7999f9" "#8979f9" "#79f9e9" "#ffffff")
  "Colors for building term faces, it must has 16 elements.
The mapping order is determined by `koishi-theme-term-face-names'."
  :type '(repeat (string :tag "RGB color hex string"
                         :match (lambda (_ val) (not (null (color-name-to-rgb val))))))
  :group 'koishi)

(defun koishi-theme-term-faces ()
  "Generate a list of term faces."
  (let ((res))
    (dotimes (i (length koishi-theme-term-face-names))
      (let ((name (nth i koishi-theme-term-face-names))
            (color (or (nth i koishi-theme-term-colors)
                       (nth i (default-value koishi-theme-term-colors)))))
        (when color
          (push `(,name ((t (:foreground ,color :background ,color)))) res))))
    (nreverse res)))

(defvar koishi-theme-faces
  `(;; terminal colors
    ,@(koishi-theme-term-faces)
    ;; basic colors
    (default                          ((t (:foreground "#F7F7F7" :background "#2D2D2D"))))
    (cursor                           ((t (:background "#C6CC96"))))
    (fixed-pitch                      ((t (:foreground "#F7E7D7"))))
    (variable-pitch                   ((t (:foreground "#E7F7D7"))))
    (escape-glyph                     ((t (:foreground "#CF88A8"))))
    (homoglyph                        ((t (:foreground "#C76888"))))
    (minibuffer-prompt                ((t (:foreground "#8E44AD" :background "#2D2D2D"))))
    (region                           ((t (:extend t :background "#535456"))))
    (highlight                        ((t (:background "#434962"))))
    (shadow                           ((t (:foreground "#97AAB6"))))
    (secondary-selection              ((t (:extend t :foreground "#F7E7D7" :background "#555555"))
                                       (t (:inverse-video t))))
    (error                            ((t (:foreground "#F078B8"))))
    (warning                          ((t (:foreground "#FBEB87"))))
    (success                          ((t (:foreground "#7FFF76"))))
    ;; font locks
    (font-lock-keyword-face           ((t (:foreground "#F7DC64"))))
    (font-lock-builtin-face           ((t (:foreground "#A7C7EB"))))
    (font-lock-operator-face          ((t (:foreground "#F7E7A7"))))
    (font-lock-function-name-face     ((t (:foreground "#C5A8FB"))))
    (font-lock-function-call-face     ((t (:foreground "#E5C8FB"))))
    (font-lock-variable-name-face     ((t (:foreground "#97BEEB"))))
    (font-lock-variable-use-face      ((t (:foreground "#C7CEEB"))))
    (font-lock-property-name-face     ((t (:foreground "#95C062"))))
    (font-lock-property-use-face      ((t (:foreground "#C5C89B"))))
    (font-lock-preprocessor-face      ((t (:foreground "#E989EB"))))
    (font-lock-constant-face          ((t (:foreground "#DFA175"))))
    (font-lock-type-face              ((t (:foreground "#C2F03C"))))
    (font-lock-string-face            ((t (:foreground "#B7DC8C"))))
    (font-lock-number-face            ((t (:foreground "#E5C8BB"))))
    (font-lock-comment-face           ((t (:foreground "#F7D7E7"))))
    (font-lock-comment-delimiter-face ((t (:foreground "#DFA8CB"))))
    (font-lock-doc-face               ((t (:foreground "#97CCCB"))))
    (font-lock-doc-markup-face        ((t (:foreground "#97DC9B"))))
    (font-lock-escape-face            ((t (:foreground "#C5918F"))))
    (font-lock-warning-face           ((t (:foreground "#FBEB87"))))
    (font-lock-punctuation-face       ((t (:foreground "#E7C787"))))
    (font-lock-misc-punctuation-face  ((t (:foreground "#E7D7B7"))))
    (font-lock-bracket-face           ((t (:foreground "#CCACC8"))))
    (font-lock-delimiter-face         ((t (:foreground "#CCBCCB"))))
    (font-lock-regexp-grouping-backslash ((t (:foreground "#EBD7B7"))))
    (font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
    ;; decorations
    (underline                        ((t (:underline t))))
    (link                             ((t (:inherit (underline) :foreground "#A1EFDF"))))
    (link-visited                     ((t (:foreground "#B57EDC"))))
    (fringe                           ((t (:background "#393346"))))
    (header-line                      ((t (:underline (:color foreground-color :style line :position nil)
                                           :box nil :inverse-video nil :foreground "white" :background "black"))))
    (tooltip                          ((t (:inherit (variable-pitch) :background "#343434"))))
    (button                           ((t (:inherit (link) :box (:line-width 2 :color "#99DD66" :style released-button)))))
    (line-number                      ((t (:foreground "#7787A7" :background "#222222"))))
    (show-paren-match                 ((t (:foreground "#FFFFFF" :background "#8E44AD"))))
    (mode-line                        ((t (:foreground "#FFFFFF" :background "#5C3F8E"))))
    (mode-line-inactive               ((t (:foreground "#CCCCCC" :background "#3B3869"))))
    (mode-line-emphasis               ((t (:foreground "#FBEB87" :weight bold))))
    (mode-line-highlight              ((t (:inherit (button) :foreground "#CCFF99" :background "#5C4F8E"))))
    (completions-common-part          ((t (:foreground "#F1C40F" :background "#343434"))))
    (completions-first-difference     ((t (:foreground "#8BC34A" :background "#2D2D2D"))))
    (completions-annotations          ((t (:inherit (italic) :foreground "#EBDB87"))))
    ;; company
    (company-tooltip                  ((t (:foreground "#FFFFFF" :background "#2D2D2D"))))
    (company-tooltip-selection        ((t (:foreground "#8BC34A" :background "#6C497F"))))
    (company-tooltip-common           ((t (:foreground "#F1C40F" :background "#343434"))))
    (company-tooltip-common-selection ((t (:foreground "#CCFF99" :background "#7A5F9E"))))
    ;; isearch
    (isearch                          ((t (:foreground "#FFFFFF" :background "#436224"))))
    (isearch-fail                     ((t (:foreground "#FFFFFF" :background "#FF0033"))))
    (match                            ((t (:foreground "#FFFFFF" :background "#8E44AD"))))
    (next-error                       ((t (:foreground "#FFFFFF" :background "#E74CAC"))))
    (query-replace                    ((t (:foreground "#FFFFFF" :background "#256225"))))
    ;; org-mode
    (org-document-title               ((t (:foreground "#AEEEEE"))))
    (org-document-info                ((t (:foreground "#A1CEBE"))))
    (org-level-1                      ((t (:foreground "#C7B8EA"))))
    (org-level-2                      ((t (:foreground "#A7DCCB"))))
    (org-level-3                      ((t (:foreground "#97CEEB"))))
    (org-level-4                      ((t (:foreground "#C7DC3C"))))
    (org-level-5                      ((t (:foreground "#F1C40F"))))
    (org-tag                          ((t (:foreground "#E7C7E7" :box (:line-width 1 :style released-button)))))
    (org-link                         ((t (:foreground "#AAF0CC" :underline t))))
    (org-date                         ((t (:foreground "#8CE5DB" :underline t))))
    (org-footnote                     ((t (:foreground "#7CD5EB"))))
    (org-done                         ((t (:foreground "#8BC34A" :strike-through t))))
    (org-todo                         ((t (:foreground "#FBEB87" :weight bold))))
    (org-headline-done                ((t (:foreground "#90A0B0"))))
    (org-block                        ((t (:foreground "#F7F7F7" :background "#222224"))))
    (org-block-begin-line             ((t (:foreground "#A7A8EA" :underline t :extend t))))
    (org-block-end-line               ((t (:foreground "#A7A8EA" :overline t :extend t))))
    (org-quote                        ((t (:foreground "#F2C464" :slant italic))))
    (org-verse                        ((t (:foreground "#F7DC64" :slant italic))))
    (org-code                         ((t (:foreground "#B7DC9C" :background "#28282A"))))
    (org-latex-and-related            ((t (:foreground "#D7E7F7"))))
    (org-special-keyword              ((t (:foreground "#C7B8EA"))))
    (org-meta-line                    ((t (:foreground "#F7D7E7"))))
    (org-priority                     ((t (:foreground "#E3A9B5"))))
    (org-checkbox                     ((t (:foreground "#E2C464" :box (:line-width 1 :style released-button)))))
    (org-checkbox-statistics-todo     ((t (:foreground "#FBEB87" :box (:line-width 1 :style released-button)))))
    (org-checkbox-statistics-done     ((t (:foreground "#8BC34A" :box (:line-width 1 :style released-button)))))
    (org-list-dt                      ((t (:foreground "#C0C0E1")))))
  "Default faces for koishi-theme, defined as data.")

;; define koishi-theme here
(apply #'custom-theme-set-faces
       (cons 'koishi
             (if koishi-theme-effects
                 (koishi-theme-apply-effects koishi-theme-faces)
               koishi-theme-faces)))

;;;###autoload
(defun koishi-theme-reset-faces ()
  "A wrapper to reset koishi-theme after it is loaded.
This is achieved by calling `custom-set-faces'."
  (interactive)
  (apply #'custom-set-faces
         (if koishi-theme-effects
             (koishi-theme-apply-effects koishi-theme-faces)
           koishi-theme-faces)))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'koishi)

;;; koishi-theme.el ends here
