data {
  int<lower=0> J;                     // number of systems
  int<lower=0> K;                     // number of measures
  int<lower=0> NN;                    // total observations
  int n[NN];                          // sample size
  int y[NN];                          // successes
  int j[NN];                          // system number 
  int k[NN];                          // measure number
}
parameters {
  real beta[K];                       // measure difficulty
  real theta[J];                      // system quality parameter
  real<lower=0> alpha[K];             // measure discrimination, positive for identifiability - this allows each measure to have a different 'slope' or contribute differently to the composite
  
  real mu_beta;                       // hyperparameter for beta
  real<lower=0> sigmasq_beta;         // hyperparameter for beta, must be positive
  real<lower=0> mu_alpha;             // hyperparameter for alpha, must be positive
  real<lower=0> sigmasq_alpha;        // hyperparameter for alpha, must be positive
  real<lower=0> sigmasq_theta;        // must be positive
}
transformed parameters {
  real<lower=0> sigma_theta;
  real<lower=0> sigma_beta;
  real<lower=0> sigma_alpha;
  real mu_ijk[NN];
  
  sigma_theta = sqrt(sigmasq_theta);
  sigma_beta = sqrt(sigmasq_beta);
  sigma_alpha = sqrt(sigmasq_alpha);
  
for (ii in 1:NN) {
    mu_ijk[ii] = alpha[k[ii]]*(theta[j[ii]] - beta[k[ii]]); // parametrize the mean
  }  
}
model {
  sigmasq_theta ~ normal(0, 1);                 // half-normal prior for positive value
  beta ~ normal(mu_beta, sigma_beta);
  alpha ~ normal(mu_alpha, sigma_alpha);        // half-normal prior for positive value

  mu_beta ~ normal(0, 1);
  sigmasq_beta ~ normal(0, 1);                  // half-normal prior for positive value
  mu_alpha ~ normal(0, 1);                      // half-normal prior for positive value
  sigmasq_alpha ~ normal(0, 1);                 // half-normal prior for positive value
  y ~ binomial_logit(n, mu_ijk);
  theta ~ normal(0, sigma_theta);
}

