##Soma RSS builder documentation
###create-entry *function*
*string -> string*

Accepts a string of rss entries in the format:

    <item>
    <title></title>
    <description></description>
    <link></link>
    </item>

returns the complete rss file feed layout.

Example:

    (create-entry '("<item><title>hello</title><description>i am hello</description><link>http://hello.com/hello.html</link></item>"))
    "<?xml version='1.0'?> 
                     <rss version='2.0'> 
                     <channel>  
                     <title>Math, Lisp, and general hackery</title>  
                     <description>On-going documentation of my studies and projects</description>  
                     <link>http://mozartreina.com</link>  
                     <item><title>hello</title><description>i am hello</description><link>http://hello.com/hello.html</link></item>
                     </channel>
                     </rss>"

###aggregate *function*
*string string -> string*

Accepts a directory and searches that directory for `.html` files which it then opens and passes its contents to the functions item-gen and parse-html to be parsed into rss entry format. Also accepts the toplevel path of where the pages are found on the web.

Example:

    (aggregate "/home/mo/dev/jekyll/mozartreina/_site" "http://mozartreina.com")

    ("<item> 
                   <title>   SLDB, or the Slime Debugger |  Mozart Reina  </title> 
                   <description> I've been using the <a href=\"http://common-lisp </description> 
                   <link> http://mozartreina.com/sldb-or-debugger.html </link> 
                   </item>"
     "<item> 
                   <title>   Setting up Jekyll |  Mozart Reina  </title> 
                   <description> For a while now I've been thinking of using <st </description> 
                   <link> http://mozartreina.com/setting-up-jekyll.html </link> 
                   </item>"
     "<item> 
                   <title>   Rolling my own RC4 Implementation |  Mozart Reina  </title> 
                   <description> RC4, or the \"Rivest Cipher\", named after its cr </description> 
                   <link> http://mozartreina.com/rolling-my-own-rc4-implementation.html </link> 
                   </item>"
     "<item> 
                   <title>   Mathematical Induction (aka Proof by Induction) |  Mozart Reina  </title> 
                   <description> Mathematical proofs are statements, either writ </description> 
                   <link> http://mozartreina.com/proofs.html </link> 
                   </item>"
     "<item> 
                   <title>   Mozart Reina  </title> 
                   <description> I've been using the <a href=\"http://common-lisp </description> 
                   <link> http://mozartreina.com/index.html </link> 
                   </item>"
     "<item> 
                   <title>   Functions |  Mozart Reina  </title> 
                   <description> Functins are nothing more than equations where  </description> 
                   <link> http://mozartreina.com/functions.html </link> 
                   </item>"
     "<item> 
                   <title>   Derivatives of Functions |  Mozart Reina  </title> 
                   <description> A derivative of a function, in plainspeak, is t </description> 
                   <link> http://mozartreina.com/derivatives-functions.html </link> 
                   </item>")

###parse-html *function*
*string string string -> string*

Accepts a main string to parse, and two strings that serve as the start and end point of the search. Returns whatever is between the start and end strings.
Example:

    (parse-html "where have all the cowboys gone?" "have" "gone")

    "have all the cowboys "

###item-gen *function*
*string string string string -> string*

Accepts the title, address, description, and path of the individual entry in the form of strings. Creates an RSS standard item.

Example:

    (item-gen "functions" "functions-derivatives.html" "functions, in plainspeak, are the basis of all forms of computer science" "http://mozartreina.com")
    "<item> 
                   <title> ns </title> 
                   <description> ctions, in plainspeak, are the basis of all for </description> 
                   <link> http://mozartreina.com/functions-derivatives.html.html </link> 
                   </item>"

###create-file *function*
*string -> file*

Accepts the completed RSS formatted data and writes it to a file called "feed.xml" on the main disk.
