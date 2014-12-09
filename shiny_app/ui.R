library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Ebola Outbreak in Africa"),
  
  sidebarLayout(
    selectInput("cat", 
                label = "Category",
                choices = c("Cases", "Deaths"),
                selected = "Cases"),
    
    # Show a plot of the generated distribution
      mainPanel(
        plotOutput("ebPlot"))
    )
  ))