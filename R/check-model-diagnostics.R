library(rstan)
library(here)
library(shinystan)
library(readr)

main_ca_fits <- read_rds(here('results/main-analysis_california.rds'))

main_ca_fit_2014 <- main_ca_fits[[1]]
check_hmc_diagnostics(main_ca_fit_2014)
shinystan::launch_shinystan(main_ca_fit_2014)

main_ca_fit_2015 <- main_ca_fits[[2]]
check_hmc_diagnostics(main_ca_fit_2015)
shinystan::launch_shinystan(main_ca_fit_2015)

main_ca_fit_2016 <- main_ca_fits[[3]]
check_hmc_diagnostics(main_ca_fit_2016)
shinystan::launch_shinystan(main_ca_fit_2016)
