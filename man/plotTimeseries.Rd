% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotTimeseries.R
\name{plotTimeseries}
\alias{plotTimeseries}
\title{Plot interpolate heatmap of entire timeseries}
\usage{
plotTimeseries(
  df.interpolated,
  var,
  binsize = NULL,
  legend.title = NULL,
  saveFig = FALSE
)
}
\arguments{
\item{df.interpolated}{dataframe of weekly interpolated data. Output of weeklyInterpolate()}

\item{var}{Variable of interest. Use availableVars() to see available variables.}

\item{binsize}{Size of legend bins. Defaults to 1/20th of maximum value.}

\item{legend.title}{Choice to specify legend title}

\item{saveFig}{If TRUE, saves a png to the working directory (default = FALSE)}
}
\description{
Plot interpolate heatmap of entire timeseries
}
