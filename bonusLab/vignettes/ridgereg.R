## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, eval=FALSE)

## ------------------------------------------------------------------------
#  library(mlbench)
#  library(caret)
#  library(bonusLab)
#  data(BostonHousing)

## ------------------------------------------------------------------------
#  split_point <- caret::createDataPartition(BostonHousing$medv,p = 0.8,list = F)
#  training_data <- BostonHousing[split_point,]
#  testing_data <- BostonHousing[-split_point,]

## ------------------------------------------------------------------------
#  lm_fit <- train(x= training_data[,c(1:13)],y=training_data[,14], method = "lm")
#  summary(lm_fit)

## ------------------------------------------------------------------------
#  lm_fit_forward <- train(medv~crim+zn+indus+chas+nox+age+
#                          dis+rad+tax+ptratio+lstat, data = training_data, method = "leapForward")
#  print(lm_fit_forward)

## ------------------------------------------------------------------------
#  lm_fit$results
#  lm_fit_forward$results

## ------------------------------------------------------------------------
#  Ridge_reg <- list(type = "Regression",
#                library = "bonusLab",
#                loop = NULL,prob=NULL)
#  Ridge_reg$parameters <- data.frame(parameter='lambda',class='numeric',label='lambda')
#  Ridge_reg$grid <- function(x, y, len = NULL, search = "grid"){
#    data.frame(lambda=c(0,0.1,0.5,1,1.5,2,3,4,5))
#  }
#  Ridge_reg$fit <- function(x, y, wts, param, lev, last, weights, classProbs, ...){
#    dat <- as.data.frame(x)
#    dat$yp <- y
#    output <- ridgereg$new(yp~.,data=dat,lambda = param$lambda)
#    return(output)
#  }
#  Ridge_reg$predict <- function(modelFit, newdata, preProc = NULL, submodels = NULL){
#    modelFit$predict(newdata)
#  }

## ------------------------------------------------------------------------
#  ridge_fit <- train(medv~crim+zn+indus+chas+nox+age+
#                          dis+rad+tax+ptratio+lstat, data = training_data, method = Ridge_reg)
#  print(ridge_fit)

## ------------------------------------------------------------------------
#  plot(x=ridge_fit$results[,1],ridge_fit$results[,2],
#       type="o", ylab="RMSE", xlab="lambda", main="")

## ------------------------------------------------------------------------
#  cross_control <- trainControl(method = "repeatedcv", number=10, repeats = 3)
#  ridge_fit_cross <- train(medv~crim+zn+indus+chas+nox+age+
#                          dis+rad+tax+ptratio+lstat, data = training_data,
#                          method=Ridge_reg,trControl = cross_control,preProc = c("scale","center"))
#  print(ridge_fit_cross)

## ------------------------------------------------------------------------
#  plot(x=ridge_fit_cross$results[,1],ridge_fit_cross$results[,2],
#       type="o", ylab="RMSE", xlab="lambda", main="")

## ------------------------------------------------------------------------
#  preds <- predict(lm_fit, testing_data[,1:13])
#  postResample(pred = preds, obs = testing_data[,14])

## ------------------------------------------------------------------------
#  preds <- predict(ridge_fit, testing_data[,1:13])
#  postResample(pred = preds, obs = testing_data[,14])

## ------------------------------------------------------------------------
#  preds <- predict(ridge_fit_cross, testing_data[,1:13])
#  postResample(pred = preds, obs = testing_data[,14])

