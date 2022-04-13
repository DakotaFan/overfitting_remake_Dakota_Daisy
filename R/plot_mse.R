#define number of folds to use for k-fold cross-validation
plot_mse <- function(data, d = 20, k =5){
K <- k

#define degree of polynomials to fit
degree <- d

#create k equal-sized folds
folds <- cut(seq(1,nrow(data)),breaks=K,labels=FALSE)

#create object to hold MSE's of models
mse_test = matrix(data=NA,nrow=K,ncol=degree)
mse_train = matrix(data=NA,nrow=K,ncol=degree)

#Perform K-fold cross validation
for(i in 1:K){
  
  #define training and testing data
  testIndexes <- which(folds==i,arr.ind=TRUE)
  testData <- data[testIndexes, ]
  trainData <- data[-testIndexes, ]
  
  #use k-fold cv to evaluate models
  for (j in 1:degree){
    fit.train = lm(score ~ poly(hours,j), data=trainData)
    fit.test = predict(fit.train, newdata=testData)
    fit.train = predict(fit.train, newdata=trainData)
    mse_test[i,j] = mean((fit.test-testData$score)^2) 
    mse_train[i,j] = mean((fit.train-trainData$score)^2)
    

  }
}

test <- colMeans(mse_test)
train <- colMeans(mse_train)
df <- data.frame(degree = 1:d, test_mse = test, train_mse = train)
p <- ggplot(df, aes(degree)) + 
  geom_line(aes(y = train_mse, colour = "train_mse"), size = 2) + 
  geom_line(aes(y = test_mse, colour = "test_mse"), size = 2)+
  ggtitle("Model performance on training and testing data with K=5 fold validation") +
  xlab("Degree") +
  ylab("MSE")+
  theme(plot.title = element_text(hjust = 0.5))

return(p)


}