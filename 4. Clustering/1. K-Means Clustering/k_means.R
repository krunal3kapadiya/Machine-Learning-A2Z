# Importing the dataset
dataset = read.csv('Mall_Customers.csv')
dataset = dataset[4:5]

# Using the elbow method to find optimal number of clusters
set.seed(6)
wcss = vector()
for (i in 1:10) wcss[i] = sum(kmeans(dataset, i)$withinss)
plot(1:10,
     wcss,
     type = 'b',
     main = paste('The Elbow Method'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')

# Fitting K-Means to the dataset
set.seed(29)
kmeans = kmeans(x= dataset, centers = 5)
y_kmeans = kmeans$cluster

# Visualizing the cluster
library(cluster)
clusplot(dataset,
         y_kmeans,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste0('Cluster of customers'),
         xlab = 'Annual Income',
         ylab = 'Spending Score')