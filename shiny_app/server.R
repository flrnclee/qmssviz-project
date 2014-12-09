library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$ebPlot <- renderPlot({
    data <- switch(input$cat, 
                   "Cases"="Cases",
                   "Deaths"="Deaths")
    ebolaUse <- subset(ebolaData, ebolaData$Localite %in% "National" & ebolaData$Category %in% data)
    data <- ggplot(ebolaUse, aes(Date, Value))
    ebGph <- geom_line(aes(colour=factor(Country)), size=1)
    dateScale <- scale_x_date(breaks=date_breaks("months"), labels=date_format("%m/%d/%y"))
    labels <- labs(title="Ebola Outbreak in Africa Over Time", x="Date", y="Value", colour="Country")
    cols <- scale_colour_manual(values = c("#11887F", "#FC1325", "#670155"))
    format <- theme(panel.background = element_rect(fill="white"),
                    panel.grid.major = element_line(colour="#CFCFCF", linetype=2),
                    axis.line = element_line(size=0.25, colour="black"),
                    axis.title = element_text(family="Open Sans", size=14),
                    plot.title = element_text(family="Open Sans", size=18),
                    axis.text = element_text(family="Open Sans", size=12, colour="black"),
                    axis.ticks = element_line(size=0.25, colour="black"))     
    data + ebGph + cols + dateScale + labels  + format
  })
})