##################### RESHAPING DATA ##################### 

## THE GOAL IS TIDY DATA

# - Each variable forms a column
# - Each observation forms a row
# - Each table/file stores data about one kind of observations (e.g.people/hospitals)
# In the data reshaping we will focus in the first two above.

## START WITH DATA RESHAPING
library(reshape2)
# Using one of the standard data sets in R: mtcars.
head(mtcars)
## MELTING DATA FRAMES
# rownames: Retrieve or set the row names of a matrix-like object.
mtcars$carname <- rownames(mtcars)
# We pass the data to the melt function, and we tell it which of the variables are
# ID variables and which of the variables are measure variables.
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt)
# It'll create a bunch of ID values (carname, gear, cyl) and then it's goint to
# basically melt all the rest of the values.
tail(carMelt)
# The carMelt is a very tall skinny data frame. In the variable columns we'll see
# mpg and hp.
# The melt function basically reshaped the data set so that it's tall and skinny
# and so there is one row for every mpg and one row for every hp.
# Onde we've melted the data set we can recast it in a bunch of different ways.

## CASTING DATA FRAMES
cylData <- dcast(carMelt, cyl ~ variable)
# The dcast function will recast the data set into a particular shape, into a
# particular data frame.
# In the example, cylData says that for 4 cyl we have 11 measures of mpg and 
# 11 measures of hp. For 6 cyl we have 7 measures of mpg and 7 measures of hp (...) 
cylData
# Remember that we set for "variable" -> mpg, hp. Essentially, it resummarizes data.
# We can also pass a different function. In this example, we take the mean.
cylData <- dcast(carMelt, cyl ~ variable, mean )
# For 4 cyl the mean miles  per gallon is 26.66 and mean horse power is 26.66
cylData

## AVARAGING VALUES
head(InsectSprays, n = 15)
# Again of the standard data sets in R.. One thing we might found interesting 
# is average values within a particular factor.
# An example:
tapply(InsectSprays$count, InsectSprays$spray, sum)
# We are gonna apply to the vector InsectSprays$count, along the index spray,
# the funcution sum. 
# Within each value of spray, it will sum up the counts.
# A   B   C   D   E   F 
# 174 184  25  59  42 200
# That's one very brief, shortsand way of calculating those sums.

## ANOTHER WAY - SPLIT
spIns <- split(InsectSprays$count, InsectSprays$spray)
# Split, apply, combine method.
# After split we get a list of values for A, a list of values for B, and so forth.
spIns
# Then we can apply a function acroos that list.
sprCount <- lapply(spIns, sum)
sprCount
# Combine: we might want a vector, because it is easier to manipulate: unlist.
unlist(sprCount)
# Or we could have used the sapply instead of apply. 
# Apply always returns a list, but sapply converts the result to a
# vector, when it is possible.
sapply(spIns, sum)

## ANOTHER WAY - PLYR PACKAGE
library(plyr)
# The plyr package provides a nice interface for doing this sort of action in just
# one step.
ddply(InsectSprays, .(spray), summarize, sum = sum(count))
# We say to ddply function:
# The data set.
# The variables we'd like to summarize (no quotation marks, dots and parenthesis).
# Then we say we want to summarize this variable.
# Finally, how we want to summarize. Here we want to sum up the the count within 
# that spray variable.

## CREATING A NEW VARIABLE
# The plyr process above is kind of nice because you can also use it to calculate
# the values and apply then to each variable.
# For example, suppose we wanna be able to subtract off the mean, or the total
# counet from the actual count for every variable.
spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN = sum))
# Now we've passed the ave function. We are actually calculating the sum as the
# ave function applied to count where the subfunction os sum.
# The spraySums end up with the same dimension of the original data set.
dim(spraySums)
# For every time we see A in the spray, we get the sum for all of the A values, 
# and so forth.
head(spraySums)
# Instead of having a data set where we see the sum for A just once, we see
# the sum for A for every value of A in the data set (and so forth). So that now
# this variable can be added to the data set and used to do different analysis.

## SEE ALSO THE FUNCTIONS
# - acast: for casting as multi-dimensional arrays
# - arrange: for faster reordering without using order() commands
# - mutate: adding new variables 
# Obs.: we can use mutate with ddply to add new variables that are
# summaries of previuos variables.

