library(shiny)

g <<- 4

shinyServer(function(input, output) {
                        
        output$plot <- renderPlot({
                n = 100
                g <- input$seed                        
                set.seed(g)
                d <- data.frame(x = unlist(lapply(1:g, function(i) rnorm(n/g, runif(1)*i^2))), y = unlist(lapply(1:g, function(i) rnorm(n/g, runif(1)*i^2))) )                        
                
                mydata <- d
                wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
                for (i in 2:15) wss[i] <- sum(kmeans(mydata,centers=i)$withinss)
                
                
                
                par(mfrow=c(2,1))
                if(input$checkbox) {
                        clusters <- kmeans(d, centers = input$cluster, iter.max = 10, nstart = 100)
                        d$cluster <- factor(clusters$cluster)
                        
                        plot(d$x ~ d$y, col = d$cluster)
                        
                } else {
                        plot(d$x ~ d$y)        
                }
                
                plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")
                
                
                
                
                                                
                
        }, height = 400, width = 600)
        
        output$clusters <- renderPlot({
                clusters <- kmeans(d, centers = input$Cluster, iter.max = 10, nstart = 100)
                d$cluster <- factor(clusters$cluster)
                
                plot(d$x ~ d$y, col = d$cluster)
                
        }, height = 400, width = 600)
        
        
        output$instructions <- renderUI({
                str1 <- paste("This is an app to try out the K-mean algorithm for clustering of data")
                str2 <- paste("1. Select a random seed to generate data by setting the slider to a number from 1 to 9.")
                str3 <- paste("2. Select the number of clusters to generate using the K-mean algorithm by setting the slider to a number from 1 to 9.")
                str4 <- paste("3. Display the clusters by checking the check box.")
                HTML(paste(str1, str2, str3, str4, sep = '<br/>'))
                
        }) 
        
})