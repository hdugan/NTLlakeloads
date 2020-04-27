#' Decompose timeseries from weekly load data
#'
#' Input load data
#'
#' @param df.load dataframe of weekly load estimates
#' @param lakeAbr Lake identification, string
#' @import dplyr
#' @importFrom patchwork plot_annotation
#' @export
decomposeTS <- function(df.load, lakeAbr) {

  ## weights for moving avg
  fltr <- c(1/2, rep(1, times = 51), 1/2)/52
  ## create a time series (ts) object from the var data
  var.load <- ts(data = df.load$load, frequency = 52, start = c(df.load$year[1],
                                                                df.load$week[1]))
  ## estimate of trend
  var.trend = stats::filter(var.load, filter = fltr, method = 'convo', sides = 2)

  ## plot the trend
  # plot.ts(var.trend, ylab = "Trend", cex = 1)

  ## seasonal effect over time
  var.1T <- var.load - var.trend
  # plot.ts(var.1T, ylab = "Seasonal effect", xlab = "Week", cex = 1)

  ## We can obtain the overall seasonal effect by averaging the estimates
  # for each month and repeating this sequence over all years.

  ## length of ts
  ll <- length(var.1T)
  ## frequency (ie, 12)
  ff <- frequency(var.1T)
  ## number of periods (years); %/% is integer division
  periods <- ll%/%ff
  ## index of cumulative month
  index <- seq(1, ll, by = ff) - 1
  ## get mean by month
  mm <- numeric(ff)
  for (i in 1:ff) {
    mm[i] <- mean(var.1T[index + i], na.rm = TRUE)
  }
  ## subtract mean to make overall mean=0
  mm <- mm - mean(mm)
  ## plot the monthly seasonal effects
  # plot.ts(mm, ylab = "Seasonal effect", xlab = "Week", cex = 1)

  # Finally, let’s create the entire time series of seasonal effects
  ## create ts object for season
  var.seas <- ts(rep(mm, periods + 1)[seq(ll)], start = start(var.1T),
                 frequency = ff)

  # The last step in completing our full decomposition model is obtaining the random errors which we can get via simple subtraction
  ## random errors over time
  var.err <- var.load - var.trend - var.seas
  # Now that we have all 3 of our model components, let’s plot them together with the observed data

  ## plot the obs ts, trend & seasonal effect
  # plot(cbind(var.load, var.trend, var.seas, var.err), main = "", yax.flip = TRUE)

  output = as.data.frame(cbind(var.load, var.trend, var.seas, var.err)) %>%
    mutate(date = df.load$date) %>%
    pivot_longer(cols = 1:4, names_to = 'decompose')
  output$decompose = factor(output$decompose, levels=c('var.load', 'var.trend', 'var.seas', 'var.err'))

  pY = ggplot(output) + geom_line(aes(x = date, y = value), color = 'red4') +
    facet_wrap(vars(decompose),scales = 'free', nrow = 4) +
    geom_vline(xintercept = seq.Date(from = as.Date('1995-01-01'), to = as.Date('2020-01-01'),by = 'year'),
               linetype=2, alpha = 0.4) +
    theme_bw() +
    plot_annotation(title = paste0('Timeseries decomposition: Lake ',lakeAbr,', var: ',var))

  print(pY)

  return(output)

  #### Alternative easier method #####
  ## decomposition of load data
  # var.decomp <- decompose(var.load)
  ## plot the obs ts, trend & seasonal effect
  # plot(var.decomp, yax.flip = TRUE)

}


