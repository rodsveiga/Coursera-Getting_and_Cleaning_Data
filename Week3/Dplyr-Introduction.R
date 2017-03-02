##################### DPLYR PACKAGE - INTRODUCTION ##################### 

# Especially made for data frames, which are a key data structure in statistics
# and in R

#  There are four basic assunptions in the dplyr package:
# - There is one observation per row.
# - Each column represents a variable or measure or characteristic.
# - Primary implementation that you will use is the default R impleentation.
# - Other implementations, particularly relational databases systems.

# DPLYR
# - An optimized and distilled version of plyr package.
# - Does not provide any "new" functionality , but greatly simplifies existing 
# funcionality in R.
# - Provides a "grammar" (in particular, verbs), for data manipulation.
# - Is very fast, as many key operations are coded in C++.

# DPLYR VERBS
# - select: return a subset of the columns of a data frame.
# - filter: extract a subset of rows from a data frame based on logical conditions.
# - arrange: reorder rows of a data frame
# - mutate: add new variables/columns or transforming exeisting variables.
# - summarise/summarize: generate summary statistics of different variables in the
# data frame, possibly within strata.

# There is also a handy print method that prevents you from printing a lot of 
# data to the console.

## DPLYR PROPERTIES
# All the dplyr function have a kind of similar format:
# - The first argument is a data frame.
# - The subsequent arguments describe what to do with it, and you can refer to 
# columns in the data frame without using the $ operator (just use the names).
# - The result is a new data frame.
# - Data frames must be properly formatted and annotated for this all be useful.
