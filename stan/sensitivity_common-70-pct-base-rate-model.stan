data {
  int<lower=0> J;                     // number of systems
  int<lower=0> K;                     // number of measures
  int<lower=0> NN;                    // total observations
  int n[NN];                          // sample size
  int y[NN];                          // successes
  int j[NN];                          // system number 
  int k[NN];                          // measure number
  real beta[K];                       // pre-specified measure difficulty - this forces each measure to be compared to a given base pass rate rather than an estimated one
}
parameters {
  real theta[J];                      // system quality parameter
  real<lower=0> sigmasq_theta;        // must be positive
}
transformed parameters {
  real<lower=0> sigma_theta;
  real mu_ijk[NN];
  
  sigma_theta = sqrt(sigmasq_theta);
  
for (ii in 1:NN) {
    mu_ijk[ii] = theta[j[ii]] - beta[k[ii]]; // parametrize the mean
  }  
}
model {
  sigmasq_theta ~ normal(0, 1);	        // half-normal prior for positive value
  y ~ binomial_logit(n, mu_ijk);
  theta ~ normal(0, sigma_theta);
}

