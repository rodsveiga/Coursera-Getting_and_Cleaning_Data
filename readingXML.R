library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]] ## We acess as list

rootNode[[1]][[1]] ## Subsetting to a smaller part of the document

## Programatically extract parts of the file
xmlSApply(rootNode, xmlValue) ## Look the xmlValue-function documentation

## XPath: a lot of information can be found. If you want to know more, look at
##        the reference given during the class

## Get the itens on the menu and prices
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

## Extract content by attibutes
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=TRUE) ## HTML document type
records <- xpathSApply(doc, "//li[@class='record']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)

