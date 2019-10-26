context("ridgereg")

data("iris")

test_that("not the expected coefficients",{
  m1 <- ridgereg(formula=Petal.Length~Sepal.Width+Sepal.Length, 
                 data=iris,
                 lambda=0)
  m2 <- MASS::lm.ridge(formula=Petal.Length~Sepal.Width+Sepal.Length, 
                       data=iris,
                       lambda=0)
  expect_equal(round(m1$coef(),2),round(m2$coef),2)
})
