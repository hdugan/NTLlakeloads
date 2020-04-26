library(tidyverse)
library(plyr)
library(mgcv)
library(reshape2)
library(lubridate)
library(akima)

#### Source LTER data ####
source('R/loadLTERdata.R')
loadLTERdata() # Download all LTER data from EDI

############## Subset calibration data by depth for both epi and hypo ##########

lakeAbr = 'ME'; var = 'doc'; maxdepth = 24; constrainmethod = 'zero'; setthreshold = 1
lakeAbr = 'ME'; var = 'no3no2_sloh'; maxdepth = 24; constrainmethod = 'zero'; setthreshold = 1
lakeAbr = 'ME'; var = 'drsif_sloh'; maxdepth = 24; constrainmethod = 'zero'; setthreshold = 1
lakeAbr = 'ME'; var = 'drp_sloh'; maxdepth = 24; constrainmethod = 'zero'; setthreshold = 0.1
lakeAbr = 'ME'; var = 'totpuf_sloh'; maxdepth = 24; constrainmethod = 'zero'; setthreshold = 0.1
lakeAbr = 'MO'; var = 'totpuf_sloh'; maxdepth = 20; constrainmethod = 'zero'; setthreshold = 0.1

lakeAbr = 'ME'; var = 'ph'; maxdepth = 24; constrainmethod = 'zero'; setthreshold = 0.4
lakeAbr = 'TR'; var = 'no3no2'; maxdepth = 24; constrainmethod = 'zero'; setthreshold = 50

lakeAbr = 'ME'; var = 'o2'; maxdepth = 24; constrainmethod = 'zero'; setthreshold = 0.5
lakeAbr = 'TR'; var = 'doc'; maxdepth = 35; constrainmethod = 'zero'; setthreshold = 1

lakeAbr = 'ME'; var = 'totpuf_sloh'; maxdepth = 24; constrainMethod = 'zero'; setthreshold = 0.1

weeklyInterpolate <- function(lakeAbr, var, maxdepth, constrainMethod = 'zero', setthreshold = 0.1) {
  # Read in data 
  temp = LTERtemp %>% 
    filter(!is.na(wtemp)) %>%
    dplyr::filter(lakeid == lakeAbr) %>% 
    dplyr::group_by(sampledate,depth) %>%
    dplyr::summarise(wtemp = mean(wtemp,na.rm=TRUE)) # Temp and Oxygen 
  
  
  if (var %in% names(LTERions)) {
    dfin = LTERions
  } if (var %in% names(LTERnutrients)) {
    dfin = LTERnutrients
  } if (var %in% names(LTERtemp)) {
    dfin = LTERtemp
  }
  
  obs = dfin %>% mutate(sampledate = as.Date(sampledate,'%Y-%m-%d')) %>% 
    dplyr::filter(lakeid == lakeAbr & !is.na(get(var))) %>%
    dplyr::select(sampledate,depth,var) %>%
    mutate(var = as.numeric(get(var))) %>%
    dplyr::filter(var >= 0) %>%
    dplyr::group_by(sampledate,depth) %>%
    dplyr::summarise(meanVar = mean(var,na.rm=TRUE)) %>%
    full_join(select(temp,sampledate,depth,wtemp)) %>%
    mutate(decdate = decimal_date(sampledate)) %>%
    filter(!is.na(wtemp)) %>%
    mutate(month = month(sampledate)) %>%
    arrange(sampledate,depth) # %>% mutate(meanVar = log(meanVar+1))
  ############## ############## ############## ############## ############## 
  

  usedates = obs %>% dplyr::filter(!is.na(meanVar)) %>% 
    filter(depth > (maxdepth/2)) %>%
    distinct(sampledate)
  
  f = lapply(X = usedates$sampledate,FUN = interpData, observationDF = obs, 
             maxdepth = maxdepth, constrainMethod = constrainMethod)
  
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
  return(df3)
}

# Plotting ###
binsize = signif(max(df3$var,na.rm = T)/20,1)

ggplot(df3, aes(x = date, y = depth, z = var)) +
  geom_contour_filled(aes(fill = stat(level)), alpha = 0.9, binwidth = binsize) + 
  scale_fill_viridis_d(name = var) +
  guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
  ylab('depth') +
  scale_y_reverse() +
  theme_bw() 

ggsave(paste0('gamHeatMap_',lakeAbr,'_',var,'.png'), width = 7, height = 4)

# Zoom into specific year 
chooseYear = 2018
ggplot(df3, aes(x = date, y = depth, z = var)) +
  geom_contour_filled(aes(fill = stat(level)), alpha = 0.9, binwidth = binsize) + 
  scale_fill_viridis_d(name = var) +
  guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
  geom_point(data = filter(obs, !is.na(meanVar)), aes(x = sampledate, y = depth), size = 0.5) +
  geom_text(data = filter(obs, !is.na(meanVar)), aes(x = sampledate, y = depth, label= meanVar),
            hjust= -0.2, vjust=1.2, size = 3, color = 'white') + 
  scale_color_viridis_c() +
  ylab('depth') +
  xlim(as.Date(paste0(chooseYear,'-01-01')), as.Date(paste0(chooseYear,'-12-01'))) +
  scale_y_reverse() 
  # theme_bw() 





