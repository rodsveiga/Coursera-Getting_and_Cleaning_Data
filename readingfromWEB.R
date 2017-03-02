## Getting data off webpages - readLines()
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
## Above we opened a connection. 
htmlCode = readLines(con)
close(con)
## The htmlCode is unformatted. Hard to read.
htmlCode

## Parsing with XML.
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
## Parse the HTML using the InternalNodes to het the complete structure out.
html <- htmlTreeParse(url, useInternalNodes = T)
## Looking for the title of the page.
xpathSApply(html, "//title", xmlValue)
## The number of times the papers were cited by looking at particular
## table elements of that table.
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

## GET from the httr package.
library(httr)
## Get the URL.
html2 = GET(url)
## Extract the content from the HTML page (here as a text: just one big text string).
content2 = content(html2, as="text")
## Parsing out that text: get the parsed HTML. It is going to look exactly the
## same if we had used the XML pacjage directly.
parsedHtml = htmlParse(content2, asText = TRUE)
## Extracting out the title.
xpathSApply(parsedHtml, "//title", xmlValue)

## Accessing websites with passwords.
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
## Status 401: we do not have acess to the file.
pg1
## With the HTTR package you can authenticate yourself.
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
## Status 200: we have acess to the file.
pg2
## Acess to the data.
names(pg2)
## Then we can use the content funcion, htmlParse and so on.

## Using handles.
google = handle("http://google.com")
## For example, if you authenticate this handle one time, then the cookies will
## stay with that handle and you'll be authenticated.
pg1 = GET(handle = google, path = "/")
pg2 = GET(handle = google, path = "search")
## You will not have to keep authenticating over and over again as you
## acess that website.