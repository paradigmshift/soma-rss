;;;; usage : (create-file (create-entry (aggregate [dir with .html files] [http path of .html files])))
;;;; ex.
;;;;   (create-file (create-entry (aggregate "~/dev/http"
;;;; "http://www.foo.com/posts")))

(in-package #:soma-rss)

(defun create-entry (items)
  "Creates the .xml feed file with the entries that are passed to it"
  (let ((out (format nil "<?xml version='1.0'?>
                 <rss version='2.0'>
                 <channel> 
                 <title>Math, Lisp, and general hackery</title> 
                 <description>On-going documentation of my studies and projects</description> 
                 <link>http://mozartreina.com</link> 
                 ~{~a~}
                 </channel>
                 </rss>" items)))
    out))

(defun aggregate (dir path)
  "Searches dir for .html files and creates entries from those files, path is the base site url where the entries are found"
  (let ((entries (directory (concatenate 'string dir "/*.html")))
        (parsed-data '()))
    (mapcar (lambda (x)
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
  "extract string between beg and end"
  (subseq str (search beg str) (search end str)))

(defun item-gen (title address dscrp path)
  "creates the individual RSS entry"
  (let ((dscrp (remove-quote dscrp)))
    (format nil "<item>
               <title> ~a </title>
               <description> ~a </description>
               <link> ~a/~a.html </link>
               </item>" (subseq title 7) (subseq dscrp 3 50) path address)))

(defun create-file (data)
  "data is the xml structure created from parsing .html files"
  (with-open-file (stream "feed.xml"
                          :direction :output
                          :if-exists :supersede)
    (format stream "~a" data)))

(defun remove-quote (str)
  "Removes \", \< and \> from the string"
  (let ((q (search "\"" str))
        (tag-beg (search "\<" str))
        (tag-end (search "\>" str)))
    (cond (q (progn (setf (char str q) #\space) 
                    (remove-quote str)))
          (tag-beg (progn (setf (char str tag-beg) #\space)
                          (remove-quote str)))
          (tag-end (progn (setf (char str tag-end) #\space)
                          (remove-quote str)))
          (t str))))
    

(defun run-from-shell ()
  (create-file (create-entry (aggregate (nth 1 sb-ext:*posix-argv*) (nth 2 sb-ext:*posix-argv*)))))
