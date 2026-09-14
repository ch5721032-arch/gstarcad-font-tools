;; font-usage.lsp - Count how many objects use each text style
;; Command: FONTUSAGE
(defun c:FONTUSAGE ( / tbl name ss n )
  (setq tbl (tblnext "STYLE" T))
  (while tbl
    (setq name (cdr (assoc 2 tbl))
          ss (ssget "_X" (list (cons 7 name)))
          n (if ss (sslength ss) 0))
    (princ (strcat "\n" name ": " (itoa n) " objects"))
    (setq tbl (tblnext "STYLE"))
  )
  (princ)
)
