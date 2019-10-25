ridgereg <- setRefClass("ridgereg", 
                        
                        fields =list(formula="formula", 
                                     data="data.frame",
                                     lambda="numeric",
                                     dname="vector",
                                     X="matrix",
                                     y="matrix",
                                     b_ridge="matrix",
                                     y_hat="matrix",
                                     e_hat="matrix"),
                        
                        methods = list(
                          
                          initialize = function(formula, data, lambda) {
                            'Initialize the values'
                            formula <<- formula
                            data <<- data
                            lambda <<- lambda
                            dname <<- deparse(substitute(data))
                            X <<- model.matrix(formula,data)
                            y <<- as.matrix(data[all.vars(formula,data)[1]])
                            
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
                          
                          
                          coef = function(){
                            'Return the coefficient'
                            # these are not on the original scale
                            c <- as.vector(b_ridge)[-1]  #if we want the b_0 just remove the [-1]
                            names(c) <- colnames(X[,-1])
                            return(c)
                          }
                        )
                        
)