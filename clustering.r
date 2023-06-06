#Clustering unsupervised machine learning 4/23/2019
###################################
#K-Means
data(iris)

kmclusters <- kmeans(iris[,1:4], centers=3)

iris$km <- kmclusters$cluster

View(iris)


###################################
#Mean shift
require(meanShiftR)

meanShift <- meanShift(as.matrix(iris[,1:4]))

iris$ms <- meanShift$assignment

View(iris)


####################################
#DBSCAN
require(dbscan)

DB <- dbscan(iris[,1:4], eps = 1, minPts = 5)

iris$db <- DB$cluster

View(iris)


#####################################
#Gaussian Mixture
require(ClusterR)

gmm <- GMM(iris[,1:4], 3)

iris <- (cbind(iris, gmm$Log_likelihood))

View(iris)


#####################################
#Hierarchical Clustering
AHC <- hclust(dist(iris[,1:4]))

plot(AHC)