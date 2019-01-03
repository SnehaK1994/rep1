##----------------------------------------------------------
#match() function and %in% operator use cases

#nomatch - The value to be returned in case no match is found

v1 <- c('Jacob','Ariel','Rahul')
v2 <- c('John','Santosh','Jacob','Rahul')

match(v1, v2, nomatch = 0)
match(v2, v1, nomatch = 0)

#values of V1 are matched in v2 and the corresponding indices of the first match is returned

#TO get the values in V2 which are present in V1
v2[match(v1, v2, nomatch = 0)]


#Alternate way to perform the same operation using %in% operator
v1 %in% v2

v1[v1 %in% v2]  #values in v1 which are present in v2
v2[v2 %in% v1]  #values in v2 which are present in v1

###------------------------------------------------------------
### Reshaping with tidyr package. Transforming data set from one form to another.
###------------------------------------------------------------

library(tidyr)

df <- data.frame(
  player = c('Mike','Bruce','Jose'),
  X2015=c(41,42,40),
  X2016=c(50,51,52),
  X2017=c(55,57,60)
)

df

# Put in long format
# Gather() takes multiple columns and collapses into key-value pairs, duplicating all other columns as needed
long_df <- gather(data = df, key = "year", value = "home_runs", 2:4)
long_df <- gather(data = df, key = "year", value = "home_runs", X2015:X2017)


#key = give the new variable name
#value = column name containing the values
#last argument- The columns that we are stacking
long_df <- gather(data = df, key = "year", value = "home_runs", X2015:X2017)

# Put in wide format
wide_df <- spread(data = long_df, key = year, value = home_runs)

#key - THe column to spread across multiple columns
#value- It the name of the column whose value would be taken by multiple spread columns

#You will also find alternative syntax of cast/dcast to do the same function as gather/spread.
#BUt cast/dcast comes under reshape2 package instead of tidyr package
