library(NTLlakemasss)
library(tidyverse)

# load NTL datasets
LTERtemp = massLTERtemp() # Downmass NTL LTER data from EDI
LTERions = massLTERions() # Downmass NTL LTER data from EDI

########################################### CHLORIDE #############################################
varname = 'cl'
datasetname = LTERions
thresholdname = 5

## Interpolate weekly data for Lake Mendota
df.Cl = weeklyInterpolate(lakeAbr = 'ME', var = varname, dataset = datasetname, maxdepth = 24, 
                          constrainMethod = 'zero', setThreshold = thresholdname, printFigs = F)

# calculate annual mass 
df.Cl.mass = calcMass(df.Cl$weeklyInterpolated,lakeAbr = 'ME', time.res = 'annual', conversion = 1e6)

# Calculate change in mass annually
df.Cl.mass |> mutate(diff = mass - lag(mass)) |> print(n = 23)
df.Cl.mass |> mutate(diff = mass - lag(mass)) |> summarise(mean(diff, na.rm = T))


usefont = 'Proxima Nova'
# Plot annual mass
ggplot(df.Cl.mass, aes(x = year, y = mass)) +
  geom_path() +
  geom_point(shape = 21, fill = 'lightblue3', stroke = 0.3, size = 2.5) +
  geom_segment(aes(x = 2010.5, xend = 2010.5, y = 22871, yend = 23234)) +
  geom_segment(aes(x = 2010.3, xend = 2010.5, y = 22871, yend = 22871)) +
  geom_segment(aes(x = 2010.3, xend = 2010.5, y = 23234, yend = 23234)) +
  geom_segment(aes(x = 2010.5, xend = 2010.7, y = 23052.5, yend = 23052.5)) +
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

# ggsave('MendotaClMass.png', width = 5, height = 3, dpi = 500)


