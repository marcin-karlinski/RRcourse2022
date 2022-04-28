#Exercise 2

#Readable solution to FizzBuzz problem

#generating a sequence of numbers from 1 to 100 twice
x=1:100
y=1:100

#first, we're gonna multiply all the numbers from the first sequence (x) by 3.
#this way we got all the numbers which are dividable by 3
#we replace those numbers in the second sequence (y) with 'Fizz'
y[3*x]='Fizz'

#The same operation but for 5 and for word 'Buzz'
y[5*x]='Buzz'

#The same but for 15 (it is dividable by both 3 and 5) and for word 'FizzBuzz'
y[15*x]='FizzBuzz'

#writing the resulting sequence separated  by a new line
write(y[x],1)


#Exercise 2
library(types)
#1. 

#' @title largest_fibonacci
#' @description Finds the largest Fibonacci sequence number smaller than n.
#' 
#' @param n Single number larger than 1 and smaller than 1 000 000 (to avoid computation issues).
#' @return Largest Fibonacci sequence number smaller than n.
#' @examples
#' largest_fibonacci(60)
largest_fibonacci <- function(n = ? numeric){
  
  #Check if provided argument is numeric
  if(!is.numeric(n)){
    stop(paste("Only numeric arguments are accepted."))
  }
  
  #only numbers between 2 and 1 000 000 are accepted for safety reasonss
  if(n <= 1 | n > 1000000){
    stop(paste("Only arguments larger than 1 and smaller than 1 000 000 are accepted."))
  }

  
  #starting with first 2 elements of the Fibonacci sequence, 1 and 1
  counter = 2
  fib <- c(1,1)
  
  #as long as n is larger than the last element of the sequence, keep calculating 
  #Fibonacci numbers
  while(n > fib[counter]){
    counter = counter + 1
    fib[counter] = fib[counter -2] + fib[counter-1]
  }
  
  #when n is smaller than the latest calculated Fibonacci number stop and return 
  #the previous one, that is the largest Fibonacci numebr smaller than n
  return(fib[length(fib)-1])
  
}

largest_fibonacci(427327)





#2. 

#' @title reverse_integer
#' @description Returns and integer with a reversed order. If the result would 
#' result with 0 at the beggining of the number, then 0s are omitted, eg. 100 -> 1
#' 
#' @param n A single integer with a maximum length of 1 000.
#' @return Integer with a reversed order of digits.
#' @examples
#' reverse_integer(125439)
reverse_integer <- function(n = ? integer){
  
  #Check if n is integer
  if(n != round(n)){
    stop(paste("Please provide an integer value"))
  }
  
  #maximum length of integer of 1 000
  if(nchar(n) > 1000){
    stop(paste("Maximum length of an integer is 1 000."))
  }
  
  #changing n to character
  n <- as.character(n)
  
  #reversing the order of the string with the rev() function. 
  #It reverses the order of a vector, so we need to change the string to list 
  #with strsplit(), then change it to vector with unlist() and finally print the string
  #in reversed order.
  n <- paste(rev(unlist(strsplit(n, NULL))), collapse="")
  
  #change it back to numeric before return
  n <- as.numeric(n)
  
  return(n)
  
}

reverse_integer(123400.5)

#Exercise 3 
#Write names of all US states in UPPERCASE and lowercase to a file. 
#Write how to do this without typing all 50 names manually. 
#Separate code from input and from output.

#there is a state object in base R. We can use toupper and tolower functions
toupper(state.name)
tolower(state.name)

states_names <- data.frame(uppercase = toupper(state.name), 
                           lowercase = tolower(state.name))

write.csv(states_names, "state_names.csv")


#Exercise 4

library(tidyverse)

# read the file with data
StudentsPerformance <- read.csv('StudentsPerformance.csv')

#don't use "/" in column names...
StudentsPerformance <- StudentsPerformance %>% 
  rename(race_ethnicity = `race/ethnicity`,
         math_score = `math score`,
         test_preparation_course = `test preparation course`,
         parental_education = `parental level of education`)

# the dataframe contains data about 5 groups
unique(StudentsPerformance$race_ethnicity)
length(unique(StudentsPerformance$race_ethnicity))

# print mean math score for each group
StudentsPerformance %>% 
  group_by(race_ethnicity) %>% 
  summarize(mean_math_score = mean(math_score))
  
# print mean math, reading, and writing scores for students who completed 
#the test preparation course and their parent obtained a degree

StudentsPerformance %>% 
  filter(test_preparation_course == "completed" &
         parental_education %in% c("associate's degree", 
                                   "bachelor's degree", 
                                   "master's degree")) %>% 
  summarize(math = mean(math_score),
            reading = mean(`reading score`),
            writing = mean(`writing score`))

# plot the histogram of math scores divided by reading scores for each student

StudentsPerformance %>% 
  mutate(value = math_score/`reading score`) %>% 
  ggplot(aes(x = value)) + 
  geom_histogram(stat  = "bin", fill = "steelblue") +
  theme_minimal()
