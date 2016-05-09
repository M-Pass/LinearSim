The linear simulation app is built to explore how linear regression is affected by the strength of a relationship, the sample size, and its own assumptions. 

The app simulates two variables (x and y) so that y is dependent on x. The relationship can be actually linear, or be based on the logarithm of x. 
The user can specify: 
- coefficients of the (log)linear model
- sample size
- standard deviation of the error term. 

The user can also insert violations of the linear regression assumptions, and see how model fit is affected. Possible violations to include are: 
- heteroschedasticity (dependency of the error term on x) 
- a few observation that have a huge error term (possible measurement error?)
- non-normality of the error term distribution (the alternative used is an exponential distribution)
- presence of a predictor of y not included in the model and correlated roughly .5 with x. 
- non-linearity of the actual relationship between x and y. 

The model is fitted as a linear model -- even if the linearity violaton is included -- and a scatterplot is shown with both the regression line and a smoothed function that will more closely follow the simulated data. At the top of the plot, the 95% confidence interval for the coefficient of the linear regression is reported.
