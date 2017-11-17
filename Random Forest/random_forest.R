# Random Forest Regression

# Import the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2: 3]

# Fitting random forest regression to the dataset
# install.packages("randomForest")
# .libPaths()

library(randomForest)
set.seed(1234)
regressor = randomForest(x = dataset[1],
                         y = dataset$Salary,
                         ntree = 500)

# Predicting a new result
y_pred = predict(regressor, data.frame(level = 6.5))

# Visualizing the Regression Model results (for higher resolution and smoother curve)
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Random Forest)') +
  xlab('Level') +
  ylab('Salary')