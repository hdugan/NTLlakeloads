#' Interpolate temperature data to weekly
#'
#' Interpolates dataframe of observations to weekly timestep at 1 m depth intervals.
#' Uses simple linear interpolation
#'
#' @param lakeAbr Lake identification, string
#' @param dataset temperature dataset. Default woudl be LTERtemp loaded via loadLTERtemp()
#' @param maxdepth Maximum depth of lake
#' @param constrainMethod Options to constrain interpolation.
#' Options are 'zero' (cannot go below zero, cannot go 1.5x above max, default) 
#' and 'range' (can not go beyond range of observed data)
#' @returns
#' returns a list 
#' [[1]]: observation data
#' [[2]]: dataframe with three columns, data, depth, and var
#' #' @examples
#' #Interpolate temp data
#' LTERtemp = loadLTERtemp()
#' weeklyTempInterpolate(lakeAbr = 'ME', maxdepth = 24, dataset = LTERtemp)
#' @import dplyr
#' @import akima
#' @import mgcv
#' @importFrom future.apply future_lapply
#' @importFrom future plan multisession
#' @importFrom reshape2 melt
#' @importFrom lubridate decimal_date month
#' @export
weeklyTempInterpolate <- function(lakeAbr, maxdepth, dataset = LTERtemp,
                              constrainMethod = 'zero') {
  # # Read in data
  # if (!exists('LTERtemp')) {
  #   LTERtemp = loadLTERtemp() # Download NTL LTER data from EDI
  # }
  # 
  obs = dataset %>%
    dplyr::filter(!is.na(wtemp)) %>%
    dplyr::filter(lakeid == lakeAbr) %>%
    dplyr::group_by(sampledate,depth) %>%
    dplyr::summarise(wtemp = mean(wtemp,na.rm=TRUE)) # Temp and Oxygen
  
  ############## ############## ############## ############## ##############
  
  usedates = obs %>%
    dplyr::filter(!is.na(wtemp)) %>%
    dplyr::filter(depth > (maxdepth/2)) %>%
    dplyr::distinct(sampledate)
  
  # apply in parallel (10x faster)
  plan(multisession)
  f <- future_lapply(X = usedates$sampledate, FUN = interpTemp, observationDF = obs,
                     maxdepth = maxdepth)
  
  # Bind list into dataframe
  df2 <- do.call(rbind.data.frame, f)
  
  full_y = seq(from = range(df2$depth)[1],to = range(df2$depth)[2], by = 1)
  full_x = seq.Date(from = range(df2$sampledate,na.rm = T)[1],to = range(df2$sampledate,na.rm = T)[2], by = 'week')
  # a = data.frame(x = full_x, y = full_y)
  a = expand.grid(sampledate = full_x, depth = full_y)
  
  interped = akima::interp(x = df2$sampledate, y = df2$depth, z = df2$wtemp, full_x, full_y,
                           duplicate = 'mean',linear=T, extrap = F, jitter = 10e-5)
  
  
  dimnames(interped$z) =  list(full_x, interped$y)
  df3 <- melt(interped$z, varnames = c('date', 'depth'), value.name = 'wtemp')
  df3$date = as.Date(df3$date,origin = '1970-01-01')
  
  # constrainMethod Type (zero = min set to zero, range = set to range)
  if (constrainMethod == 'zero') {
    df3 = df3 %>% mutate(wtemp = ifelse(wtemp < 0, 0, wtemp)) %>%
      mutate(wtemp = ifelse(wtemp > (max(obs$wtemp, na.rm = T) * 1.5), max(obs$wtemp, na.rm = T), wtemp))  |> 
      rename(var = wtemp)
  }
  if (constrainMethod == 'range') {
    df3 = df3 %>% mutate(wtemp = ifelse(wtemp < min(obs$wtemp, na.rm = T), min(obs$wtemp, na.rm = T), wtemp)) %>%
      mutate(wtemp = ifelse(wtemp > (max(obs$wtemp, na.rm = T)*1), max(obs$wtemp, na.rm = T), wtemp)) |> 
      rename(var = wtemp)
  }
  
  return(list(observations = obs, weeklyInterpolated = df3))
}


# Interpolate observations to weekly
interpTemp <- function(observationDF, date, maxdepth, rmse.threshold = setThreshold) {
  a = observationDF %>% filter(sampledate == date)
  if (sum(!is.na(a$wtemp)) == 0) {
    print('nothing')
    return(NULL)
  }
  
  b = a %>% filter(!is.na(wtemp))
  if (max(b$depth) < (maxdepth/2)) {
    print('too shallow')
    return(NULL)
  }
  
  yout = approx(x = a$depth, y = a$wtemp, xout = c(0:maxdepth), rule = 2)
  k = nrow(b)
  
  outp = data.frame(sampledate = date, depth = c(0:maxdepth), wtemp = yout$y)

  return(outp)
}
