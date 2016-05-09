library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Linear model simulation"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(h4(strong("Parameters:")),

      numericInput("alpha", 
                   "Intercept", 
                   0),
      numericInput("beta", 
                   "β", 
                   10),
      numericInput("n", 
                   "Sample size", 
                   1000, 
                   min=2),
      numericInput("sigma", 
                   "Error standard deviation", 
                   3,
                   min=.00001),
      
      h4(strong("Assumption Violations:")),
      checkboxInput("heteroschedasticity", 
                    "Error term dependent on x", 
                    FALSE), 
      checkboxInput("outliersy", 
                    "Outliers on error term", 
                    FALSE), 
      checkboxInput("errornonnorm", 
                    "Non-normal distribution of error terms", 
                    FALSE), 
      checkboxInput("omittedvariable", 
                    "Omitted predictor", 
                    FALSE), 
      checkboxInput("nonlinear", 
                    "Non linearity of the relationship", 
                    FALSE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("simPlot")
    )
  )
))