############# WORKING WITH DATES ############# 

## STARTING SIMPLE
# Date function.
d1 <- date()
d1
# It is a character.
class(date)
# Sys.Date function.
d2 <- Sys.Date()
d2
# It is actually a date variable.
class(d2)
# It has some diffrent properties that make it nicer on analyzing data, 
# but a little more difficult or trick than dealing with just text files.

## FORMATTING DATES
# %d = day as number(0-31)
# %a = abbreviated weekday
# %A = unabbreviated weekday
# %m = month (00-12)
# %b = abbreviated month
# %B = unabbreviated month
# %y = 2 digit year
# %Y = four digit year
format(d2, "%a %b %d")

## CREATING DATES
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
# We can also take character vectors with dates and turn its componets to
# date objects. We must inform the format of the date in the vector
z <- as.Date(x, "%d%b%Y")
z
# R will return then in a standard Sys.Date format.
# Manipulation: time differences.
z[1]-z[2]
# The class of this variable is "difftime"
class(z[1]-z[2])
# Turning it into a numeric variable.
as.numeric(z[1]-z[2])

## CONVERTING TO JULIAN
d2
# weekdays() function
weekdays(d2)
# months() function
months(d2)
# julian() function: the number of days that have occurred since the origin.
julian(d2)

## LUBRIDATE PACKAGE
# It makes working with dates easier than to use as.Date function.
library(lubridate)
# Converting a number to a data regardless of what the format is.
ymd("20140108")
# "2014-01-08"
mdy("08/04/2013")
# "2013-08-04"
dmy("03-04-2013")
# "2013-04-03"

## DEALING WITH TIMES
# Similarly with time.
ymd_hms("2011-08-03 10:15:03")
# We can also set the time zone.
ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Auckland")
# For more about time zones look at ?Sys.timezone

## SOME FUNCTIONS HAVE SLIGHTLY DIFFERENT SYNTAX
x <- dmy( c("1jan2013", "2jan2013", "31mar2013", "30jul2013") )
# In the lubridate package we get the weekday by wday function.
wday(x[1])
# If we want to know the weekday in terns of the actual abbreviation, 
# we have to set label = TRUE.
wday(x[1], label = TRUE)

# NOTE: Remember the classes "POSIXct" and "POSIXlt". For more ?POSIXlt.

