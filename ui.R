library(shiny)

shinyUI(pageWithSidebar(
        
        headerPanel("K-means Explorer"),
        
        sidebarPanel(
                sliderInput('seed', 'Select random seed (1-9)', min=1, max=9,
                            value=min(1, 9, step=1)), 
                sliderInput('cluster', 'Select number of clusters', min=1, max=9,
                            value=min(1, 9, step=1)),
                checkboxInput('checkbox', label = 'Display clusters', value = FALSE)
        ),
        
        mainPanel(
                tabsetPanel(
                        tabPanel("Plot", plotOutput("plot")), 
                        tabPanel("Instructions", htmlOutput("instructions")))
                                        
        )
                
))