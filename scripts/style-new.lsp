;; style-new.lsp - Create a text style in one command
;; Command: STYLENEW
;; Usage: name the style and the font file (e.g. txt.shx or Arial.ttf)
(defun c:STYLENEW ( / name font )
  (setq name (getstring T "\nStyle name: "))
  (setq font (getstring T "\nFont file (e.g. txt.shx): "))
  (if (and (/= name "") (/= font ""))
    (progn
      (command "_.-STYLE" name font "" "" "" "" "")
      (princ (strcat "\nStyle created: " name))
    )
  )
  (princ)
)
