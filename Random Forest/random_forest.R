# Random Forest Regression

# Import the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2: 3]

# Visualizing the Regression Model results (for higher resolution and smoother curve)
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level + x_grid)))) +
  ggtitle('Truth or Bluff (Random Forest)') +
  xlab('Level') +
  ylab('Salary')