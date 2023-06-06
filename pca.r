#PCA Lecture notes 4/25/2019
#PCA is a form of dimensionality reduction
#Dimensionality reduction is the most common use of unsupervised learning

#PCA is built into R, function: prcomp()

#PCA is trying to get just one vector to determine all the others or something
data(mtcars)
mtcars.pca <- prcomp(mtcars)
mtcars.rotated <- as.data.frame(mtcars.pca$x) #PC stands for principal componet
mtcars.vectors <- as.data.frame(mtcars.pca$rotation) #This is a rotation matrix

#############################################
#Stdev Plot
barplot(mtcars.pca$sdev)

#############################################
#Biplot
#Jk don't do these two lines cause you gotta get it on github
#library(ggbiplot)
#ggbiplot(mtcars.pca, obs.scale = 0.5, var.scale = 1, labels=rownames(mtcars)

