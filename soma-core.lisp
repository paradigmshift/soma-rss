(defun create-entry (items)
  (let ((out (format nil "<?xml version='1.0'?> ~%
                 <rss version='2.0'> ~%
                 <channel>  ~%
                 <title>Math, Lisp, and general hackery</title>  ~%
                 <description>On-going documentation of my studies and projects</description>  ~%
                 <link>http://mozartreina.com</link>  ~%
                 ~a
                 </channel>
                 </rss>" items)))
    out))

(defun aggregate (dir)
  (let ((entries (directory (concatenate 'string dir "/*.html"))))
    (mapcar (lambda(x)
              (with-open-file (stream x
                                      :direction :input)
                (let ((data (make-string (file-length stream))))
                  (read-sequence data stream)
                  data)))
            entries)))
          
