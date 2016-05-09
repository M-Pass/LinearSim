library(shiny)
library(car)

shinyServer(function(input, output) {
  
  # The app simulates two variables (x and y) so that y is dependent on x. 
  # The user specifies some parameters for the variables (coefficients of the (log)linear 
  # model, sample size and standard deviation of the error term). 
    
  # The user can also insert assumption violations of the linear regression, and see how model
  # fit is affected. Possible violations to include are heteroschedasticity (dependency of the error
  # term on x), a few observation that have a huge error term, non-normality of the error term distribution
  # (the alternative used is an exponential distribution), presence of a predictor of y not included 
  # in the model, and non-linearity of the actual relationship between x and y. 
  # The model is fitted as a linear model -- even if the linearity violaton is included -- and a 
  # scatterplot is shown with both the regression line and a smoothed function that will more
  # closely follow the simulated data. At the top of the plot, the 95% confidence interval for the
  # coefficient of the linear regression is reported.
  
  output$simPlot <- renderPlot({
      
      alpha <- input$alpha
      beta <- input$beta
      n <- input$n
      sigma <- input$sigma
      
      heteroschedasticity <- input$heteroschedasticity
      outliers <- input$outliers
      errornonnorm <- input$errornonnorm
      omittedvariable <- input$omittedvariable
      nonlinearity <- input$nonlinear
      outliersy <- input$outliersy
      
      x <- rnorm(n, mean=10, sd=3) # In the future, we could try a non-normally distributed sample...
      
      if (!errornonnorm)
      {
      error <- rnorm(n, sd=sigma)
      }
      
      if(errornonnorm)
      {
          error <- rexp(n, rate=1/sigma) # If the user selects non-normality of the error term, 
                                         # it will be generated as an exponential. Note how the rate
                                         # is 1/sigma: this ensures that the sd of the error term is
                                         # the same for the normally and non-normally distributed
                                         # terms. 
      }
      
      if (heteroschedasticity)
      {error <- error * x/10}
      
      out <- 0
      if(outliersy)
      {error <- error + rt(n, 1) # the t distribution is great for simulating a few outliers!
      }
      
      if(omittedvariable)
      {
          x2 <- rnorm(n, 20, 3)
          x2 <- .5*x + sqrt(.5)*x2
          std <- sd(error)
          error <- error + beta*x2
          error <- error/sd(error)*std # This is to keep the sd of the error term constant for all
                                       # options. 
      }
      
      if (!nonlinearity)
      {
          y <- alpha + beta*x + error
      }
      if (nonlinearity) 
      {
          # If the user selects the relationship to be non-linear, it will be modeled as a 
          # log-linear dependency. 
          y <- alpha + beta*log(abs(x)) + error
      }
      
      fit <- lm(y~x)
      
      interval <- round(confint(fit, 2), 2)
     scatterplot(x, y, 
                       main=paste("95% confidence interval of β:", interval[1], " - ", interval[2]))
      
  })
})