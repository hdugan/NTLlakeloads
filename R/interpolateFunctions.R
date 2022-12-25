#' Interpolate LTER data to weekly
#'
#' Interpolates dataframe of observations to weekly timestep at 1 m depth intervals.
#' Uses the premise that nutrient profiles should match temperature profiles
#'
#' @param lakeAbr Lake identification, string
#' @param var Variable of interest. Use availableVars() to see available variables.
#' @param dataset NTL dataset with the variable of interest downloaded via loadLTER...() functions
#' @param maxdepth Maximum depth of lake
#' @param constrainMethod Options to constrain interpolation.
#' Options are 'zero' (cannot go below zero, cannot go 1.5x above max, default) 
#' and 'range' (can not go beyond range of observed data)
#' @param setThreshold Threshold of RMSE for interpolation. Use units of variable. If the function returns many 
#' predict.lm warnings, the threshold should be increased. 
#' @param printFigs Output individual profiles of interpolation? Options TRUE or FALSE (default)
#' @returns
#' returns a list 
#' [[1]]: observation data
#' [[2]]: dataframe with three columns, data, depth, and var
#' #' @examples
#' #Interpolate TP data
#' NTLnutrients = loadLTERnutrients()
#' weeklyInterpolate.1D(lakeAbr = 'ME',var = 'drp_sloh',dataset = NTLnutrients)
#' @import dplyr
#' @import akima
#' @import mgcv
#' @importFrom future.apply future_lapply
#' @importFrom future plan multisession
#' @importFrom reshape2 melt
#' @importFrom lubridate decimal_date month
#' @importFrom ggforce facet_wrap_paginate
#' @export
weeklyInterpolate <- function(lakeAbr, var, dataset,  maxdepth,
                              constrainMethod = 'zero', setThreshold = 0.1, printFigs = FALSE) {
  # Read in data
  if (!exists('LTERtemp')) {
    LTERtemp = loadLTERtemp() # Download NTL LTER data from EDI
  }
  
  temp = LTERtemp %>%
    dplyr::filter(!is.na(wtemp)) %>%
    dplyr::filter(lakeid == lakeAbr) %>%
    dplyr::group_by(sampledate,depth) %>%
    dplyr::summarise(wtemp = mean(wtemp,na.rm=TRUE)) # Temp and Oxygen
  
  obs = dataset %>%
    dplyr::mutate(sampledate = as.Date(sampledate,'%Y-%m-%d')) %>%
    dplyr::filter(lakeid == lakeAbr & !is.na(get(var))) %>%
    dplyr::select(sampledate,depth,var) %>%
    mutate(var = as.numeric(get(var))) %>%
    dplyr::filter(var >= 0) %>%
    dplyr::group_by(sampledate,depth) %>%
    dplyr::summarise(meanVar = mean(var,na.rm=TRUE)) %>%
    dplyr::full_join(dplyr::select(temp,sampledate,depth,wtemp)) %>%
    dplyr::mutate(decdate = decimal_date(sampledate)) %>%
    dplyr::filter(!is.na(wtemp)) %>%
    dplyr::mutate(month = month(sampledate)) %>%
    dplyr::arrange(sampledate,depth) 
  
  ############## ############## ############## ############## ##############

  usedates = obs %>%
    dplyr::filter(!is.na(meanVar)) %>%
    dplyr::filter(depth > (maxdepth/2)) %>%
    dplyr::distinct(sampledate)

  # apply in parallel (10x faster)
  plan(multisession)
  f <- future_lapply(X = usedates$sampledate, FUN = interpData, observationDF = obs,
                      maxdepth = maxdepth, rmse.threshold = setThreshold, constrainMethod = constrainMethod)

  # # lapply interpolation function
  # f = lapply(X = usedates$sampledate,FUN = interpData, observationDF = obs,
  #            maxdepth = maxdepth, rmse.threshold = setThreshold, constrainMethod = constrainMethod)
  
  # Bind list into dataframe
  df <- do.call(rbind.data.frame, f)
  
  # Paginate interpolation figures
  if (printFigs == TRUE) {
    for (i in 1:ceiling(length(unique(df$sampledate))/36)) {
      p = ggplot(df) + geom_point(aes(x = meanVar, y = depth, fill = withinThreshold), size = 3, shape = 21) +
        scale_fill_manual(values = c('red3','gold')) +
        geom_point(aes(x = newp, y = depth), size = 0.8) +
        scale_y_reverse() +
        xlab(var) + ylab('depth') +
        # xlim(-0.1 , max(outp$newp,na.rm = T)) +
        # labs(title = paste0(date,', rmse: ',rmse)) +
        theme_bw() +
        theme(title = element_text(size = 8),
              text = element_text(size = 8)) +
        facet_wrap_paginate(vars(sampledate), nrow = 6, ncol = 6, page = i)
      print(p)
    }
  }

  # Remove profiles that did not cross the threshold
  df2 = df %>% dplyr::filter(!is.na(newp) & !is.na(sampledate) & withinThreshold == TRUE)

  full_y = seq(from = range(df2$depth)[1],to = range(df2$depth)[2], by = 1)
  full_x = seq.Date(from = range(df2$sampledate,na.rm = T)[1],to = range(df2$sampledate,na.rm = T)[2], by = 'week')
  # a = data.frame(x = full_x, y = full_y)
  a = expand.grid(sampledate = full_x, depth = full_y)

  interped = akima::interp(x = df2$sampledate, y = df2$depth, z = df2$newp, full_x, full_y,
                           duplicate = 'mean',linear=T, extrap = F, jitter = 10e-5)


  dimnames(interped$z) =  list(full_x, interped$y)
  df3 <- melt(interped$z, varnames = c('date', 'depth'), value.name = 'var')
  df3$date = as.Date(df3$date,origin = '1970-01-01')
  
  # constrainMethod Type (zero = min set to zero, range = set to range)
  if (constrainMethod == 'zero') {
    df3 = df3 %>% mutate(var = ifelse(var < 0, 0, var)) %>%
      mutate(var = ifelse(var > (max(obs$meanVar, na.rm = T) * 1.5), max(obs$meanVar, na.rm = T), var)) 
  }
  if (constrainMethod == 'range') {
    df3 = df3 %>% mutate(var = ifelse(var < min(obs$meanVar, na.rm = T), min(obs$meanVar, na.rm = T), var)) %>%
      mutate(var = ifelse(var > (max(obs$meanVar, na.rm = T)*1), max(obs$meanVar, na.rm = T), var))
  }
  
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
    mod1 = gam(meanVar ~ s(wtemp, depth, k=k, bs='tp'), data = a)
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
  outp$withinThreshold = TRUE

  # New RMSE
  rmse = round(RMSE(outp$meanVar,outp$newp),2) #calculate RMSE
  if (rmse > rmse.threshold){
    print(paste0('RMSE too high: ',date))
    outp$withinThreshold = FALSE
  }

  return(outp)
}

#' Interpolate LTER data to weekly
#'
#' Interpolates dataframe of 1-D observations (secchi, light extinction) to weekly timestep.
#'
#' @param lakeAbr Lake identification, string
#' @param var Variable of interest. Use availableVars() to see available variables.
#' @param dataset NTL dataset with the variable of interest downloaded via loadLTER...() functions
#' @returns
#' returns a list 
#' [[1]]: observation data
#' [[2]]: returns a dataframe with two columns, data and var
#' @examples
#' #Interpolate Secchi data
#' NTLsecchi = loadLTERsecchi()
#' weeklyInterpolate.1D(lakeAbr = 'ME',var = 'secnview',dataset = NTLsecchi)
weeklyInterpolate.1D <- function(lakeAbr, var, dataset) {

  obs = dataset %>%
    dplyr::mutate(sampledate = as.Date(sampledate,'%Y-%m-%d')) %>%
    dplyr::filter(lakeid == lakeAbr & !is.na(get(var))) %>%
    dplyr::select(sampledate,var) %>%
    mutate(var = as.numeric(get(var))) %>%
    dplyr::filter(var >= 0)
  ############## ############## ############## ############## ##############

  full_x = seq.Date(from = range(obs$sampledate,na.rm = T)[1],to = range(obs$sampledate,na.rm = T)[2], by = 'week')
  yout = approx(x = obs$sampledate, y = obs$var, xout = full_x)

  output = data.frame(date = full_x, var = yout$y)

  return(list(observations = obs, weeklyInterpolated = output))
}
