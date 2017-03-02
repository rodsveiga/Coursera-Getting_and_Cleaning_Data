source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
## Create rhdf files: h5createFile
created = h5createFile("example.h5")
created

## Create groups
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa") ## subgroup of foo called foobaa
h5ls("example.h5")

## Write to groups
A = matrix(1:10, nr = 5, nc = 2)
h5write(A, "example.h5", "foo/A")
## Writing a multidimensional array
B = array( seq(0.1, 2.0, by=0.1), dim=c(5,2,2) )
## We can add attributes. For example, give metadata (units in this case).
attr(B, "scale") <- "liter"
## Writing this array in a particular subgroup
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")
## Note that inside the groups we have some datasets.

## Write a data set.
df = data.frame(1L:5L, seq(0,1,length.out=5), c("ab","cde","fgh1","a","s"), stringsAsFactors = FALSE)
## Writing directly in the top level group. In the root group.
h5write(df,"example.h5", "df")
h5ls("example.h5")

## Reading data.
readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA

## Writing and reading chunks.
h5write(c(12,13,14), "example.h5", "foo/A", index = list(1:3,1))
## In this specific example we are writing in the first three rows of the first
## column of the A dataset.
h5read("example.h5", "foo/A")
## We can use a similar index command to read just the sub-component of the database
