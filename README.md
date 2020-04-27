
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Why?

Trying to make a better way of interpolating nutrient data in the lakes.
Both for load calculations and for data visualization.

We often lineraly interpolate water quality observations between
observation depths. This is typically fine if a lake is well mixed, but
if it’s stratfied it introduces a lot of error around the thermocline.
Here, I provide functions to interpolate water quality observations
leveraging information on lake stratification from temperature data.
Often there is more temperature data than water quality data, which
results in better interpolation.

## Installation

You can install NTLlakeloads from github using devtools:

``` r
install.packages("devtools")
devtools::install_github("hdugan/NTLlakeloads")
library(NTLlakeloads)
```

## Get LTER data

``` r
# Use these objects names, hardcoded at the moment
LTERtemp = loadLTERtemp() # Download NTL LTER data from EDI
LTERnutrients = loadLTERnutrients() # Download NTL LTER data from EDI
LTERions = loadLTERions() # Download NTL LTER data from EDI
```

## Variables available for plotting

``` r
# Available variables
availableVars()
```

## Interpolate weekly total phosphorus data for Lake Mendota

``` r
# printFigs = TRUE to output series of interpolated profiles (but slower)
df.ME = weeklyInterpolate(lakeAbr = 'ME', var = 'totpuf_sloh', maxdepth = 24, 
                          constrainMethod = 'zero', setThreshold = 0.1, printFigs = F)
```

## Plotting entire timeseries

``` r
plotTimeseries(df.ME$weeklyInterpolated, var = 'totpuf_sloh')
```

![](man/figures/README-unnamed-chunk-4-1.png)<!-- -->

## Plot specific year with observed data

``` r
plotTimeseries.year(df.ME$weeklyInterpolated, df.ME$observations,  var = 'totpuf_sloh', chooseYear = 2008)
```

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->

## Calculate load at annual or weekly timescales

``` r
df.load = calcLoad(df.ME$weeklyInterpolated,lakeAbr = 'ME', time.res = 'weekly')
df.load.annual = calcLoad(df.ME$weeklyInterpolated,lakeAbr = 'ME', time.res = 'annual')
```

## Decompose timeseries to analyse trends, seasonality

``` r
decomposeTS(df.load, lakeAbr = 'ME', var = 'totpuf_sloh')
```

![](man/figures/README-unnamed-chunk-7-1.png)<!-- -->

    #> # A tibble: 4,904 x 3
    #>    date       decompose value
    #>    <date>     <fct>     <dbl>
    #>  1 1995-05-09 var.load   43.3
    #>  2 1995-05-09 var.trend  NA  
    #>  3 1995-05-09 var.seas  -12.8
    #>  4 1995-05-09 var.err    NA  
    #>  5 1995-05-16 var.load   44.3
    #>  6 1995-05-16 var.trend  NA  
    #>  7 1995-05-16 var.seas  -13.1
    #>  8 1995-05-16 var.err    NA  
    #>  9 1995-05-23 var.load   45.3
    #> 10 1995-05-23 var.trend  NA  
    #> # … with 4,894 more rows
