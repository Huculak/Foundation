# Created a File

install.packages("stringr", repos='http://cran.us.r-project.org')
library(stringr)

library(tidyverse)
# Part 1. Introductions

my.age <- 29
my.age

my.name <- 'Matt'
my.name

#Define a function called MakeIntroduction...

MakeIntroduction <- function(name, age) {
  paste("Hello, my name is", name, ", and I'm ", age, "years old!")
  
}

#Create a variable my.intro...

my.intro <- make_birthday_intro(my.name, my.age)
my.intro

#Create a variable casual.intro...

casual.intro <- sub("Hello, my name is", "Hey, I'm", my.intro)
casual.intro

#Create a variable capital.intro...

capital.intro <- str_to_upper(casual.intro)
capital.intro

#Create a variable intro.e.count...

intro.e.count <- str_count(my.intro, pattern = 'e')
intro.e.count
  

#Part 2. Books
#Create a variable name book...

book <- c("Siddhartha", "The Trial", "Darkness at Noon", "The Joke", "Kidnapped", "Starship Troopers")
book

#Create a variable top.three.books...

top.three.books <- book[c(1:3)]
top.three.books

#Create a variable book.reviews...

book.reviews <- paste(book, "is a great read!")
book.reviews

#Create a variable books.without.four...

books.without.four <- book[c(1:3,5:6)]
books.without.four

#Create a variable long.titles...

long.titles <- Length[book > 10 chars]

#Part 3 Squares

#Create a variable numbers...

numbers <- (1:201)
numbers

#Create a variable square.numbers...

squared.numbers <- numbers^2
squared.numbers




