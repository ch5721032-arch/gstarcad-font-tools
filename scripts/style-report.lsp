;; style-report.lsp - List every text style with its font
;; Command: STYLEREPORT
(defun c:STYLEREPORT ( / tbl name f1 f2 h )
  (setq tbl (tblnext "STYLE" T))
  (while tbl
    (setq name (cdr (assoc 2 tbl))
          f1 (cdr (assoc 3 tbl))
          f2 (cdr (assoc 4 tbl))
          h  (cdr (assoc 40 tbl)))
    (princ (strcat "\n" name
                   " | font: " (if (= f1 "") "(none)" f1)
                   (if (and f2 (/= f2 "")) (strcat " | big font: " f2) "")
                   " | height: " (rtos (if h h 0.0) 2 2)))
    (setq tbl (tblnext "STYLE"))
  )
  (princ)
)
