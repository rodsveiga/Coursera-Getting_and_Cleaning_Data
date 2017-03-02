#####################  SUMMARIZING DATA #####################  

# Go to the following url and take a look on "Export".
# https://data.baltimorecity.gov/Culture-Arts/Restaurants/k5ry-ef3g/data
# Copy link location for CSV.

## GETTING THE DATA FROM THE WEB
library(curl)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?acessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
restData <- read.csv("./data/restaurants.csv")

## LOOK AT A BIT OF THE DATA

# HEAD and TAIL commands. By default n = 6.
head(restData, n= 3)
tail(restData, n =3)

# MAKE SUMMARY. For every single variable, it gives you information.
summary(restData)
# Type of information:
# Factors or text-based variables: counts each factor.
# Quantitative variables: the minimum, first quantile, median, and so forth

# STR command: structure of the data.
str(restData)

# QUANTILES OF QUANTITATIVE VARIABLES.
quantile(restData$councilDistrict, na.rm = TRUE)
# Value related to 0% -> smallest value
# Value related to 100% -> top value
# Value related to 50% -> median (...)
# Looking to the different probabilities (percentiles)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))

# MAKE TABLE.
# Another way to look at the data.
# Look at specific variable and make a table.
table(restData$zipCode, useNA = "ifany")
# It couns each observable of the variable in question and place this information
# in a table. the useNa = "ifany" tell R to creat a row to missing values in the
# table, if there are any. By default the table function doesn't show missing values.

# You can also make two domensional tables, relating two different variables.
table(restData$councilDistrict, restData$zipCode)

# CHECKING FOR MISSING VALUES.

# is.na returns a one if it is missing and a zero of it is not missing. Then, 
# if the sum equals to 0, there is no missing values.
sum(is.na(restData$councilDistrict))
# You can also use the any command (logical).
# In this case the is.na results are treated  as TRUE (missing) or FALSE 
# (not missing). The any function checks of there is at # least one TRUE.
any(is.na(restData$councilDistrict))
# All command: logical. Returns TRUE or FALSE>
all(restData$zipCode > 0)

# Row and column sums
colSums(is.na(restData))
# If the colSums is 0 for a paricular column, there is no missing values
# You can just check through all data.
all(colSums(is.na(restData)) == 0)
# If it returns TRUE, there are no missing values in this data set.

# VALUES WITH SPECIFIC CHARACTERISTICS
table(restData$zipCode %in% c("21212"))
# We could just use the == operator, but we can alsa say, are thre any value of
# restData$zipCode variable that fall into the vector c("21212").
# More interesting when we want to find more than one value.
table(restData$zipCode %in% c("21212", "21213"))
# Are there one zipCodes values that are equal to 21212 or 21213?

# OBS --> very nice! Look below.
# You can use the logical variable restData$zipCode %in% c("21212", "21213")
# you've just created to subset the data.
restData[ restData$zipCode %in% c("21212", "21213"),  ]

# CROSS TABS

# Loading data on Berkeley admissions data (one of the classic data sets in R).
data("UCBAdmissions")
DF <- as.data.frame(UCBAdmissions)
# With the summary we can see there are four variables.
summary(DF)

# Corss tabs: identify where the relationships exist in this data set.
xt <- xtabs( Freq ~ Gender + Admit, data = DF)
xt
# On the left you put the variable that you want to be displayed in the table. 
# In this case is Freq. Then you break that down by diffrents kinds of variables.

# FLAT TABLES

# Cross tabs for a large number of variables. Often kind of hard to see.
# We use another one of the standard R data sets. We are actually adding in
# another replicate variable just to illustrate this point.
warpbreaks$replicate <- rep( 1:9, len = 54)
# Here breaks is the value we want to be shown in the table. We break that 
# down by all the variables in the data set.
xt <- xtabs(breaks ~., data = warpbreaks)
xt
# Note that it is hard to read. Multiple two dimensional tables.
# We can flat thecross table. It will summarize the data in a much smaller, more
# compact form.
ftable(xt)

# SIZE OF THE DATA SET
fakeData <- rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")
