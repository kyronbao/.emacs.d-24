;;; try-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "try" "try.el" (22780 50559 773591 815000))
;;; Generated autoloads from try.el

(autoload 'try-and-refresh "try" "\
Refreshes package-list before calling `try'.

\(fn)" t nil)

(autoload 'try "try" "\
Try out a package from your `package-archives' or pass a URL
to a raw .el file. Packages are stored in `try-tmp-dir' and raw
.el files are not stored at all.

\(fn &optional URL-OR-PACKAGE)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; try-autoloads.el ends here
