##-----------------------------------------------------------
## Set working directory
##-----------------------------------------------------------

getwd()
setwd("C:\\Users\\sneha.anand.kulkarni\\Desktop\\R\\week-2")

##-----------------------------------------------------------
## Install a package
##-----------------------------------------------------------

install.packages('Hmisc')

#remove.packages('Hmisc')

##-----------------------------------------------------------
## Load a package
##-----------------------------------------------------------

library(Hmisc)

search()   # Shows packages that are currently loaded- After running the library command

##-----------------------------------------------------------
## Unload a package
##-----------------------------------------------------------

detach(package:Hmisc)

##-----------------------------------------------------------
## Access help in R
##-----------------------------------------------------------

?matrix           # Open help page on plot function

##-----------------------------------------------------------
## Read a CSV file into R
##-----------------------------------------------------------

#utils package - loaded by default
#read.table() - mother for reading any file - Reads any file in table format and create a data frame from it
#no of arguments are huge

trans <- read.csv(file = "TransactionMaster.csv")

View(trans)


trans <- read.table(file = "TransactionMaster.csv", sep = ",",
                    header = TRUE,
                    stringsAsFactors = FALSE,
                    na.strings = c("NA", ""))

#header = T - Reades the first row of the file as variable name
#sep- How fields in the data file are separated
#CSV file - Most common and standarized file
#Read.csv- Header=T & sep="," is default, dec="."
# For a text file - sep ="\t"
#read.delim - Header=T & sep="\t" is default
#Experiment a bit to get a hold


cust <- read.csv('CustomerMaster.csv',stringsAsFactors = FALSE,na.strings = c("NA", ""))

##-----------------------------------------------------------
## Check the imported dataset / Data Summary
##-----------------------------------------------------------

head(trans, n = 10)    # Display top 10 rows
View(head(trans, n = 10)) 


str(trans)             # Display the metadata (data about data)

summary(trans)         # Summary statistics for the variables

colnames(trans)           # Displays column names

rownames(trans)        # Displays the row names / numbers

dim(trans)

table(trans$Branch_Number)  #Showcases the frequency distribution of the values
##-----------------------------------------------------------
## Access elements of the dataframe
##-----------------------------------------------------------

trans[1, 2]     # Get the element from 1st row, 2nd column

trans[1, ]      # Get the first row in form of a data frame

trans[, 1]      # Get the first column in form of a vector
a <- trans[,-1]      #Excludes the first columna

trans[1]        # Get the first column in form of a list

class((trans[, 1]))     # Use class function to find the type of data structure 
class(trans[1,])

trans[c(4,5), c(1,2)]  # What does this line of code do?

cust$Customer_Name[c(1,2,3)] # Pick the first few observations
cust[c(1,2,3)]

cust$Customer_Name[1:10]     # What structure are they in?
x <- cust$Customer_Name[1:10]
class(x)                      #character vector

##-----------------------------------------------------------
## Subset data frame based on some conditions
##-----------------------------------------------------------

which(cust$City == 'ATLANTA')           # Customers in the city of Atlanta
x <- which(cust$City == 'ATLANTA')  
atlantaCustomers <- cust[which(cust$City == 'ATLANTA'), ]
class(atlantaCustomers)
unique(atlantaCustomers$City)

atlantaCustomers <- cust[which(cust$City == 'ATLANTA'), c(1,3)]  #Guess the no of rows and columns

# Get all transactions where Sales_Amount of $200 or more

highSales <- trans[which(trans$Sales_Amount >= 200),]

##-----------------------------------------------------------
## Sort a data frame by some column
##-----------------------------------------------------------

#Understanding order(),rank() and sort() function 

#Order- order tells you how to get them in ascending order.Returns the indices
a <- c(45,50,10,96)
order(a)        #3,1,2,4
order(-a)       #4,2,1,3
a[order(a)]
a[order(-a)]

#rank - rank tells the rank of each element
a <- c(45,50,10,96)
rank(a)         #2,3,1,4
rank(-a)        #3,2,4,1

order(highSales$Sales_Amount)   # Get sorted indices in increasing order

#Sort function
a <- c(45,50,10,96)
sort(a)
sort(a,decreasing = TRUE)

#Sorting based on a particular column
sortedSales <- highSales[order(highSales$Sales_Amount),]   #Kind of rearranging the rows based of row indices
a <- highSales[order(-highSales$Sales_Amount),]   #In descending order

#Sorting based on multiple column
#The sequence follows, the first one , then in that the 2nd one, then in that the 3rd one
sortedSales <- highSales[order(highSales$System_Period, 
                               highSales$Sales_Amount),]

##-----------------------------------------------------------
## Identify missing values
##-----------------------------------------------------------
#NA


trans <- read.table(file = "TransactionMaster.csv", sep = ",",
                    header = TRUE,
                    stringsAsFactors = FALSE,
                    na.strings = c("NA", ""))

which(is.na(trans$Service_Date))

trans$Service_Date[c(45918, 46011)] <- "01-Jan-00"

#Directly replacing NAs by the values in single line
trans$Service_Date[which(is.na(trans$Service_Date))] <- "01-Jan-00"

#Subsetting a data frame based on NA condition
a <- trans[which(is.na(trans$Service_Date)==FALSE),]
a <- trans[which(is.na(trans$Service_Date)==TRUE),]

#NAn
0/0

##-----------------------------------------------------------
## Delete objects from memory
##-----------------------------------------------------------

ls()
rm(sortedSales)

# Delete everything
rm(list = ls())

#Deleting/dropping particular column in a data frame
trans$Service_Date <- NULL 

#Deleting specific rows
trans_3 <- trans[!(trans$Customer_Number== 147616 & trans$Invoice_Number==2108183),]
trans_4 <- trans[-(trans$Customer_Number== 147616 & trans$Invoice_Number==2108183),]
trans_1 <- trans[-c(1,2),]

#Exporting a data
write.csv(trans,"temp.csv")
write.csv(trans,"temp.csv",row.names=FALSE)
