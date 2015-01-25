require(rCharts)

n = 100
g = 6
set.seed(g)

par(mfrow=c(2,1))
d <- data.frame(x = unlist(lapply(1:g, function(i) rnorm(n/g, runif(1)*i^2))), y = unlist(lapply(1:g, function(i) rnorm(n/g, runif(1)*i^2))) )
plot(d)

mydata <- d
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,centers=i)$withinss)

plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

clusters <- kmeans(d, centers = 4, iter.max = 10, nstart = 100)
d$cluster <- factor(clusters$cluster)

p2 <- nPlot(x ~ y, group = 'cluster', data = d, type = 'scatterChart')
p2$xAxis(axisLabel = "x")
p2$yAxis(axisLabel = "y")
p2