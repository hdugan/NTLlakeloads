#' Interpolate LTER data to weekly
#'
#' Interpolates dataframe of observations to weekly timestep at 1 m depth intervals.
#' Uses the premise that nutrient profiles should match temperature profiles
#'
#' @param lakeAbr Lake identification, string
#' @param var Variable of interest. Use availableVars() to see available variables.
#' @param maxdepth Maximum depth of lake
#' @param constrainMethod Options to constrain interpolation.
#' Options are 'zero' (cannot go below zero, default) and 'range' (can not go beyond range of observed data)
#' @param setThreshold Threshold of RMSE for interpolation
#'
#' @import dplyr
#' @importFrom  plyr rbind.fill
#' @import mgcv
#' @importFrom reshape2 melt
#' @importFrom lubridate decimal_date month
#' @import akima

weeklyInterpolate <- function(lakeAbr, var, maxdepth, constrainMethod = 'zero', setThreshold = 0.1) {
  # Read in data
  temp = LTERtemp %>%
    dplyr::filter(!is.na(wtemp)) %>%
    dplyr::filter(lakeid == lakeAbr) %>%
    dplyr::group_by(sampledate,depth) %>%
    dplyr::summarise(wtemp = mean(wtemp,na.rm=TRUE)) # Temp and Oxygen


  if (var %in% names(LTERions)) {
    dfin = LTERions
  } else if (var %in% names(LTERnutrients)) {
    dfin = LTERnutrients
  } else if (var %in% names(LTERtemp)) {
    dfin = LTERtemp
  }

  obs = dfin %>%
    dplyr::mutate(sampledate = as.Date(sampledate,'%Y-%m-%d')) %>%
    dplyr::filter(lakeid == lakeAbr & !is.na(get(var))) %>%
    dplyr::select(sampledate,depth,var) %>%
    mutate(var = as.numeric(get(var))) %>%
    dplyr::filter(var >= 0) %>%
    dplyr::group_by(sampledate,depth) %>%
    dplyr::summarise(meanVar = mean(var,na.rm=TRUE)) %>%
    dplyr::full_join(select(temp,sampledate,depth,wtemp)) %>%
    dplyr::mutate(decdate = decimal_date(sampledate)) %>%
    dplyr::filter(!is.na(wtemp)) %>%
    dplyr::mutate(month = month(sampledate)) %>%
    dplyr::arrange(sampledate,depth) # %>% mutate(meanVar = log(meanVar+1))
  ############## ############## ############## ############## ##############

  usedates = obs %>%
    dplyr::filter(!is.na(meanVar)) %>%
    dplyr::filter(depth > (maxdepth/2)) %>%
    dplyr::distinct(sampledate)

  f = lapply(X = usedates$sampledate,FUN = interpData, observationDF = obs,
             maxdepth = maxdepth, rmse.threshold = setThreshold, constrainMethod = constrainMethod)

  # Bind list into dataframe using plyr
  df <- rbind.fill(f)

  df2 = df %>% dplyr::filter(!is.na(newp) & !is.na(sampledate))

  full_y = seq(from = range(df2$depth)[1],to = range(df2$depth)[2], by = 1)
  full_x = seq.Date(from = range(df2$sampledate,na.rm = T)[1],to = range(df2$sampledate,na.rm = T)[2], by = 'week')
  # a = data.frame(x = full_x, y = full_y)
  a = expand.grid(sampledate = full_x, depth = full_y)


  interped = akima::interp(x = df2$sampledate, y = df2$depth, z = df2$newp, full_x, full_y,
                           duplicate = 'mean',linear=T, extrap = F)


  dimnames(interped$z) =  list(full_x, interped$y)
  df3 <- melt(interped$z, varnames = c('date', 'depth'), value.name = 'var')

  df3$date = as.Date(df3$date,origin = '1970-01-01')
  return(list(observations = obs, weeklyInterpolated = df3))
}

## calculate rmse ##
RMSE = function(m, o){
  sqrt(mean((m - o)^2,na.rm = T))
}

# Interpolate observations to weekly
interpData <- function(observationDF, date, maxdepth, rmse.threshold = setThreshold, constrainMethod = zero) {
  a = observationDF %>% filter(sampledate == date)
  if (sum(!is.na(a$meanVar)) == 0) {
    print('nothing')
    return(NULL)
  }

  b = a %>% filter(!is.na(meanVar))
  if (max(b$depth) < (maxdepth/2)) {
    print('too shallow')
    return(NULL)
  }

  yout = approx(x = a$depth, y = a$wtemp, xout = c(0:maxdepth))
  k = nrow(b)

  if (k <= 3 | length(unique(b$wtemp)) == 1 | length(unique(b$meanVar)) == 1) {
    # Multivariate linear regression
    # lmP = lm(meanVar ~ wtemp + depth,data = b)
    lmP = lm(meanVar ~ wtemp,data = b) # Just depth

    outp = data.frame(depth = yout$x, wtemp = yout$y) %>%
      mutate(newp = predict(lmP,newdata = data.frame(depth,wtemp)))
  } else {
    # GAM model
    mod1 = gam(meanVar ~ s(wtemp,depth,k=k,bs='tp'), data = a)
    outp = data.frame(depth = yout$x, wtemp = yout$y) %>%
      mutate(newp = predict(mod1,newdata = data.frame(depth,wtemp)))
  }

  # constrainMethod Type (zero = min set to zero, range = set to range)
  if (constrainMethod == 'zero') {
    outp = outp %>% mutate(newp = ifelse(newp<0, 0, newp)) %>%
      mutate(newp = ifelse(newp > (max(b$meanVar)*1.5),max(b$meanVar),newp)) %>%
      mutate(sampledate = date) %>%
      left_join(a, by = c('depth' = 'depth', 'sampledate' = 'sampledate'))
  }
  if (constrainMethod == 'range') {
    outp = outp %>% mutate(newp = ifelse(newp < min(b$meanVar), min(b$meanVar), newp)) %>%
      mutate(newp = ifelse(newp > (max(b$meanVar)*1), max(b$meanVar), newp)) %>%
      mutate(sampledate = date) %>%
      left_join(a, by = c('depth' = 'depth', 'sampledate' = 'sampledate'))
  }

  # New RMSE
  rmse = round(RMSE(outp$meanVar,outp$newp),2) #calculate RMSE

  plot(a$meanVar,a$depth,ylim = rev(range(yout$x)), xlim = c(-2,max(outp$newp,na.rm = T)),
       main = paste0(date,', rmse: ',rmse), cex = 1.5)
  points(outp$newp,outp$depth,pch = 16)

  if (rmse > rmse.threshold){
    print(paste0('RMSE too high: ',date))
    return(NULL)
  }
  return(outp)
}
