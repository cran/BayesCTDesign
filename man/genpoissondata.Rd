% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PoissonCode.R
\name{genpoissondata}
\alias{genpoissondata}
\title{Generating function for Poisson Data.}
\usage{
genpoissondata(sample_size, mu1, mean_ratio)
}
\arguments{
\item{sample_size}{Number of subjects per arm.}

\item{mu1}{lambda parameter used in call to \code{rpois()}.
Used only in control arm.}

\item{mean_ratio}{Desired Mean Ratio between experimental and control groups.}
}
\value{
\code{genpoissondata()} returns a data frame with columns: 'id', 'treatment',
  and 'y'.
}
\description{
\code{genpoissondata()} function mainly used internally by
\code{poissontrialsimulator()} function to generate data for a two-arm
clinical trial, experimental and control groups.  Can be used to generate
random trial data.
}
\examples{
samplehistdata <- genpoissondata(sample_size=60, mu1=1, mean_ratio=1.0)
samplehistdata
}
