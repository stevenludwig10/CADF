#include <Rcpp.h>
#include <cmath>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]



// [[Rcpp::export]]
NumericVector myseq(int first, int last) {
  NumericVector y(abs(last - first) + 1);
  if (first < last) 
    std::iota(y.begin(), y.end(), first);
  else {
    std::iota(y.begin(), y.end(), last);
    std::reverse(y.begin(), y.end());
  }
  return y;
}

// [[Rcpp::export]]
NumericVector zeros(int x) {
  NumericVector out(x);
  
  for(int i = 0; i < x; ++i) {
    out[i] = 0;
  }
  return out;
}

// [[Rcpp::export]]
NumericVector ones(int len) {
  NumericVector out(len);
  
  for(int i = 0; i < len; ++i) {
    out[i] = 0;
  }
  return out;
}

// [[Rcpp::export]]
NumericVector create_discount_vector(double amount, int duration, double discountrate) {
  
  NumericVector t = myseq(1, duration);
  NumericVector mt = zeros(duration);
  
  for (int i = 0; i < t.length(); i++)
  {
    mt[i] = amount / std::pow((1 + discountrate), t[i]);
  }
  
  return mt;
  
  
}

//[[Rcpp::export]]
NumericVector calculate_St_vector(NumericVector r)
{
  NumericVector s = ones(r.length());
  
  for (int i = 1; i < r.length(); i++)
  {
    
    s[i] = r[i - 1] * s[i - 1];
    
    
  }
  
  return s;
}

// [[Rcpp::export]]
DataFrame retention_simulator(double MonthlyPayment, double DiscountRate, int NumberMonths, NumericVector RetentionRates){
  NumericVector m = create_discount_vector(MonthlyPayment, NumberMonths, DiscountRate);
  NumericVector p = myseq(1, NumberMonths);
  NumericVector r = RetentionRates;
  NumericVector scf = ones(NumberMonths);
  
  NumericVector s = cumprod(r[Range(0,NumberMonths-2)]);
  s.push_front(1);
  
  NumericVector f = diff(s) * -1;
  f.push_back(0);
  
  
  scf[0] = MonthlyPayment;
  
  for( int i=1; i<p.size(); i++){
    scf[i] = s[i] * m[i-1];
  }
  
  DataFrame df = DataFrame::create( 
    Named("t") = p,
    Named("Retention_Rate") = r,
    Named("Survival") = s,
    Named("Probability") = f,
    Named("SurvCashFlow") = scf);
    
    return df;
}

