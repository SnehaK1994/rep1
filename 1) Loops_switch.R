#If Statement

#Syntax:
#  if(boolean_expression) {
#  // statement(s) will execute if the boolean expression is true.
#}

x <- 30L
if(is.integer(x)) {
  print("X is an Integer")
}


#if-else

#Syntax:
#if(boolean_expression) {
#  // statement(s) will execute if the boolean expression is true.
#} else {
#  // statement(s) will execute if the boolean expression is false.
#}


x <- c("what","is","truth")

if("Truth" %in% x) {
  print("Truth is found")
} else {
  print("Truth is not found")
}

##############################################################################################

x <- c("what","is","truth")

if("Truth" %in% x) {
  print("Truth is found the first time")
} else if ("truth" %in% x) {
  print("truth is found the second time")
} else {
  print("No truth found")
}



#Switch

#Syntax: switch(expression, case1, case2, case3....)
#The switch() function in R tests an expression againts elements of a list
#If the value evaluated from the expressions matches item from the list, the corresponding value is returned

#1) Based on index
#switch(expression,list)

x <- switch(3,
  "first",
  "second",
  "third",
  "fourth"
)
print(x)

x <- switch(4,"red","green","blue")
print(x)

#2) Based on matching value
#In this case, the matching named item's value is returned

y = "12"
x <- switch(y,
            "9"="Good Morning",
            "12"="Good Afternoon",
            "18"="Good Evening")
print(x)

#taking inpur from user
#readline() is the function & promt is the argument we use for showing the message
choice = as.integer(readline(prompt="Enter choice[1/2/3/4]: "))

