##################### DPLYR PACKAGE BASIC TOOLS ##################### 

library(dplyr)
# We will get some warning packages, but we do not have to worry for the moment.
chicago <- readRDS("chicago.rds")
# We are gonna use some data we've downloaded from Peng's github.
# Checking the data set.
dim(chicago)
str(chicago)
names(chicago)

## SELECT FUNCTION
# Subset columns.
head(select(chicago, city:dptp))
# Note that you can subset columns using their names, instead of their index.
# Similarly, we can exclude a range in the subsetting.
head(select(chicago, -(city:dptp)))
# In regular R, we would have to find the columns index:
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[ , -(i:j)])
# With dplyr package we can do in one command.

## FILTER FUNCTION
# Subset rows.
# For example, take all the rows where pm25tmean2 is less than 30.
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, n =10)
# Multiple columns conditions.
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)
# The conditions can be chosen arbitrarily. Note that we always use columns names.

## ARRANGE FUNCTION
# Reorder the rows of a data frame based on the values of a column (in a simple
# and easy to read way).
chicago <- arrange(chicago, date)
head(chicago)
tail(chicago)
# Arranging the rows in descending order.
chicago <- arrange(chicago, desc(date))
head(chicago)
tail(chicago)

## RENAME FUNCTION
# Surprisingly, rename a column is not a easy task without the rename function.
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
# Syntax: new name=old name. Naturally, the other column names are kept the same.
head(chicago)

## MUTATE FUNCTION
# Useful to transform existing variables or to create new variables.
# For example, we are gonna create a new variable pm25detrend, which is basically
# the "centered" pm25: we just subtract its mean.
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(chicago)
# Looking just to the pm25 and pm25detrend variables.
head(select(chicago, pm25, pm25detrend))

## GROUP BY FUNCTION
# First we created a nex example varaible, using mutate.
chicago <- mutate(chicago, tempcat =factor( 1*(tmpd > 80) , labels = c("cold", 'hot')))
# If (tmdp > 80) = FALSE : label "cold"
# If (tmdp > 80) = TRUE: label "hot" 
# After adding the new variable, we "group_by". The rows a reordered in a way
# that they form two clusters, one for tempcat = cold and other for = hot.
hotcold <- group_by(chicago, tempcat)
hotcold

## SUMMARIZE FUNCTION
# Once we have defined the group by levels, we can summarize information based
# on these levels. Below we want to know the mean for pm25, the maximum value
# for o3tmean and # the median for no2tmean2 for both cold and hot levels.
summarize(hotcold, pm25=mean(pm25), o3=max(o3tmean2), no2=median(no2tmean2) )
# To ignore the missing values we put na.rm = TRUE in the first function.
summarize(hotcold, pm25=mean(pm25,na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2) )

# We could also make a summary for each year showed in the data set.
# We can extracte the year from the variable date using the as.POSIXlt function.
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25=mean(pm25,na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2) )

## PIPELINE OPERATOR 
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% 
  summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))
# We do not have to specify the data set in each command and prevents us from having 
# to kind of assign a number of temporary variables that e susequently feed into 
# another function, and it allows us to kind of change a bunch of operations in one
# sequence that's both readable and powerful.

## ADDITIONAL BENEFITS
# Once you learn the dplyr "grammar", there are a few additional benefits:
# - dplyr can work with other data frame "backends"
# - data.table for large fast tables
# SQL interface for relational databases via the DBI package.
