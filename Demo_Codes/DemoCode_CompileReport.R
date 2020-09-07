#########################################
#########################################
## Use that R-code to compile a report ##

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


