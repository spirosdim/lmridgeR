#' A reference class to perform ridge regression.
#' 
#' @import methods
#' @import mlbench caret leaps
#' @field formula formula: Object dependent and indepedent variables.
#' @field data data.frame: All the data. 
#' @field dname vector: The names of the variables.
#' @field lambda: parameter lambda
#' @field X matrix: Independent variables.
#' @field y matrix: Dependent variable.
#' @field b_ridge matrix: Estimation of the regression coefficients.
#' @field y_hat matrix: Estimation of the y values.
#' @field e_hat matrix: Estimation of the error variable i.e. the residuals.
#' @field m vector: mean of each covariate.
#' @field s vector: sd of each covariate.
#' @export ridgereg
#' @exportClass ridgereg
ridgereg <- setRefClass("ridgereg", 
                        
                        fields =list(formula="formula", 
                                     data="data.frame",
                                     lambda="numeric",
                                     dname="vector",
                                     X="matrix",
                                     y="matrix",
                                     b_ridge="matrix",
                                     y_hat="matrix",
                                     e_hat="matrix",
                                     m="vector",
                                     s="vector"),
                        
                        methods = list(
                          
                          initialize = function(formula, data, lambda) {
                            'Initialize the values'
                            formula <<- formula
                            data <<- data
                            lambda <<- lambda
                            dname <<- deparse(substitute(data))
                            X <<- model.matrix(formula,data)
                            y <<- as.matrix(data[all.vars(formula,data)[1]])
                            
                            # we save the mean and sd of each feature
                            # to normalize any newdata afterwords
                            m <<- apply(X[,-1], 2, mean)
                            s <<- apply(X[,-1], 2, sd)
                            
                            #Normalize covariates
                            X <<- apply(X, 2, function(x)(x-mean(x))/sd(x))
                            X[,1] <<- 1
                            
                            p <- ncol(X)  # number of covariates
                            I <- diag(p)  # p×p identity matrix
                            
                            #Regressions coefficients:
                            b_ridge <<- solve(t(X) %*% X + lambda * I) %*% t(X) %*% y 
                            
                            #The fitted values:
                            y_hat <<- X %*% b_ridge   
                            
                            #The residuals:
                            e_hat <<- y-y_hat
                            
                          },
                          
                          print = function(){
                            'Print the coeff that needed'
                            cat("Call:", "\n")
                            cat("linreg(formula = ", all.vars(formula)[1], " ~ ", 
                                paste(all.vars(formula)[-1], collapse = " + "),
                                ", data = ", dname,")", "\n\n", sep="")
                            cat("Coefficients:","\n")
                            cat(format(labels(b_ridge[,1]), width=10, justify="right"), "\n")
                            cat(format(round(b_ridge,2), width=17, justify="right"))
                            
                          },
                          
                          predict = function(newdata=NA){ #argument: the newdata without the bias column
                            'Return the predicted values'
                            
                            if(all(is.na(newdata))==TRUE){
                              return(as.vector(y_hat))
                            }
                            # give data to predict the y
                            else {
                              #we have to normalize the new data such as the training data
                              #newdata <- apply(data.matrix(newdata), 2,function(x)(x - m)/s)
                              
                              dm <- m
                              for(i in 1:(nrow(newdata)-1)) dm <- rbind(dm,m)
                              ds <- s
                              for(i in 1:(nrow(newdata)-1)) ds <- rbind(ds,s)
                              newdata <- (data.matrix(newdata)- dm)/ds
                              
                              d1 <- matrix(rep(1,nrow(newdata)))
                              colnames <-"(Intercept)"
                              newdata <- data.matrix(cbind(d1,newdata))
                              #we return the y values not in the original scale
                              return(as.vector(newdata %*% b_ridge))
                            }
                          },
                          
                          coef = function(){
                            'Return the coefficient'
                            # these are not on the original scale
                            c <- as.vector(b_ridge)[-1]  #if we want the b_0 just remove the [-1]
                            names(c) <- colnames(X[,-1])
                            return(c)
                          }
                        )
                        
)