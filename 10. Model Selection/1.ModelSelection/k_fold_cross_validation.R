# k-fold cross validation

dataset = read.csv('Social_Network_Ads.csv')
dataset = dataset[3:5]

# encoding the target features as vector
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))

# splitting the dataset into the training set and test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split = TRUE)
test_set = subset(dataset, split = FALSE)

# feature scaling
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

# feature scaling
#install.packages('e1071')
library(e1071)
classifier = svm(formula = Purchased ~ .,
                 data = training_set,
                 type = 'C-classification',
                 kernel = 'radial')

# predicting the test set results
y_pred = predict(classifier, newdata = test_set[-3])

# making the confusion matrix
cm = table(test_set[, 3], y_pred)

# applying K-Fold cross validation
library(caret)
folds = createFolds(training_set$Purchased, k = 10)
cv = lapply(folds, function(x){
  training_fold = training_set[-x, ]
  test_fold = training_set[x, ]
  classifier = svm(formula = Purchased ~ .,
                   data = training_fold,
                   type = 'C-classification',
                   kernel = 'radial')
  y_pred = predict(classifier, newdata = test_fold[-3])
  cm = table(test_fold[, 3], y_pred)
  accuracy = (cm[1, 1] + cm[2, 2]) / (cm[1, 1] + cm[2, 2] + cm[1, 2] + cm[2, 1])
  return(accuracy)
  })

accuracy = mean(as.numeric(cv))