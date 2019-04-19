# Created a File

install.packages("stringr", repos='http://cran.us.r-project.org')
library(stringr)

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
  

