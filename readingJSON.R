library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData) ## Returns a data-frame

names(jsonData$owner) ## A particular colunn the the jsonData dataframe
                      ## A bunch of informatiom: an array

jsonData$owner$login ## Go further: the login for everhy single repo

## Writing data frames to JSON
myjson <- toJSON(iris, pretty = TRUE)  ## Nice when we're exporting data
cat(myjson) ## cat() : not a data-frame

## Convert back to JSON
iris2 <- fromJSON(myjson)
head(iris2)