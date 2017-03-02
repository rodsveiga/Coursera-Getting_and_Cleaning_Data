## Install RMySQL (if it has not been installed yet)
install.packages("RMySQL")

## Loading the RMySQL Package
library(DBI)
## Required package: DBI (the system told us about DBI)
library(RMySQL)

## Connecting and listing databases
ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;")
## show databases is actually a SQL command. Send the databases through dbGetQuery
dbDisconnect(ucscDb)
## It is very important to disconnect
result
## SQL can have multiple databases. Each database can have multiple tables. 
## Each table can have multiple fields.
## - Databases
## - Tables within databases
## - Fields within tables

## Each table correspond what we call dataframe in R.

## The result variable shows all the databases. 
## We will focus in one database in particular (hg19).

## Connecting to hg19 and listing tables.
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
## The name of the first five tables.
allTables[1:5]
## Note that each datafile gets its own table (similar to one tidy data principle).

## Get dimensions of a specific table.
## Suppose we now the name of one specific table we are intrested in.
dbListFields(hg19,"affyU133Plus2")
## Tables correspond to something like dataframe and filds correspond to
## something like columns names.

## Obs.:
## In this case:
## hg19: database
## affyU133Plus2: table
## column names of the table (dataframe) affyU133Plus2: dbListFields(hg19,"affyU133Plus2")

## Counting the number of rows (the number of records) in a table.
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
## The "select count(*) from ..." is a mySQL command.

## Read from the table.
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

## Select a specific subset.
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
## Command "select *": selects all the observations
affyMis <- fetch(query)
head(affyMis)
## The generic function quantile produces sample quantiles corresponding to the given 
## probabilities. The smallest observation corresponds to a probability of 0 and the largest
## to a probability of 1.
quantile(affyMis$misMatches)
## Remember: when you used the dbSendQuery command, it sent it to the database, 
## but it didn't try to suck the data back to your personal computer yet.

## To avoid huge tables, we can bring back just the n top records
affyMisSmall <- fetch(query, n=10)
## When you do that, you need to clear the query from the remote server.
dbClearResult(query)
## Small data set.
dim(affyMisSmall)

## Importante note about:
## dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
## You can basically send any MySQL query that you would like up there
## within the quotes.

## Don't forget to close the connection, immediately after extracting out the
## data you are interested in.
dbDisconnect(hg19)