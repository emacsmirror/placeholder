;;; placeholder.el --- Easy insertion and filling of placeholders in text  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Omar Antolín Camarena

;; Author: Omar Antolín Camarena <omar@matem.unam.mx>
;; Keywords: files

;; This program is free software; you can redistribute it and/or modify
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

;; 

;;; Code:

(defcustom placeholder-string "<++>"
  "Placeholder string. Pick a string unlikely to appear in your buffers."
  :type 'string
  :group 'placeholder)

(defun placeholder-insert ()
  "Insert the placeholder-string in the current buffer."
  (interactive)
  (insert placeholder-string))

(defun placeholder-forward (count)
  "Delete the next COUNTth occurrence of the placeholder string,
leaving point there ready for insertion. If called again
immediately after, it will restore that occurence of the
placeholder and move to the next."
  (interactive "p")
  (let ((n (length placeholder-string )))
    (when (eq last-command 'placeholder)
      (insert placeholder-string)
      (when (< count 0) (backward-char n)))
    (search-forward placeholder-string nil nil count)
    (delete-char (if (> count 0) (- n) n))
    (setq this-command 'placeholder)))

(defun placeholder-backward (count)
  "Delete the previous COUNTth occurrence of the placeholder string,
leaving point there ready for insertion. If called again
immediately after, it will restore that occurence of the
placeholder and move to the previous."
  (interactive "p")
  (placeholder-forward (- count)))

(provide 'placeholder)
;;; placeholder.el ends here
