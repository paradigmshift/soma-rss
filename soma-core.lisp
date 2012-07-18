;;;; usage : (create-file (create-entry (aggregate [dir with .html files] [http path of .html files])))
;;;; ex.
;;;;   (create-file (create-entry (aggregate "~/dev/http" "http://www.foo.com/posts")))

(defun create-entry (items)
  (let ((out (format nil "<?xml version='1.0'?> ~%
                 <rss version='2.0'> ~%
                 <channel>  ~%
                 <title>Math, Lisp, and general hackery</title>  ~%
                 <description>On-going documentation of my studies and projects</description>  ~%
                 <link>http://mozartreina.com</link>  ~%
                 ~{~a~}
                 </channel>
                 </rss>" items)))
    out))

(defun aggregate (dir path)
  (let ((entries (directory (concatenate 'string dir "/*.html")))
        (parsed-data '()))
    (mapcar (lambda(x)
              (with-open-file (stream x
                                      :direction :input)
                (let ((data (make-string (file-length stream))))
                  (read-sequence data stream)
                  (push (item-gen (parse-html data "<title>" "</title>")
                                  (pathname-name x)
                                  (parse-html data "<p>" "</p>")
                                  path)
                        parsed-data))))
            entries)
    parsed-data))

          
(defun parse-html (str beg end)
  (subseq str (search beg str) (search end str)))

(defun item-gen (title address dscrp path)
  (format nil "<item> ~%
               <title> ~a </title> ~%
               <description> ~a </description> ~%
               <link> ~a/~a.html </link> ~%
               </item> ~%" (subseq title 7) (subseq dscrp 3 50) path address))

(defun create-file (data)
  (with-open-file (stream "feed.xml"
                          :direction :output
                          :if-exists :supersede)
    (format stream "~a" data)))

(defun run-from-shell ()
  (create-file (create-entry (aggregate (nth 1 *posix-argv*) (nth 2 *posix-argv*)))))
