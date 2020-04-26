

#### Source LTER data ####
# source('R/loadLTERdata.R')
# source('R/helperFunctions.R')
LTERtemp = loadLTERtemp() # Download all LTER data from EDI
LTERnutrients = loadLTERnutrients() # Download all LTER data from EDI
LTERions = loadLTERions() # Download all LTER data from EDI

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

# df.ME = weeklyInterpolate(lakeAbr = 'ME', var = 'totpuf_sloh', maxdepth = 24, constrainMethod = 'zero', setThreshold = 0.1)
# Plotting ###
# plotTimeseries.year(df.ME$weeklyInterpolated, df.ME$observations, 2018)
# plotTimeseries(df.ME$weeklyInterpolated)



