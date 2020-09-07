#########################
#########################
## "methods" functions ##

lm.iris <- lm(Sepal.Width ~ Species, data = iris)

summary(lm.iris)
summary(iris)
## same function, but different behaviour? How is that?
## summary is actually a *generic* function
## you can see a generic function as a "dispatch" function.
## it gets the job and then send to the right function

## e.g. you feed summary() with a linear model object. Than summary()
## calls summary.lm()

## let's see what methods exist for the generic function summary()
methods(summary)
## wow, very many methods

## note that the name of the method function is always summary.xxx, where
## xxx is the class of the object.
## So for example:
class(lm.iris)
## leads to summary.lm()

## so calling
summary(lm.iris) ## is fully equivalent to 
summary.lm(lm.iris)

## we can also see what methods are available for a given class e.g. "lm"
methods(class = "lm")
methods(class = "matrix")

## Many functions are actually generic functions:
## e.g. plot(), mean(), head().
## However, not all functions are generic functions:
methods(write.csv)



###############################
###############################
## writing your own function ##

## pseudo-code
# function.Name <- function(arguments){body of the function}

## a simple example
my.mean <- function(x){
  N <- length(x)
  Sum <- sum(x)
  computed.mean <- Sum / N
  return(computed.mean)
}

v.1 <- rnorm(n = 10^3, mean = 2)
v.2 <- rnorm(n = 10^3, mean = 2)

my.mean(v.1)


## return more than one object (and name them)
my.mean.sd <- function(x){
  N <- length(x)
  Sum <- sum(x)
  my.mean <- Sum / N
  my.sd <- sd(x)
  
  return(c(average = my.mean, std = my.sd))
}

my.mean.sd(v.1)


## several arguments (with and without defaults)
my.plot <- function(N = 100, ColOur = "blue"){
  sim.data <- runif(n = N)
  x <- 1:N
  plot(sim.data ~ x, col = ColOur)
}

my.plot(ColOur = "red")
my.plot(N = 20, ColOur = "blue")
my.plot()


## the "..." argument
my.plot(ColOur = "green", main = "Some sim data")

my.plot_2 <- function(N = 100, ColOur, ...){
  sim.data <- runif(n = N)
  x <- 1:N
  plot(sim.data ~ x, col = ColOur, ...)
}

my.plot_2(ColOur = "green", main = "Some sim data")


## further details
## debug() and traceback()
## note that "x" only exist within the function (in its environment)
## the object returned can also a vector/list/..



#################
#################
## source code ##

## to get the source code of a function, type its name without round brakets

lm
my.plot
write.csv
summary ## the generic function
summary.lm ## the method function



######################################
######################################
## A bit more on {dplyr} and friends ##
library(dplyr)

## selecting and filtering data ##
head(airquality)
airquality %>% 
  select(Ozone, Solar.R) %>% 
  head()

airquality$Temp.Kelvin <- airquality$Temp + 273.15
airquality %>% 
  filter(Ozone >= 90) %>% 
  select(Ozone, contains("Temp"))
## see also starts_with(), ends_with(), ...


## arranging data ##
airquality %>% 
  filter(Ozone >= 80) %>% 
  select(Ozone, contains("Temp")) %>% 
  arrange(Ozone)

airquality %>% 
  filter(Ozone >= 80) %>% 
  select(Ozone, contains("Temp")) %>% 
  arrange(desc(Ozone))
## some ties for Ozone (e.g. 97 and 85)

airquality %>% 
  filter(Ozone >= 80) %>% 
  select(Ozone, contains("Temp")) %>% 
  arrange(desc(Ozone), Temp)


## get top N observations ##
iris %>% 
  top_n(n = 5, wt = Sepal.Width)

iris %>% 
  group_by(Species) %>% 
  top_n(n = 2, wt = Sepal.Width)
## see also top_frac(), ...


## summarising data ##
mean(iris$Sepal.Length)

iris %>% 
  summarise(mean(Sepal.Length))

iris %>% 
  summarise(mean.Sepal.Length = mean(Sepal.Length),
            sd.Sepal.Length = sd(Sepal.Length))

iris %>% 
  group_by(Species) %>% 
  summarise(mean.Sepal.Length = mean(Sepal.Length))

iris %>% 
  filter(Petal.Length > 5) %>% 
  group_by(Species, .drop = FALSE) %>% 
  summarise(N = n())

iris %>% 
  filter(Petal.Length > 5 | Sepal.Length <= 6) %>% 
  group_by(Species, .drop = FALSE) %>% 
  summarise(N = n())

## adding new variables to a data frame ##
## e.g. let's say Sepal.Length is in inches
iris_2 <- iris %>% 
  mutate(Sepal.Length.cm = cm(Sepal.Length))
head(iris_2)


## replacing NAs ##
d.testNAs_2 <- read.csv("../DataSets/dataset_NAs.csv", 
                        na.strings = c(-999, ""),
                        header = TRUE)
d.testNAs_2

library(tidyr)
d.testNAs_2 %>%
  replace_na(list(Age = 100,
                  Salary = 0))
d.testNAs_2 %>%
  replace_na(list(Age = 100,
                  Salary = 0,
                  Gender = "unknown"))
class(d.testNAs_2$Gender)
levels(d.testNAs_2$Gender)
## factors have fixed number of levels

## it is easier to work with strings...
d.testNAs_2$Gender.char <- as.character(d.testNAs_2$Gender)
d.testNAs_2 %>%
  replace_na(list(Age = 100,
                  Salary = 0,
                  Gender.char = "unknown"))

## note that there is also a function replace
replace(x = d.testNAs_2$Gender.char,
        list = d.testNAs_2$Gender == "M",
        values = "Male")
## no example :( for this function...



#########################
#########################
## Regular expressions ##

v.char <- c("Anna", "Anna ", "Johnny Cashout", "12 Luc @")
## number of characthers
nchar(v.char)

## get first three charcters
substr(v.char, start = 1, stop = 3)

## contains "c" 
grepl(v.char, pattern = "c")

## contains "c" (which element?)
grep(v.char, pattern = "c")

## contains "c" or "C"
grepl(v.char, pattern = "c", ignore.case = TRUE)

## starts with "a"
grep(v.char, pattern = "^A")

## ends with "t"
grep(v.char, pattern = "t$")

## starts with a letter (any letter, any case)
grep(v.char, pattern = "^[A-z]")

## starts with a number
grep(v.char, pattern = "^[0-9]")

## substitute some text
gsub(v.char, pattern = "Anna", replacement = "Annamaria")


## very fancy... ##
## extract a group
v.char.2 <- c("agagamemem 12 Euro",
              "A 13 CHF",
              "ZZ 24 Dollars")
gsub(v.char.2, pattern = "\\s", replacement = "--")
## gets the empty space and replaces it with ""

gsub(v.char.2, pattern = "([A-z]+\\s)([0-9]+)(.+)", 
     replacement = "\\2" )
## finds 3 groups 
## 1. any letters one several times ended by an empty space
## 2. any number one or several times
## 3. anything (number of letter) one or several times
## replace all with the second group
