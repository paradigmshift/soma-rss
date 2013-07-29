;;;; soma-rss.asd

(asdf:defsystem #:soma-rss
  :serial t
  :description "Creates an RSS feed for Jekyll-powered sites"
  :author "Mozart Reina <mozart@mozartreina.com"
  :license "FreeBSD License"
  :components ((:file "package")
               (:file "soma-core")))
