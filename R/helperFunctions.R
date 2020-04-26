## calculate rmse ##
RMSE = function(m, o){
  sqrt(mean((m - o)^2,na.rm = T))
}

# Interpolate observations to weekly 
interpData <- function(observationDF, date, maxdepth, rmse.threshold = setthreshold, constrainMethod = zero) {
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
