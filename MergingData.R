##################### MERGING DATA ##################### 

# Sometimes we will load in more than one dataset into R and we'll want
# to be able to merge the datasets together. And usually what we'll want to
# do is match those datasets based on an ID. This is very similar to the
# idea of having a linked set of tables and a database like MySQL.

## PEER REVIEW DATA
# This is data we're going to use in this class.
library(curl)
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile = "./data/reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "./data/solutions.csv", method = "curl")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

## MERGING DATA - merge()
# - Merging data frames
# - Important parameters: x, y, by, by.x, by.y, all
# x, y: two data frames
# by, by.x, by.y: tell a merge which of the coluns it should merge by.
names(reviews)
# By default it merges by all of the columns that have the common name (even if
# those variables might not necessarily mean the same thing).
names(solutions)
# In the example , we merge reviews based on solution_id and solutions based on
# id. The all = TRUE means that if there's a value that appears in one, but not
# in the other, it should include another row, but with NA values for the missing
# values that do not appear in the other data frame.
mergedData <- merge(reviews, solutions, by.x="solution_id", by.y="id", all = TRUE)
head(mergedData)

## DEFAULT - MERGE ALL COMMOM COLUMN NAMES
intersect(names(solutions), names(reviews))
# Without by.x, by.y, etc, it will try to merge on the intersection variables.
mergedData2 <- merge(reviews, solutions, all = TRUE)
# Not necessarily all the variables can match between the two data sets. Then it
# can create a larger data frame with multiple rows for each observable. For each 
# observable, one row of reviews and one row of solutions.
head(mergedData2)

## USING JOIN IN THE PLYR PACKAGE
# Faster than merge, but less full featured - defaults to left join, see help file.
library(plyr)
df1 <- data.frame(id = sample(1:10), x = rnorm(10))
df2 <- data.frame(id = sample(1:10), y = rnorm(10))
# Note it can merge only on the basis of common names between the two datasets.
join(df1, df2)
# Arrange. just to arrange in a id increasing order.
arrange(join(df1, df2), id)

## IF YOU HAVE MULTIPLE DATA FRAMES
# The nice thing about plyr package, and the reason why it was brought here, is 
# that if you have multiple data frames it is relatively challenging to do it the 
# merge command. But if they have a common id it is straightforward to do it with
# the join all command.
df1 <- data.frame(id = sample(1:10), x = rnorm(10))
df2 <- data.frame(id = sample(1:10), y = rnorm(10))
df3 <- data.frame(id = sample(1:10), z = rnorm(10))
# One big data list of data frames.
dfList <- list(df1, df2, df3)
join_all(dfList)

## https://en.wikipedia.org/wiki/Join_%28SQL%29
