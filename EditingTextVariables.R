############# EDITING TEXT VARIABLES ############# 

## Downloading the dataset from the web
library(curl)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
cameraData <- read.csv("./data/cameras.csv")

## Looking the names of the columns
names(cameraData)

## FIXING CHARACTER VECTORS - tolower(), toupper()
# To avoid typos, we can make names all be only lowercase letter.
tolower(names(cameraData))
# You need them to be only uppercase letter.
toupper(names(cameraData))

## FIXING CHARACTER VECTORS - strsplit()
# Separate out variables that have values that are seprated by periods.
# String split command.
# - Good for automatically splitting variable names
# - Important parameters: x, split
splitNames <- strsplit(names(cameraData), "\\.")
# We have chosen to split by periods. In this case we had to use
# the \\, because he dot is a reserved character.
splitNames[[5]]
# Nothing happened to "intersection".
splitNames[[6]]
# "Location.1" was splited.

# To go on, we might wanna split a variable name that does not have a dot.
# In order to do that, we are going to remember how lists work.

## QUICK ASIDE - LIST
mylist <- list( letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
# Note that we pass same name variables too.
head(mylist)
# Subsetting
mylist[1]
mylist$letters
mylist[[1]]

## FIXING CHARACTER VECTORS - sapply()
# - Applies a function to each element in a vecor or list
# - Important parameters: X, FUN
splitNames[[6]][1]
# We might want to remove all the periods and get just the first part 
# of the variable name.
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)
# That is a way we can remove periods from names in data frames.

## PEER REVIEW DATA
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile = "./data/reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "./data/solutions.csv", method = "curl")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

## FIXING CHARACTER VECTORS - sub()
# - Substitute out characters.
# - Important parameters: pattern replacement, x.
names(reviews)
# We might want to remove the underscores from those variables.
sub("_", "", names(reviews))

## FIXING CHARACTER VECTORS - gsub()
testName <- "this_is_a_test"
# Note how sub() behaves in a variable with mulitple underscores.
sub("_", "", testName)
# We can also use gsub to replace multiple instances of a
# particular character.
gsub("_","", testName)

## FIXING CHARACTER VECTORS - grep(), grepl()
# Searching for specific values in variable names,
# or in variables themselves.
names(cameraData)
# We might want find all the intersections that include the
# Alameda, one of the roads.
head(cameraData)
#                         address direction      street  crossStreet               intersection
#1       S CATON AVE & BENSON AVE       N/B   Caton Ave   Benson Ave     Caton Ave & Benson Ave
#2       S CATON AVE & BENSON AVE       S/B   Caton Ave   Benson Ave     Caton Ave & Benson Ave
#3 WILKENS AVE & PINE HEIGHTS AVE       E/B Wilkens Ave Pine Heights Wilkens Ave & Pine Heights
#4        THE ALAMEDA & E 33RD ST       S/B The Alameda      33rd St     The Alameda  & 33rd St
#5        E 33RD ST & THE ALAMEDA       E/B      E 33rd  The Alameda      E 33rd  & The Alameda
#6        ERDMAN AVE & N MACON ST       E/B      Erdman     Macon St         Erdman  & Macon St
grep("Alameda", cameraData$intersection)
# The function grep takes a search string and look to a particular
# variable to find # all of the instances in that vector where the string appears.
grepl("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
# The grepl works similarly with grep, but returns a vector that is TRUE whenever
# Alameda appears and FALSE whetever Alameda does not appear.

# We can use grep to subset set based on certain searches.
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection), ]
# We supposed we want to subset the data to get only the observables which
# Alameda does not appear.

## MORE ON grep()
# We can use value = TRUE.
grep("Alameda", cameraData$intersection, value = TRUE)
# Note that it returns the values of the variable "intersection" where Alameda appear.
# We can also search for values that does not appear, to confirm an hypothesis, etc.
grep("JeffStreet", cameraData$intersection)
# When the value does not appear, it will return integer(0).
# If we look to the lenght, it obviously 0.
length(grep("JeffStreet", cameraData$intersection))

## MORE USEFUL STRING FUNCTIONS
library(stringr)
# The number of characters that appear in a particular string. 
nchar("Jeffrey Leek")
# Taking just part of the string. 
substr("Jeffrey Leek", 1, 7)
# Pasting two strings together.
paste("Jeffrey", "Leek")
# A little more.
paste("Jeffrey", "Leek", sep = "**")
# We can use paste0() to join two strings whith no space in between. 
paste0("Jeffrey", "Leek")
# If we want to trim off any excess space at the start or the end of a string.
str_trim("Jeff      ")

## IMPORTANT POINTS ABOUT TEXT IN DATA SETS
# Names of variables should be
# - All lower case when possible
# - Descriptive (Diagnosis versus Dx)
# - Not duplicated
# - Not have underscores or dots or white spaces
# Variables with character values
# - Should usually be made into factor variables (depends on application)
# - Should be descriptive (use TRUE/FALSE instead of 0/1 and Male/Female
# instead of 0/1 or M/F)

