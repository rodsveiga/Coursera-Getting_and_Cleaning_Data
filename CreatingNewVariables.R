##################### CREATING NEW VARIABLES #####################  

## WHY CREAT NEW VARIABLES?
# Often the raw data don't have a value you are lookinf for.
# You will neet to transform the data to get the values you would like.
# Usually you'll add those values to the d.frames you're working with (predictions).
# Common variables to creat:
# - Missingness indicatiors
# - "Cutting up" quantitative variables
# - Applying transforms

# As an exemple, we will use the Baltimore Restaurants' data again.
library(curl)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?acessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
restData <- read.csv("./data/restaurants.csv")

## CREATING SEQUENCES
# Sometimes you need an index for you data set.
# Sequences are often used to index different operations that you're going
# to be doinbg on data.
s1 <- seq(1,10, by = 2)
s1
# [1] 1 3 5 7 9
s2 <- seq(1,10, length = 3)
s2
# [1]  1.0  5.5 10.0
x <- c(1,3,8,25,100)
# You create an index you can loop over the x components values
seq(along = x)
#[1] 1 2 3 4 5

## SUBSETTING VARIABLES
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
# It might be interesting to creat a variable that indicates an subset you might
# be interested in. In the exemple, we are interested in the restaurants in 
# Roland Park and Homeland.
# Using the table funcion, we can see how hany restaurants satisfy the condition.
table(restData$nearMe)
# Note that we have created another variable: nearMe.

## CREATING BINARY VARIABLES
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
# For example, we might wanna find the cases where we know the zip code is wrong.
# Note that we're assigning to the data frame the variable zipWrong.
# ifelse: first the condition. Then you choose what it returns is the condition
# is satisfied. In this case we've chosen TRUE, after you indicate what to 
# return if the condition is not satisfied. In this case we've chosen FALSE.
table(restData$zipWrong, restData$zipCode <0 )

## CREATING CATEGORICAL VARIABLES
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
# For exempale we might wanna break the zip codes into consective numbers.
# Here we break according to their quantiles.
# cut: we choose in which variables we want to aplly (restdata$zipCode), then
# we tell it how we wanna break it. Here we break it up according to the quantiles
# to that zip code. Note that we got a factor.
table(restData$zipGroups)
# After that we can table in a more compact and convenient way.
table(restData$zipGroups, restData$zipCode)

## EASIER CUTTING
library(Hmisc)
# cut2: we can tell R to break the data into g groups according to the quantiles.
restData$zipGroups <- cut2(restData$zipCode, g = 4)
# We do not have to set explicitly the quantile breaks.
table(restData$zipGroups)

## CREATING FACTOR VARIABLES
restData$zcf <- factor(restData$zipCode)
# In the example here, we load integer values into R for the zipCode, bu, for some
# reason, we want to turn then into a factor variable.
restData$zcf[1:10]
# It tells us how many diffrent zip codes there are: levels.
class(restData$zcf)

## LEVELS OF FACTOR VARIABLES
# Ceating a dummy vector, so we can see some other properties of factor variables.
yesno <- sample( c("yes", "no"), size=10, replace = TRUE )
yesno
# We turn that vector into a factor variable. By default, it's gonna treat
# the lowest valuee alphabetically as the first value in the factor variable.
yesnofac <- factor( yesno, levels = c("yes", "no") )
# Above we set yes as the first value, differently from default.
yesnofac
# For example, we can relevel the yesnofac variable and make the reference class
# be equal to no value.
relevel(yesnofac, ref = "no")
# We can use the as.numeric command to change that factor variable into a 
# numeric variable.
as.numeric(yesnofac)

## CUTTING PRODUCES FACTOR VARIABLES
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g = 4)
table(restData$zipGroups)
# It is now a factor.
class(restData$zipGroups)

## USING THE MUTATE FUNCTION
library(Hmisc)
library(plyr)
# Mutate: create a new variable and simultaneously add to the data set.
restData2 <- mutate(restData, zipGroups = cut2(zipCode, g = 4))
# Here we use cut2 just as an example. The nwe variable zipGroups could be 
# created we any needed function.
# New data frame (restData2) : old data frame (restData) with the new 
# variable (zipGroups) added.
table(restData2$zipGroups)

## COMMON TRANSFORMS to aplly in data
# abs(x)
# sqrt(x)
# ceiling(x) -> ceiling(3.475) is 4
# floor(x) -> floor(3.475) is 3
# round(x, digits = n) -> round(3.475, digits=2) is 3.48
# signif(x, digits = n) -> round(3.475, digits=2) is 3.5
# cos(x), sin(x)
# log(x) -> natural logarithm
# log2(x), log10(x) -> other common logs
# exp(x)
