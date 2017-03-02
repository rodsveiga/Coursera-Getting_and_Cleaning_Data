library(data.table)

## Create data tables just like data frames
DF = data.frame(x = rnorm(9), y = rep(c("a","b","c"), each=3), z = rnorm(9))
head(DF,3)

DT = data.table(x = rnorm(9), y = rep(c("a","b","c"), each=3), z = rnorm(9))
head(DT,3)

## See all the data tables in memory
tables()

## Subsetting rows
DT[2,]
DT[DT$y=="a",]  ## Similat to data.freme

DT[c(2,3)] ## Subset with only on one index: based on the rows
           ## A little bit different

## Subsetting columns!? --> Divergefrom data.frame
DT[ , c(2,3)]   ## Professor says it diverges, but I get the same result
                ## I would've got with data.frame

## Column subsetting in data.table

# The argument you pass after the comma is called an "expression"
# In R an expression is a collection of statements enclosed in curley brackets
{
  x = 1
  y = 2
}
k = {print(10);5}
print(k)

## Calculating values for variables with expressions
DT[ , list(mean(x), sum(z))]
DT[ , table(y)]

## Adding new colouns (very fast and memory efficiently)
DT[ , w:=z^2] ## Data.table does not creat a new copy, differently from data.frame
              ## Very good for big data, but be careful: IF YOU WANT TO MAKE A
              ## COPY, USE EXPLICITLY THE COPY() FUNCTION 
             
              ## DT2 <- DT[ , w:=z^2]
              ## DT[ , w:=z^2] will change both DT and DT2

## Multiple operations (multi-step operations)
DT[ , m := {tmp <- (x+z); log2(tmp+5)}]
       ## x+z: first operation
       ## log2(x+z+5): second operation

## plyr like operations
DT[ , a := x>0 ]
      
                             ## This one is fantastic:
DT[ , b := mean(x+w), by=a ] ## Take the mean of (x+w) for a = FALSE and place
                             ## that mean into a new colunm when a = FALSE.
                             ## Take the mean of (x+w) for a = TRUE and place
                             ## that mean into a new colunm when a = TRUE.
                             ## "calculate something by some criterion"

## Special variables
set.seed(123)
                ## .N :an integer, lgh1, containing the number of 
                ## times a variable occurs
DT <- data.table(x = sample(letters[1:3], 1E5, TRUE))
DT[ , .N, by=x]  ## faster than dt$x

## Keys
DT <- data.table( x=rep(c("a","b","c"), each=100), y=rnorm(300))
                ## Unique aspect. If we set the key, we can
                ## subset in a very quick way. 
setkey(DT,x)
DT['a'] ## It knows the key is x, so it goes look into x

## Joins
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a','b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1,DT2)    # Faster than the equivalent process with data.frame

## Fast reading
big_df <- data.frame( x=rnorm(1E6), y=rnorm(1E6) )
file <- tempfile()
write.table(big_df,file=file,row.names=FALSE,col.names=FALSE, sep = "\t",quote=FALSE)

system.time(fread(file)) ## Fread command: the read command to data.table
system.time(read.table(file, header = TRUE, sep = "\t"))



                       

   

