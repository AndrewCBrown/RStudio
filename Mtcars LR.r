#mtcars linear regression done in class 3/21/2019

data(mtcars)
#Just looking at the graph to see how linear it is
plot(qsec ~ disp, mtcars)
#Breaking our data into sets
mtcars$group <- sample(1:4, nrow(mtcars), replace=TRUE)

#We did a pairs plot and saw that qsec and hp looked like an inverse function a little bit, not strong though

#Create a column for the inverse of hp
mtcars$invhp <- 1/mtcars$hp
plot(qsec ~ invhp, mtcars)

#Doing our first linear model now
fit <- lm(qsec ~ disp, mtcars)
summary(fit)

#honestly don't know what the rest of this is I'm just copying him
plot(qsec ~ disp, mtcars)
abline(fit)

#The period means do it by all the variables
#The group thing makes it only do one of our sets
multifit <- lm(qsec ~ ., mtcars[mtcars$group != 4,])
summary(multifit)

multifit <- lm(qsec ~ mpg + cyl + disp + hp + drat + wt + vs + am + gear + carb, mtcars[mtcars$group != 4,])
summary(multifit)

#trace can equal 0 or 1
bestfit <- step(multifit, direction="both", trace=1)
summary(bestfit)

predict(bestfit, mtcars[mtcars$group == 4,])
#After you run the line above you can look at the prediction of the qsec and compare them to how close they actually are
#If you did all this again it wouldn't change unless you changed the grouping or the group you call


#Now we're talking about doing a logistic regression
#glm(formula, data, family=binomial(link='logit'))
#predict(fit, newdata, type='response')

logfit <- glm(vs ~ mpg + cyl + disp + hp + drat + wt + qsec + gear + carb + invhp, mtcars[mtcars$group !=4,], family=binomial(link='logit'))
bestfit <- step(logfit, direction='both', trace=1)
mtcars$prediction <- predict(bestfit, mtcars, type='response')