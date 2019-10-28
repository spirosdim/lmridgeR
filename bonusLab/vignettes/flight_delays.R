## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, eval=FALSE)

## ------------------------------------------------------------------------
#  library(bonusLab)
#  library(mlbench)
#  library(caret)
#  library(dplyr)
#  library(nycflights13)

## ------------------------------------------------------------------------
#  f_df<-dplyr::tbl_df(nycflights13::flights)
#  f_df<-dplyr::select(f_df, month, day, sched_dep_time, sched_arr_time, arr_delay, carrier,
#                      tailnum, origin, dest, distance,time_hour)
#  w_df<-dplyr::tbl_df(nycflights13::weather)
#  w_df<-dplyr::select(w_df,origin,temp,dewp,humid,wind_dir,wind_speed,wind_gust,precip,
#                      pressure,visib,time_hour)

## ------------------------------------------------------------------------
#  df<-f_df %>%
#    left_join(w_df,by=c("origin","time_hour")) %>%
#    filter(!is.na(arr_delay))
#  
#  df<-dplyr::select(df,  sched_dep_time, sched_arr_time, arr_delay,  distance,
#                    temp, dewp, humid, wind_dir, wind_speed, pressure,visib)

## ------------------------------------------------------------------------
#  # delete all NAs
#  df<-df %>%
#    filter(!is.na(sched_dep_time), !is.na(sched_arr_time), !is.na(arr_delay), !is.na(temp),
#           !is.na(distance), !is.na(dewp), !is.na(humid), !is.na(wind_dir), !is.na(wind_speed),
#           !is.na(pressure), !is.na(visib))

## ------------------------------------------------------------------------
#  df<-df %>% head(100000)
#  df<-as.data.frame(df)

## ------------------------------------------------------------------------
#  trainIndex<-createDataPartition(df$arr_delay, p = .8, list = FALSE, times = 1)
#  dfTrain <- df[ trainIndex,]
#  dfTestVal  <- df[-trainIndex,]
#  
#  trainIndex<-createDataPartition(dfTestVal$arr_delay, p = .75, list = FALSE, times = 1)
#  dfValid <- dfTestVal[ trainIndex,]
#  dfTest <- dfTestVal[ -trainIndex,]

## ------------------------------------------------------------------------
#  # l <- c(0,0.5,1,2,5)
#  #y_hat <- matrix(0,nrow=length(l),ncol=ncol(dfTestVal[,-3]))
#  # for(i in 1:length(l)){
#  #   y_hat[i,] <- ridgereg(arr_delay~.,dfTrain, lambda=l[i])$predict(dfTestVal[,-3])
#  # }
#  
#  
#  ridge_l0 <- ridgereg(arr_delay~.,dfTrain, lambda=0)
#  ridge_l05 <- ridgereg(arr_delay~.,dfTrain, lambda=1)
#  ridge_l1 <- ridgereg(arr_delay~.,dfTrain, lambda=5)
#  ridge_l2 <- ridgereg(arr_delay~.,dfTrain, lambda=10)
#  ridge_l5 <- ridgereg(arr_delay~.,dfTrain, lambda=15)

## ------------------------------------------------------------------------
#  e0 <- (dfValid[,3]-ridge_l0$predict(dfValid[,-3]))
#  e05 <- (dfValid[,3]-ridge_l05$predict(dfValid[,-3]))
#  e1 <- (dfValid[,3]-ridge_l1$predict(dfValid[,-3]))
#  e2 <- (dfValid[,3]-ridge_l2$predict(dfValid[,-3]))
#  e5 <- (dfValid[,3]-ridge_l5$predict(dfValid[,-3]))

## ------------------------------------------------------------------------
#  ers <- cbind(e0=e0,e05=e05,e1=e1,e2=e2,e5=e5)

## ------------------------------------------------------------------------
#  # Function that returns Root Mean Squared Error
#  rmse <- function(error){
#      sqrt(mean(error^2))
#  }

## ------------------------------------------------------------------------
#  rmses <- numeric()
#  for(i in 1:5){
#    rmses <- c(rmses, rmse(ers[,i]))
#  }
#  
#  rmses

## ------------------------------------------------------------------------
#  
#  rmse(dfTrain[,3]-ridge_l5$predict())

## ------------------------------------------------------------------------
#  rmse(dfTest[,3]-ridge_l5$predict(dfTest[,-3]))

