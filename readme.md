## Soma RSS feed builder
This is an automatic RSS feed builder that I wrote for my [Jekyll](https://github.com/mojombo/jekyll/) powered site, [mozartreina.com](http://mozartreina.com). I've tried to make it as generic as possible but I didn't spend too much time working on making it **out-of-the-box** friendly. 

As of now it's been hard-coded in a way that it only works on physically present `.html` files, as I wrote it for me, so it won't work for on-the-fly generated pages, though it should be extremely easy to modify it so it does. The easiest option would be to use [Drakma](http://weitz.de/drakma/) or any other HTTP library to pull the generated page from the web instead of reading `.html` files.

The parsing (if you can call it that) is extremely simple as the information that is needed to create the RSS feed is not that complicated to extract. I felt it better to just write my own quick and dirty solution rather than take up time reading the API of a parsing library.