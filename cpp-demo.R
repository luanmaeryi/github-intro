
#avoid using a non-named function
#apply(M,1,\(x) sum(x^2))


path <- here::here("github-intro", "cpp-demo.cpp")
sourceCpp(path)

x<-seq(1:10000)
w<-rep(1/10000,10000)
wmean_r <- function(x, w){
  n <- length(x)
  total <- total_w <- 0
  for (i in 1:n){
    total <- total + x[i] * w[i]
    total_w <- total_w + w[i]
  }  
  total/total_w
}

bm<-bench::mark(wmean_r(x,w), wmean_cpp(x,w),weighted.mean(x,w))


plot(bm)


gibbs_r <- function(N, thin) {
  mat <- matrix(nrow = N, ncol = 2)
  x <- y <- 0
  
  for (i in 1:N) {
    for (j in 1:thin) {
      x <- rgamma(1, 3, y * y + 4)
      y <- rnorm(1, 1 / (x + 1), 1 / sqrt(2 * (x + 1)))
    }
    mat[i, ] <- c(x, y)
  }
  mat
}

gibbs_r(100,100)
gibbs_c(100,100)


set_seed <- function(expr){
  set.seed(1)
  eval(expr)
}

set_seed(gibbs_r(100,10)) 
set_seed(gibbs_c(100,10))

bm2<-bench::mark(set_seed(gibbs_r(100,10)), set_seed(gibbs_c(100,10)))

plot(bm2)

#
approx_pi_r <- function(N) {
  x <- runif(N)
  y <- runif(N)
  d <- sqrt(x^2 + y^2)
  return(4 * sum(d < 1.0) / N)
}

set.seed(1)
approx_pi_r(1000)
approx_pi_c(1000)

bm3<-bench::mark(set_seed(approx_pi_r(1000)), set_seed(approx_pi_c(1000)))
plot(bm3)
