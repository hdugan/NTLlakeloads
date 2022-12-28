############################################# #############################################
# Plot annual mass of chloride in the Madison lakes
############################################# #############################################

# Load libraries
library(NTLlakeloads)
library(tidyverse)

# load NTL datasets
LTERtemp = loadLTERtemp() # download NTL LTER data from EDI
LTERions = loadLTERions() # download NTL LTER data from EDI

################################# MENDOTA CHLORIDE #############################################
varname = 'cl'
datasetname = LTERions
thresholdname = 5
lakename = 'ME'

## Interpolate weekly data for Lake Mendota
df.Cl.ME = weeklyInterpolate(lakeAbr = lakename, var = varname, dataset = datasetname, maxdepth = 24, 
                          constrainMethod = 'zero', setThreshold = thresholdname, printFigs = F)


plotTimeseries.year(df.interpolated = df.Cl.ME$weeklyInterpolated, var = 'totpuf_sloh', chooseYear = 2018) +
  labs(title = 'set your own title') +
  theme_minimal()

# calculate annual mass 
df.Cl.ME.mass = calcMass(df.Cl.ME$weeklyInterpolated,lakeAbr = lakename, time.res = 'annual', conversion = 1e6)

# Calculate change in mass annually
df.Cl.ME.mass |> mutate(diff = mass - lag(mass)) |> print(n = 23)
df.Cl.ME.mass |> mutate(diff = mass - lag(mass)) |> summarise(mean(diff, na.rm = T))

usefont = 'Proxima Nova'
# Plot annual mass
ggplot(df.Cl.ME.mass, aes(x = year, y = mass)) +
  geom_path() +
  geom_point(shape = 21, fill = 'lightblue3', stroke = 0.3, size = 2.5) +
  annotate('text', label = 'Mean annual \nincrease 1996-2018\n454 tonnes', 
           x = 2011, y = 23052.5, hjust = 0, vjust = 1, size = 2.5, family = usefont, color= '#F14000') +
  ylab('Chloride (tonnes)') +
  labs(title = 'Lake Mendota chloride mass', 
       caption = 'Calculated from NTLlakeloads [https://github.com/hdugan/NTLlakeloads]') +  
  theme_minimal(base_size = 10) +
  theme(text=element_text(family = usefont),
        axis.title.x = element_blank(),
        plot.background = element_rect(fill = 'white'),
        plot.caption = element_text(size = 6, color = 'lightblue4')) +
  theme(plot.title = element_text(color= '#F14000', vjust=1, family = usefont))

ggsave('ClMass_Mendota.png', width = 5, height = 3, dpi = 500)


# Molar mass NaCl
nacl = 58.44 #g/mol
# Molar Mass chloride 
cl = 35.453 #g/mol

1.10231 * 454 / (cl/nacl) # conversion from tonnes of chloride to tons of NaCl


################################# MONONA CHLORIDE #############################################
lakename = 'MO'

## Interpolate weekly data for Lake Monona
df.Cl.MO = weeklyInterpolate(lakeAbr = lakename, var = varname, dataset = datasetname, maxdepth = 20, 
                             constrainMethod = 'zero', setThreshold = thresholdname, printFigs = F)

# calculate annual mass 
df.Cl.MO.mass = calcMass(df.Cl.MO$weeklyInterpolated,lakeAbr = lakename, time.res = 'annual', conversion = 1e6)

# Calculate change in mass annually
df.Cl.MO.mass |> mutate(diff = mass - lag(mass)) |> print(n = 23)
df.Cl.MO.mass |> mutate(diff = mass - lag(mass)) |> summarise(mean(diff, na.rm = T))

usefont = 'Proxima Nova'
# Plot annual mass
ggplot(df.Cl.MO.mass, aes(x = year, y = mass)) +
  geom_path() +
  geom_point(shape = 21, fill = 'lightblue3', stroke = 0.3, size = 2.5) +
  annotate('text', label = 'Mean annual \nincrease 1996-2018\n115 tonnes', 
           x = 2011, y = 6000, hjust = 0, vjust = 1, size = 2.5, family = usefont, color= '#F14000') +
  ylab('Chloride (tonnes)') +
  labs(title = 'Lake Monona chloride mass', 
       caption = 'Calculated from NTLlakeloads [https://github.com/hdugan/NTLlakeloads]') +  
  theme_minimal(base_size = 10) +
  theme(text=element_text(family = usefont),
        axis.title.x = element_blank(),
        plot.background = element_rect(fill = 'white'),
        plot.caption = element_text(size = 6, color = 'lightblue4')) +
  theme(plot.title = element_text(color= '#F14000', vjust=1, family = usefont))

ggsave('ClMass_Monona.png', width = 5, height = 3, dpi = 500)
