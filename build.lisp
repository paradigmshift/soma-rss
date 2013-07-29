;;;; Build script
(ql:quickload "soma-rss")

(in-package #:soma-rss)

(sb-ext:save-lisp-and-die "soma-rss" :executable t :toplevel #'run-from-shell)

