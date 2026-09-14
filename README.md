# GstarCAD Font Tools

List every text style with its font, create new styles in one command and see how many objects use each style.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Text styles and fonts are where drawings quietly break between offices. These utilities list every style with its font files and height, create a new style from a name and font file in one command, and count how many objects use each style before you touch anything.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/style-report.lsp` | ;; style-report.lsp - List every text style with its font
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
 |
| `scripts/style-new.lsp` | ;; style-new.lsp - Create a text style in one command
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
 |
| `scripts/font-usage.lsp` | ;; font-usage.lsp - Count how many objects use each text style
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
