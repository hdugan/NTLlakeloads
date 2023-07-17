#' Load LTER nutrient data from web
#'
#' Downloads Chemical Limnology of Primary Study Lakes: Nutrients, pH and Carbon 1981 - current
#'
#' @importFrom readr read_csv
#' @importFrom utils download.file
#' @export
loadLTERnutrients <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-ntl&identifier=1&revision=59
  
  # Package ID: knb-lter-ntl.1.59 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER:
  # Chemical Limnology of Primary Study Lakes: Nutrients, pH and Carbon 1981 - current
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/1/59/0ff1fd13116d6097376e3745194cdc5f" 
  infile1 <- tempfile()
  download.file(inUrl1, infile1, method="curl")

  LTERnutrients <- read_csv(infile1)
}

#' Load LTER ion data from web
#'
#' Downloads Chemical Limnology of Primary Study Lakes: Major Ions 1981 - current
#'
#' @importFrom readr read_csv
#' @export
loadLTERions <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.2.37
  
  # Package ID: knb-lter-ntl.2.37 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER:
  # Chemical Limnology of Primary Study Lakes: Major Ions 1981 - current

  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/2/37/0701a84081989bb1ff37d621a6c4560a" 
  
  infile2 <- tempfile()
  download.file(inUrl2,infile2,method="curl")

  LTERions <- read_csv(infile2)
}
#' Load LTER phyical limnology data from web
#'
#' Downloads Physical Limnology of Primary Study Lakes 1981 - current
#'
#' @importFrom readr read_csv
#' @export
loadLTERtemp <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.29.35
  
  # Package ID: knb-lter-ntl.29.35 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER:
  # Physical Limnology of Primary Study Lakes 1981 - current

  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/29/35/03e232a1b362900e0f059859abe8eb97"
  infile3 <- tempfile()
  download.file(inUrl3,infile3,method="curl")

  LTERtemp <- read_csv(infile3)
}

#'Load LTER chlorophyll data from web
#'
#'Chlorophyll and phaeopigments are measured at our permanent sampling station
#'in the deepest part of each lake. Chlorophyll samples are collected from the
#'seven primary study lakes (Allequash, Big Muskellunge, Crystal, Sparkling, and
#'Trout lakes and bog lakes 27-02 [Crystal Bog], and 12-15 [Trout Bog]) in the
#'Trout Lake area at two to 10 depths depending on the lake and analyzed
#'spectrophotometrically. Sampling Frequency: fortnightly during ice-free season
#'- every 6 weeks during ice-covered season Number of sites: 7
#'
#'@importFrom readr read_csv
#'@export
loadLTERchlorophyll.north <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.35.32
  
  # Package ID: knb-lter-ntl.35.32 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Chlorophyll - Trout Lake Area 1981 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/35/32/50f9b5f93d0a0d47008147698fb413f3"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERchlorophyll <- read_csv(infile1)
}

#' Load LTER chlorophyll data from web
#'
#' Downloads Chlorophyll of Northern Study Lakes 1981 - current Chlorophyll is
#' measured at our permanent sampling station in the deepest part of the lake.
#' Chlorophyll samples are collected from the four primary study lakes in the
#' Madison area (Lakes Mendota, Monona, and Wingra and Fish Lake) at integrated
#' depths and discrete depths for spectrophotometric analysis and fluorometric
#' analysis. Due to a change in instruments starting in 2002 and lasting through
#' 2007, chlorophyll analyses for the southern lakes had an uncorrectable bias,
#' and are not included in this dataset.  Analyses since then (2008 onward) have
#' been determined to not have this bias. Sampling Frequency: bi-weekly during
#' ice-free season from late March or early April through early September, then
#' every 4 weeks through late November; sampling is conducted usually once
#' during the winter (depending on ice conditions). Number of sites: 4
#'
#' @importFrom readr read_csv
#' @export
loadLTERchlorophyll.south <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.38.28
  
  # Package ID: knb-lter-ntl.38.28 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Chlorophyll - Madison Lakes Area 1995 - current.
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/38/28/66796c3bc77617e7cc95c4b09d4995c5"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERchlorophyll <- read_csv(infile1)

}

#' Load LTER light data from web
#'
#' Downloads Light Extinction of Northern Study Lakes 1981 - current
#'
#' @importFrom readr read_csv
#' @export
loadLTERlight <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.259.18
  
  # Package ID: knb-lter-ntl.259.18 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Light Extinction - Trout Lake Area 1981 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/259/18/6e9645b25882672e7316357890553e19" 
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERlight <- read_csv(infile1)
}

#' Load LTER secchi data from web
#'
#' Secchi disk depth is measured in the deepest part of each lake for the eleven primary lakes
#' (Allequash, Big Muskellunge, Crystal, Sparkling, Trout lakes, unnamed lakes 27-02 [Crystal Bog]
#' and 12-15 [Trout Bog], Fish, Mendota, Monona and Wingra). The disk is circular, 20 cm in diameter,
#' and has alternating black and white quadrants. It is lowered using a calibrated Kevlar rope to
#' minimize stretching. Readings are made on the shaded side of the boat both with and without the
#' aid of a plexiglass viewer. The points at which the disk disappears while being lowered and
#' reappears while being raised are averaged to determine Secchi depth. Auxiliary data include time
#' of day, air temperature, cloud cover, wave height, wind speed and direction and whether the lake
#' was ice covered on the sampledate. Sampling Frequency: fortnightly during ice-free season - every
#' 6 weeks during ice-covered season for the northern lakes. The southern lakes are similar except
#' that sampling occurs monthly during the fall and typically only once during the winter (depending
#' on ice conditions). Number of sites: 11
#'
#' @importFrom readr read_csv
#' @export
loadLTERsecchi <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.31.32
  
  # Package ID: knb-lter-ntl.31.32 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Secchi Disk Depth; Other Auxiliary Base Crew Sample Data 1981 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/31/32/d01c782e0601d2217b94dd614444bd33"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERsecchi <- read_csv(infile1)
}

#' Load LTER snow data from web
#'
#' Snow and ice depth are measured during the winter months on the eleven primary lakes
#' (Allequash, Big Muskellunge, Crystal, Sparkling, Trout lakes, unnamed lakes 27-02
#' [Crystal Bog] and 12-15 [Trout Bog], Fish, Mendota, Monona and Wingra). Sampling Frequency:
#' every 6 weeks during ice-covered season in the north and typically once during the winter
#' in the south Number of sites: 11
#'
#' @importFrom readr read_csv
#' @export
loadLTERsnow <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-ntl&identifier=34&revision=34
  
  # Package ID: knb-lter-ntl.34.34 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Snow and Ice Depth 1982 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/34/34/9be297624fc843fbd41f29b161150946" 
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERsnow <- read_csv(infile1)
}

#' Load LTER phytoplankton from web
#'
#' Phytoplankton samples for the 4 southern Wisconsin LTER lakes (Mendota,
#' Monona, Wingra, Fish) have been collected for analysis by LTER since 1995
#' (1996 Wingra, Fish) when the southern Wisconsin lakes were added to the North
#' Temperate Lakes LTER project. Samples are collected as a composite
#' whole-water sample and are preserved in gluteraldehyde. Composite sample
#' depths are 0-8 meters for Lake Mendota (to conform to samples collected and
#' analyzed since 1990 for a UW/DNR food web research study), and 0-2 meters for
#' the other three lakes. A tube sampler is used for the 0-8 m Lake Mendota
#' samples; samples for the other lakes are obtained by collecting water at
#' 1-meter intervals using a Kemmerer water sampler and compositing the samples
#' in a bucket. Samples are taken in the deep hole region of each lake at the
#' same time and location as other limnological sampling. Phytoplankton samples
#' are analyzed by PhycoTech, Inc., a private lab specializing in phytoplankton
#' analyses (see data protocol for procedures). Samples for Wingra and Fish
#' lakes are archived but not routinely counted. Permanent slide mounts (3 per
#' sample) are prepared for all analyzed Mendota and Monona samples as well as 6
#' samples per year for Wingra and Fish; the slide mounts are archived at the
#' University of Wisconsin - Madison Zoology Museum. Phytoplankton are
#' identified to species using an inverted microscope (Utermohl technique) and
#' are reported as natural unit (i.e., colonies, filaments, or single cells)
#' densities per mL, cell densities per mL, and algal biovolume densities per
#' mL. Multiple entries for the same species on the same date may be due to
#' different variants or vegetative states - (e.g., colonial or attached vs.
#' free cell.) Biovolumes for individual cells of each species are determined
#' during the counting procedure by obtaining cell measurements needed to
#' calculate volumes for geometric solids (e.g., cylinders, spheres, truncated
#' cones) corresponding to actual cell shapes. Biovolume concentrations are then
#' computed by mulitplying the average cell biovolume by the cell densities in
#' the water sample. Note that one million cubicMicrometers of biovolume
#' PerMilliliter of water are equal to a biovolume concentration of one
#' cubicMillimeterPerMilliliter. Assuming a cell density equal to water, a
#' cubicMillimeterPerMilliliter of biovolume converts to a biomass concentration
#' of one milligramPerLiter. Sampling Frequency: bi-weekly during ice-free
#' season from late March or early April through early September, then every 4
#' weeks through late November; sampling is conducted usually once during the
#' winter (depending on ice conditions). Number of sites: 4 Several taxonomic
#' updates have been made to this dataset February 2013, see methods for
#' details.
#'
#' @importFrom readr read_csv
#' @export
loadLTERphytoplankton <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.88.31
  
  # Package ID: knb-lter-ntl.88.31 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Phytoplankton - Madison Lakes Area 1995 - current

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/88/31/f2de15b2fff6ae962a04c150c0a1c510"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERphyto <- read_csv(infile1)
}

#'Load LTER zooplankton from web
#'
#'Zooplankton samples for the 4 southern Wisconsin LTER lakes (Mendota, Monona,
#'Wingra, Fish) have been collected for analysis by LTER since 1995 (1996
#'Wingra, Fish) when the southern Wisconsin lakes were added to the North
#'Temperate Lakes LTER project. Samples are collected as a vertical tow using an
#'80-micron mesh conical net with a 30-cm diameter opening (net mouth: net
#'length ratio = 1:3) consistent with sampling conducted by the Wisconsin Dept.
#'Natural Resources in prior years. Zooplankton tows are taken in the deep hole
#'region of each lake at the same time and location as other limnological
#'sampling; zooplankton samples are preserved in 70% ethanol for later
#'processing. Samples are usually collected with standard tow depths on most
#'dates (e.g., 20 meters for Lake Mendota) but not always, so tow depth is
#'recorded as a variate in the database. Crustacean species are identified and
#'counted for Mendota and Monona and body lengths are recorded for a portion of
#'each species identified (see data protocol for counting procedure); samples
#'for Wingra and Fish lakes are archived but not routinely counted. Numerical
#'densities for Mendota and Monona zooplankton samples are reported in the
#'database as number or organisms per square meter without correcting for net
#'efficiency. [Net efficiency varies from a maximum of about 70% under clear
#'water conditions; net efficiency declines when algal blooms are dense
#'(Lathrop, R.C. 1998. Water clarity responses to phosphorus and Daphnia in Lake
#'Mendota. Ph.D. Thesis, University of Wisconsin-Madison.)] Organism densities
#'in number per cubic meter can be obtained by dividing the reported
#'square-meter density by the tow depth, although adjustments for the oxygenated
#'depth zone during the summer and early fall stratified season is required to
#'obtain realistic zooplankton volumetric densities in the lake's surface
#'waters. Biomass densities can be calculated using literature formulas for
#'converting organism body lengths reported in the database to body masses.
#'Sampling Frequency: bi-weekly during ice-free season from late March or early
#'April through early September, then every 4 weeks through late November;
#'sampling is conducted usually once during the winter (depending on ice
#'conditions). Number of sites: 4 Note: for a period between approximately 2011
#'and 2015, a calculation error caused density values to be significantly
#'greater than they should have been for the entire dataset. That issue has been
#'corrected.
#'
#'@importFrom readr read_csv
#'@export
loadLTERzooplankton.south <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.90.33
  
  # Package ID: knb-lter-ntl.90.33 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Zooplankton - Madison Lakes Area 1997 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/90/33/5880c7ba184589e239aec9c55f9d313b"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERzoops <- read_csv(infile1)
}

# Samples of native zooplankton are collected from the seven primary northern
# lakes (Allequash, Big Muskellunge, Crystal, Sparkling, and Trout lakes and bog
# lakes 27-02 [Crystal Bog], and 12-15 [Trout Bog]) at two to nine depths using
# a 2 m long Schindler Patalas trap (53um mesh) and with vertical tows (1 m
# above the bottom of the lake to the surface) using a Wisconsin net (80um
# mesh). Zooplankton samples are preserved in buffered formalin (up until the
# year 2000) or 80% ethanol (2001 onwards) and archived. Data are summed over
# sex and stage and integrated volumetrically over the water column to provide a
# lake-wide estimate of organisms per liter for each species. A minimum of 5
# samples per lake-year are identified and counted. Sampling Frequency:
# fortnightly during ice-free season - every 6 weeks during ice-covered season.
# Number of sites: 7.
#'@importFrom readr read_csv
#'@export
loadLTERzooplankton.north <- function() {
  # https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.37.37
  
  # Package ID: knb-lter-ntl.37.37 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Zooplankton - Trout Lake Area 1982 - current.
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/37/37/c4b652eea76cd431ac5fd3562b1837ee" 
  
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")
  
  LTERzoops <- read_csv(infile1)
}
