##-----------------------------------------------------------
## Set working directory
##-----------------------------------------------------------

setwd("E:\\R Training Learnbay\\Week 2 classes")

##-----------------------------------------------------------
## Load the file
##-----------------------------------------------------------
trans <- read.table(file = "TransactionMaster.csv", sep = ",",
                    header = TRUE,
                    stringsAsFactors = FALSE,
                    na.strings = c("NA", ""))
cust <- read.csv('CustomerMaster.csv',stringsAsFactors = FALSE,na.strings = c("NA", ""))
###------------------------------------------------------------
### Basic Functions
###------------------------------------------------------------

summary(trans)

sum(trans$Sales_Amount)  			# Total Sales

sum(trans$Sales_Amount, na.rm = T)  #na.rm - Removes NA while taking a sum of the column

###------------------------------------------------------------
### Identify the transactions with maximum value
###------------------------------------------------------------

maxSales <- max(trans$Sales_Amount, na.rm = T)

maxTrans <- trans[which(trans$Sales_Amount == maxSales), ]

###------------------------------------------------------------
### How many unique customers in total 
###------------------------------------------------------------

length(maxTrans$Customer_Number) #Total no of values

unique(maxTrans$Customer_Number)  # unique values
length(unique(maxTrans$Customer_Number))  # No of unique values

###------------------------------------------------------------
### Aggregate functions
###------------------------------------------------------------

# Count number of customers by branch number
countOfCusts <- aggregate(x = cust['Customer_Number'], 
                          by = cust['Branch_Num'], 
                          FUN = length)
sum(countOfCusts$Customer_Number)
countOfCusts_1 <- aggregate(x = cust['Customer_Name'], 
                          by = cust['Branch_Num'], 
                          FUN = length)

colnames(countOfCusts)[2] <- "Total_Customers"
rm(countOfCusts,countOfCusts_1)
rm(maxTrans)

# Average  Sales by Branch
a <- aggregate(formula = Sales_Amount ~ Branch_Number, 
               data = trans, 
               FUN = mean)

# Total  Sales by Branch
a <- aggregate(formula = Sales_Amount ~ Branch_Number, 
          data = trans, 
          FUN = sum)
sum(a$Sales_Amount)
sum(trans$Sales_Amount,na.rm = T)

###Aggregating using multiple columns

# Total Sales By Branch & Product
b <- aggregate(formula = Sales_Amount ~ 
            Branch_Number + Product_Number, data = trans, FUN = sum)
sum(b$Sales_Amount)
sum(trans$Sales_Amount,na.rm = T)

trans$Flag <- 1
c <- aggregate(formula = cbind(Sales_Amount,Flag) ~ 
                 Branch_Number + Product_Number, data = trans, FUN = sum)
sum(b$Sales_Amount)
sum(trans$Sales_Amount,na.rm = T)

#Alternate formula 
d <- aggregate(list(Sales_Amount=trans$Sales_Amount), 
               by = list(Branch_Number=trans$Branch_Number, Product_Number=trans$Product_Number), 
               sum)
#Aggregating on multiple variables
e <- aggregate(list(Sales_Amount=trans$Sales_Amount,Flag=trans$Flag), 
               by = list(Branch_Number=trans$Branch_Number, Product_Number=trans$Product_Number), 
               sum)

rm(a,b,c,d,e)

###------------------------------------------------------------
### Perform joins in R
###------------------------------------------------------------

# Full Outer Join
outer <- merge(x = trans, y = cust, 
               by.x = "Customer_Number" , 
               by.y = "Customer_Number", 
               all = TRUE)

# Inner Join
inner <- merge(x = trans, y = cust, 
               by.x = "Customer_Number" , 
               by.y = "Customer_Number", 
               all = FALSE)

# Left Join
left <- merge(x = trans, y = cust, 
              by.x = "Customer_Number" , 
              by.y = "Customer_Number", 
              all.x = TRUE)

# Right Join
right <- merge(x = trans, y = cust, 
               by.x = "Customer_Number" , 
               by.y = "Customer_Number", 
               all.y = TRUE)

#Joining on multiple columns
inner_1 <- merge(x = trans, y = cust, 
               by.x = c("Customer_Number","Branch_Number") , 
               by.y = c("Customer_Number","Branch_Num"), 
               all = FALSE)


a <- data.frame(name=c('Ashwin','Saagar','Anil','Ankit'),
                marks=c(50,90,80,40),
                stringsAsFactors = FALSE)

b <- data.frame(name=c('Ashwin','Anil','Saagar','George'),
                section=c('A','B','C','A'),
                stringsAsFactors = FALSE)

#By default sorting happens after merge.The sorting happens on the column being used for merge.
#If we want to retain the original order of the x table,metion sort=FALSE
a_b_inner <- merge(x = a, y = b, 
                 by="name",
                 all = FALSE,
                 sort=FALSE)

a_b_inner <- merge(x = b, y = a, 
                   by="name",
                   all = FALSE,
                   sort=FALSE)

a_b_left <- merge(x = a, y = b, 
                   by="name",
                   all.x = TRUE
                  )

a_b_left <- merge(x = a, y = b, 
                  by="name",
                  all.x = TRUE,
                  sort=FALSE)     

a_b_right <- merge(x = a, y = b, 
                  by="name",
                  all.y = TRUE,
                  sort=FALSE)  

###------------------------------------------------------------
### Create derived variables based on conditions
###------------------------------------------------------------

#We are creating a new column over here
trans$salesFlag <- ifelse(trans$Sales_Amount > 200, 'High', 'Low')

str(trans)


##-----------------------------------------------------------
## Creating a factor variable. How the functionality changes
##-----------------------------------------------------------

trans$salesFlag <- ifelse(trans$Sales_Amount > 200, 1, 0)

sum(trans$salesFlag, na.rm = TRUE)
summary(trans$salesFlag)
table(trans$salesFlag)

trans$salesFlag <- factor(trans$salesFlag)
sum(trans$salesFlag, na.rm = TRUE)  #Now sum won't work as it has been changes to factor from numeric
table(trans$salesFlag)
summary(trans$salesFlag)


