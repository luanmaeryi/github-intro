#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double approx_pi_c(double N);
// [[Rcpp::export]]
NumericMatrix gibbs_c(int N, int thin);
// [[Rcpp::export]]
double wmean_cpp(NumericVector x, NumericVector w);

//Exercise1
double wmean_cpp(NumericVector x, NumericVector w)
{
  int n = x.size();
  double total = 0;
  double total_w = 0;
  for (int i = 0; i < n; i++)
  {
    total+=x[i]*w[i];
    total_w+=w[i];
  }
  return total/total_w;
}

//Exercise 2
NumericMatrix gibbs_c(int N, int thin)
{
  NumericMatrix mat(N,2);
  double x = 0;
  double y = 0;
  for(int i=0;i<N;i++)
  {
    for (int j = 0; j < thin; j++)
    {
      x=Rcpp::rgamma(1, 3, 1 / (y * y + 4))[0];
      //x=R::rgamma(3, 1 / (y * y + 4)); //equivalent
      y=rnorm(1, 1 / (x + 1), 1 / sqrt(2 * (x + 1)))[0];
      
    }
    mat(i,0)=x;
    mat(i,1)=y;
  }
  return mat;
}

//Exercise 3
double approx_pi_c(double N)
{
  NumericVector x = runif(N);
  NumericVector y = runif(N);
  NumericVector d = sqrt(pow(x,2) + pow(y,2));
  return 4 * sum(d < 1.0) / N;
}

