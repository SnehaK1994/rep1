#Lenght(),Count() & Table function

#Counting for a specific value in a vector
numbers <- c(4,23,4,23,5,43,54,56,657,67,67,435,
             453,435,324,34,456,56,567,65,34,435)

table(numbers)
#Length()
length(which(numbers==23))

numbers <- c("a","b","a","c")
table(numbers)
length(which(numbers=="a"))

#We need to load library plyr for count() function to work
#count - similar to table function,but showcases the o/p in more user friendly way

bevs <- data.frame(cbind(name = c("Bill", "Llib"), drink = c("coffee", "tea", "cocoa", "water"), cost = seq(1:8)))
table(bevs$name,bevs$drink)

#Count()
install.packages('plyr')
library(plyr)
count(bevs,c("name","drink"))

count(bevs,"name")
count(bevs,"drink")

length(which(bevs$name=="Bill"))
length(which(bevs$drink=="coffee"))


length(which(bevs$name=="Bill" & bevs$drink=="coffee"))
