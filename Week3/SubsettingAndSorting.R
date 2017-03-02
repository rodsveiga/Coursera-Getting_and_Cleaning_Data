#####################  SUBSETTING AND SORTING #####################  

## SUBSETTING - QUICK REVIEW
set.seed(13435)
# Creating a data frame with column names (variables)
X <- data.frame("var1"=sample(1:5),"var2" = sample(6:10), "var3" = sample(11:15))
# Naming the rows (observables).
X <- X[sample(1:5),]
# Puttin some NA's in the column var2.
X$var2[c(1,3)] <- NA
X
# Subsetting an specific column.
X[ ,1]
X[, "var1"]
# Subsetting both rowns and columns.
X[1:2, "var2"]
# Example above:  The first two rowns in the column var2.

## SUBSETTING WITH LOGICAL STATEMENTS.
# And's:
X[ (X$var1 <= 3 & X$var3 > 11),  ]
# Or's:
X[ (X$var1 <= 3 | X$var3 > 15),  ]
# Dealing with missing values (which does not return the NA's).
X[ which(X$var2 > 8), ]

## SORTING.
# Sorting the values in increasing order.
sort(X$var1)
# Sorting the values in increasing order.
sort(X$var1, decreasing = TRUE)
# You can tell R to put missing values in the end.
sort(X$var2, na.last = TRUE)

## ORDERING
# Ordering the data frame. You order some of the columns, for example, and then
# passes to the data frame rows. R will reorder the rows.
X[order(X$var1),]
# Order by multiple variables.
X[order(X$var1, X$var3), ]
# The X$var3 would play a role of there were repeated X$var1 values.

## ORDERING WITH PLYR
library(plyr)
## arrange() function: dataframe and a variable which the dataframe is sorted on.
arrange(X, var1)
## arrange() in decreasing order.
arrange(X, desc(var1))

## ADDING ROWS AND COLUMNS
X$var4 <- rnorm(5)
X
## Another way to do it:
Y <- cbind(X, rnorm(5))
Y
## To bind that column in the last side of Y: cbind(rnorm(5). X)
## Binding rows: rbind().