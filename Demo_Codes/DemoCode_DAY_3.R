###############################################
###############################################
## Fitting models ##

## the t-test for iris ##
## preparing data
d.iris.2.sp <- iris[iris$Species != "setosa", ]
## same as
d.iris.2.sp_same <- iris[iris$Species %in% c("versicolor", "virginica"), ]
## 
all.equal(d.iris.2.sp, d.iris.2.sp_same)


## visualising data
boxplot(Sepal.Length ~ Species, data = d.iris.2.sp)
str(d.iris.2.sp)
table(d.iris.2.sp$Species)
## drop unused levels
boxplot(Sepal.Length ~ Species, 
        data = droplevels(d.iris.2.sp))
## --> we will look at factors later


## running the test
t.test(Sepal.Length ~ Species, data = d.iris.2.sp)
## - note scientific notation (i.e. 2e-07 = 2 * 10^(-7) = 0.0000002)
## - note the test actually carried out
##
t.test(Sepal.Length ~ Species, var.equal = TRUE,
       data = d.iris.2.sp) 
## - NB: the machine runs the t-test ...
## YOU must understand-interpret-communicate the resutls


## the linear model for iris ##
## visualise data
pairs(Sepal.Length ~ ., data = d.iris.2.sp)
pairs(Sepal.Length ~ ., data = d.iris.2.sp,
      upper.panel = panel.smooth)
## fit LM
lm.iris <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width + Species,
              data = d.iris.2.sp)
## get results
summary(lm.iris)

## further "model-related" functions
lm.iris.no.species <- lm(Sepal.Length ~ Sepal.Width + Petal.Length +
                         Petal.Width,
                         data = d.iris.2.sp)
## same as 
lm.iris.no.species_same <- update(lm.iris, . ~ . - Species)

## comparing models
anova(lm.iris.no.species, lm.iris)

## getting fitted values
fit.iris <- fitted(lm.iris)
head(fit.iris)
fit.iris.no.species <- fitted(lm.iris.no.species)
head(fit.iris.no.species)

## model diagnostics
plot(lm.iris.no.species)
par(mfrow = c(2,2))
plot(lm.iris.no.species)
# dev.off()

## linear models are indeed lists
class(lm.iris)
is.list(lm.iris)



###############################################
###############################################
## Missing values ##

## airquality dataset ##
head(airquality)

anyNA(airquality)

## Column "Ozone"
anyNA(airquality$Ozone)
is.na(airquality$Ozone)
which(is.na(airquality$Ozone))

## NB: == NA does not work
airquality$Ozone[1:6] 
airquality$Ozone[1:6] == NA

## how many missing values?
sum(is.na(airquality$Ozone))
## NB: TRUE are then converted to ones and FALSE to zero
sum(c(TRUE, FALSE, FALSE, TRUE, FALSE))
mean(c(TRUE, FALSE, FALSE, TRUE, FALSE))

## setting NAs
airquality$Ozone[1]
airquality$Ozone[1] <- NA
airquality$Ozone[1]

## reading "incomplete" datasets
d.testNAs <- read.csv("../DataSets/dataset_NAs.csv", header = TRUE)
d.testNAs
## empty cells in numeric vectors are taken as NAs
## empty celly in string vectors are take as empty
## -999 is also a NAs

d.testNAs$Gender[d.testNAs$Gender == ""] <- NA
d.testNAs
is.na(d.testNAs$Gender)
## NB: there are differnt types subtypes of NAs, in practice for the user
## they are all the same 

## reading in -999 as an NA
d.testNAs_2 <- read.csv("../DataSets/dataset_NAs.csv", 
                        na.strings = c(-999, ""),
                        header = TRUE)
d.testNAs_2


## "simple" function can "remove" NAs
mean(d.testNAs_2$Age)
mean(d.testNAs_2$Age, na.rm = TRUE)


## "higher" functions work with na.action
lm.1 <- lm(Age ~ Gender, data = d.testNAs_2)
summary(lm.1)

lm.1 <- lm(Age ~ Gender, data = d.testNAs_2,
           na.action = na.fail)


## drop NAs
d.testNAs_2
na.omit(d.testNAs_2)

nrow(airquality)
airquality.no.NAs <- na.omit(airquality)
nrow(airquality.no.NAs)


## introduce *apply() functions (***)
apply(airquality, MARGIN = 2, FUN = anyNA)
apply(airquality, MARGIN = 1, FUN = anyNA)
apply(airquality, MARGIN = 2, FUN = is.na)
apply(airquality, MARGIN = 2, 
      FUN = function(x) {sum(is.na(x))})


## imputation
## Q: how would you proceed?
d.testNAs
d.testNAs$Gender[d.testNAs$FirstName == "Andrea"] <- "F"
d.testNAs 
## but actually Andrea...

mean.age <- mean(d.testNAs$Age, na.rm = TRUE)
mean.age
d.testNAs$Age[is.na(d.testNAs$Age)] <- mean.age
## but actually missing age ...