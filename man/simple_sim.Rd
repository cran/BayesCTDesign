% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BayesCTDesigncode.R
\name{simple_sim}
\alias{simple_sim}
\title{Two Arm Bayesian Clinical Trial Simulation without Historical Data}
\usage{
simple_sim(
  trial_reps = 100,
  outcome_type = "weibull",
  subj_per_arm = c(50, 100, 150, 200, 250),
  effect_vals = c(0.6, 1, 1.4),
  control_parms = NULL,
  time_vec = NULL,
  censor_value = NULL,
  alpha = 0.05,
  get_var = FALSE,
  get_bias = FALSE,
  get_mse = FALSE,
  seedval = NULL,
  quietly = TRUE
)
}
\arguments{
\item{trial_reps}{Number of trials to replicate within each combination of
\code{a0_vals}, \code{subj_per_arm}, \code{effect_vals}, and \code{rand_control_parms}.
As the number of trials increases, the precision of the estimate will increase.
Default is 100.}

\item{outcome_type}{Outcome distribution. Must be equal to \code{weibull},
\code{lognormal}, \code{pwe} (Piecewise Exponential), \code{gaussian},
\code{bernoulli}, or \code{poisson}.  Default is \code{weibull}.}

\item{subj_per_arm}{A vector of sample sizes, all of which must be positive
integers.  Default is \code{c(50, 100, 150, 200, 250)}.}

\item{effect_vals}{A vector of effects that should be reasonable for the
outcome_type being studied, hazard ratios for Weibull, odds ratios for
Bernoulli, mean ratios for Poisson, etc..  When \code{effect_vals} contain
the null effect for a given \code{outcome_type}, the \code{power} component
of \code{data} will contain an estimate of Type One Error.  In order to
have a good set of Type One Error estimates, \code{trial_reps} need to be
at least 10,000.  In such a case, if the total number of combinations
made up from \code{subj_per_arm}, \code{a0_vals}, \code{effect_vals}, and
\code{rand_control_diff} is very large, the time to complete the simulation
can be substantial. Default is \code{c(0.6, 1, 1.4)}.}

\item{control_parms}{A vector of parameter values defining the outcome
distribution for randomized controls. See Details for what is required for
each \code{outcome_type}.}

\item{time_vec}{A vector of time values that are used to create time periods
within which the exponential hazard is constant.  Only used for piecewise
exponential models.  Default is \code{NULL}.}

\item{censor_value}{A single value at which right censoring occurs when
simulating randomized subject outcomes.  Used with survival outcomes.
Default is \code{NULL}, where \code{NULL} implies no right censoring.}

\item{alpha}{A number ranging between 0 and 1 that defines the acceptable Type 1
error rate. Default is 0.05.}

\item{get_var}{A TRUE/FALSE indicator of whether an array of variance
estimates will be returned.  Default is \code{FALSE}.}

\item{get_bias}{A TRUE/FALSE indicator of whether an array of bias
estimates will be returned.  Default is \code{FALSE}.}

\item{get_mse}{A TRUE/FALSE indicator of whether an array of MSE
estimates will be returned.  Default is \code{FALSE}.}

\item{seedval}{A seed value for pseudo-random number generation.}

\item{quietly}{A TRUE/FALSE indicator of whether notes are printed
to output about simulation progress as the simulation runs.  If
running interactively in RStudio or running in the R console,
\code{quietly} can be set to FALSE.  If running in a Notebook or
knitr document, \code{quietly} needs to be set to TRUE.  Otherwise
each note will be printed on a separate line and it will take up
a lot of output space.  Default is \code{TRUE}.}
}
\value{
\code{simple_sim()} returns an S3 object of class \code{bayes_ctd_array}.
  As noted in Details, an object of class \code{bayes_ctd_array} has 6 elements: a
  list containing simulation results (\code{data}), copies of the 4 function
  arguments \code{subj_per_arm}, \code{a0_vals}, \code{effect_vals}, and
  \code{rand_control_diff}, and finally \code{objtype} indicating that \code{simple_sim()}
  was used. See Details for a discussion about the contents of
  \code{data}. Results from the simulation contained in the \code{bayes_ctd_array}
  object can be printed or plotted using the \code{print()} and
  \code{plot()} methods. The results can also be accessed using basic list
  element identification and array slicing. For example, to get the power results
  from a simulation, one could use the code \code{bayes_ctd_array$data$power}, where
  \code{bayes_ctd_array} is replaced with the name of the variable containing the
  \code{bayes_ctd_array} object. Even though this is a 4-dimensional array, the power
  results only occupy a single 2-dimensional table. To print this 2-dimensional table,
  one would use the code \code{bayes_ctd_array$data$power[,1,,1]}, where
  \code{bayes_ctd_array} is replaced with the name of the variable containing the
  \code{bayes_ctd_array} object.
}
\description{
\code{simple_sim()} returns an S3 object of class \code{bayes_ctd_array}, which
will contain simulation results for power, statistic estimation, bias, variance,
and mse as requested by user.
}
\details{
The object \code{bayes_ctd_array} has 6 elements: a list containing simulation
results (\code{data}), copies of the 4 function arguments \code{subj_per_arm},
\code{a0_vals}, \code{effect_vals}, and \code{rand_control_diff}, and finally
a \code{objtype} value indicating that \code{simple_sim()} was used. Each element of
\code{data} is a four-dimensional array, where each dimension is determined by the
length of parameters \code{subj_per_arm}, \code{a0_vals}, \code{effect_vals}, and
\code{rand_control_diff}. The size of \code{data} depends on which results are
requested by the user. At a minimum, at least one of \code{subj_per_arm},
\code{a0_vals}, \code{effect_vals}, or \code{rand_control_diff} must contain at
least 2 values, while the other three must contain at least 1 value.  The \code{data}
list will always contain two elements: an array of power results (\code{power}) and
an array of estimation results (\code{est}).  In addition to \code{power} and
\code{est}, \code{data} may also contain elements \code{var}, \code{bias}, or
\code{mse}, depending on the values of \code{get_var}, \code{get_bias}, and
\code{get_mse}. The values returned in \code{est} are in the form of hazard ratios,
mean ratios, odds ratios, or mean differences depending on the value of
\code{outcome_type}.   For a Gaussian outcome, the estimation results are
differences in group means (experimental group minus control group). For a
logistic outcome, the estimation results are odds ratios (experimental group over
control group). For lognormal and Poisson outcomes, the estimation results are mean
ratios (experimental group over control group). For a piecewise exponential or a
Weibull outcome, the estimation results are hazard ratios (experimental group over
control group).  The values returned in \code{bias}, \code{var}, and \code{mse} are
on the scale of the values returned in \code{est}.

The object \code{bayes_ctd_array} has two primary methods, \code{print()} and
\code{plot()}, for printing and plotting slices of the arrays contained in
\code{bayes_ctd_array$data}.

As dimensions of the four dimensional array increases, the time required to complete
the simulation will increase; however, it will be faster than a similar simulation
based on repeated calls to MCMC routines to analyze each simulated trial.

The meaning of the estimation results, and the test used to generate power results,
depends on the outcome used. In all cases, power is based on a two-sided test
involving a (1-alpha)100\% credible interval, where the interval is used to determine
if the null hypothesis should be rejected (null value outside of the interval) or
not rejected (null value inside the interval). For a Gaussian outcome, the 95\%
credible interval is an interval for the difference in group means
(experimental group minus control group), and the test determines if 0 is in or
outside of the interval. For a Bernoulli outcome, the 95\% credible interval
is an interval for the odds ratio (experimental group over control group),
and the test determines if 1 is in or outside of the interval. For a lognormal or
a Poisson outcome, the 95\% credible interval is an interval for the mean ratio
(experimental group over control group), and the test determines if 1 is in or
outside of the interval. Finally, for a piecewise exponential or a Weibull outcome,
the 95\% credible interval is an interval for the hazard ratio (experimental group
over control group), and the test determines if 1 is in or outside of the interval.

For a Gaussian outcome, the \code{control_parms} values should be \code{(mean, sd)},
where mean is the mean parameter for the control group used in a call to \code{rnorm()},
and sd is the common sd parameter for both groups used in a call to\code{rlnorm()}.

For a Bernoulli outcome, the \code{control_parms} values should be \code{(prob)}, where
prob is the event probability for the control group used in a call to \code{rbinom()}.

For a lognormal outcome, the \code{control_parms} values should be \code{(meanlog, sdlog)},
where meanlog is the meanlog parameter for the control group used in a call to
\code{rlnorm()}, and sdlog is the common sdlog parameter for both groups used in
a call to \code{rlnorm()}.

For a Poisson outcome, the \code{control_parms} value should be \code{(lambda)}, where
lambda is the lambda parameter for the control group used in a call to \code{rpois()} and
is equal to the mean of a Poisson distribution.

For a Weibull outcome, the \code{control_parms} values should be \code{(scale, shape)},
where scale is the scale parameter for the control group used in a call to
\code{rweibull()}, and shape is the common shape parameter for both groups used in
a call to \code{rweibull()}.

For a piecewise exponential outcome, the \code{control_parms} values should be a vector
of lambdas used in a call to \code{eha::rpch()}.  Each element in \code{control_parms}
is a hazard for an interval defined by the \code{time_vec} parameter.

Please refer to the examples for illustration of package use.
}
\examples{
#Run a Weibull simulation, using simple_sim().
#For meaningful results, trial_reps needs to be much larger than 2.
weibull_test <- simple_sim(trial_reps = 2, outcome_type = "weibull",
                           subj_per_arm = c(50, 100, 150, 200),
                           effect_vals = c(0.6, 1, 1.4),
                           control_parms = c(2.82487,3), time_vec = NULL,
                           censor_value = NULL, alpha = 0.05,
                           get_var = TRUE, get_bias = TRUE, get_mse = TRUE,
                           seedval=123, quietly=TRUE)

#Tabulate the simulation results for power.
test_table <- print(x=weibull_test, measure="power",
                    tab_type=NULL, subj_per_arm_val=NULL, a0_val=NULL,
                    effect_val=NULL, rand_control_diff_val=NULL)
print(test_table)

#Create a plot of the power simulation results.
plot(x=weibull_test, measure="power", tab_type=NULL,
     smooth=FALSE, plot_out=TRUE)
#Create a plot of the estimated hazard ratio simulation results.
plot(x=weibull_test, measure="est", tab_type=NULL,
     smooth=FALSE, plot_out=TRUE)
#Create a plot of the hazard ratio variance simulation results.
plot(x=weibull_test, measure="var", tab_type=NULL,
     smooth=FALSE, plot_out=TRUE)
#Create a plot of the hazard ratio bias simulation results.
plot(x=weibull_test, measure="bias", tab_type=NULL,
     smooth=FALSE, plot_out=TRUE)
#Create a plot of the hazard ratio mse simulation results.
plot(x=weibull_test, measure="mse", tab_type=NULL,
     smooth=FALSE, plot_out=TRUE)
}
