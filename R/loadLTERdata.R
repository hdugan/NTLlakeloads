#' Load LTER nutrient data from web
#'
#' Downloads Chemical Limnology of Primary Study Lakes: Nutrients, pH and Carbon 1981 - current
#'
#' @importFrom readr read_csv
#' @importFrom utils download.file
#' @export
loadLTERnutrients <- function() {
  # Package ID: knb-lter-ntl.1.11 Cataloging System:https://pasta.lternet.edu.
  # Data set title: North Temperate Lakes LTER:
  # Chemical Limnology of Primary Study Lakes: Nutrients, pH and Carbon 1981 - current
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/1/52/802d63a4c35050b09ef6d1e7da3efd3f"
  infile1 <- tempfile()
  download.file(inUrl1, infile1, method="curl")

  LTERnutrients <- read_csv(infile1, skip=1, quote ='"',guess_max = 20000, col_names=c(
    "lakeid","year4","daynum","sampledate","depth","rep","sta","event","ph","phair","alk","dic","tic","doc","toc",
    "no3no2","no2","nh4","totnf","totnuf","totpf","totpuf","drsif","brsif","brsiuf","tpm","totnuf_sloh","no3no2_sloh",
    "nh4_sloh","kjdl_n_sloh","totpuf_sloh","drp_sloh","drsif_sloh","flagdepth","flagph","flagphair","flagalk","flagdic",
    "flagtic","flagdoc","flagtoc","flagno3no2","flagno2","flagnh4","flagtotnf","flagtotnuf","flagtotpf","flagtotpuf",
    "flagdrsif","flagbrsif","flagbrsiuf","flagtpm","flagtotnuf_sloh","flagno3no2_sloh","flagnh4_sloh","flagkjdl_n_sloh",
    "flagtotpuf_sloh","flagdrp_sloh","flagdrsif_sloh"))
}

#' Load LTER ion data from web
#'
#' Downloads Chemical Limnology of Primary Study Lakes: Major Ions 1981 - current
#'
#' @importFrom readr read_csv
#' @export
loadLTERions <- function() {
  # Package ID: knb-lter-ntl.2.34 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER:
  # Chemical Limnology of Primary Study Lakes: Major Ions 1981 - current

  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/2/34/3f740d0b77b3caf6930a8ce9cca4306a"
  infile2 <- tempfile()
  download.file(inUrl2,infile2,method="curl")

  LTERions <-read_csv(infile2, skip=1, quote ='"',guess_max = 20000, col_names=c(
    "lakeid","year4","daynum","sampledate","depth","rep","sta","event","cl","so4","ca","mg","na","k","fe","mn",
    "cond","flagcl","flagso4","flagca","flagmg","flagna","flagk","flagfe","flagmn","flagcond"))
}
#' Load LTER phyical limnology data from web
#'
#' Downloads Physical Limnology of Primary Study Lakes 1981 - current
#'
#' @importFrom readr read_csv
#' @export
loadLTERtemp <- function() {
  # Package ID: knb-lter-ntl.29.27 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER:
  # Physical Limnology of Primary Study Lakes 1981 - current

  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/29/27/03e232a1b362900e0f059859abe8eb97"
  infile3 <- tempfile()
  download.file(inUrl3,infile3,method="curl")

  LTERtemp <-read_csv(infile3, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid" ,"year4" ,"daynum" ,"sampledate" ,"depth" ,"rep" ,"sta" ,"event" ,"wtemp" ,"o2" ,"o2sat" ,"deck" ,
    "light" ,"frlight" ,"flagdepth" ,"flagwtemp" ,"flago2" ,"flago2sat" ,"flagdeck" ,"flaglight" ,"flagfrlight"))
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
  # Package ID: knb-lter-ntl.35.30 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Chlorophyll - Trout Lake Area 1981 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/35/30/a38bab3c7d90f4c24f3f603d7fac8c2e"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERchlorophyll <-read_csv(infile1, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid", "year4", "daynum","sampledate",
    "rep","sta","depth","chlor","phaeo", "flagchlor","flagphaeo"))
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
  # Package ID: knb-lter-ntl.38.27 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Chlorophyll - Madison Lakes Area 1995 - current.
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/38/27/66796c3bc77617e7cc95c4b09d4995c5"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERchlorophyll <-read_csv(infile1, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid", "year4","sampledate",
    "depth_range_m","rep","tri_chl_spec", "mono_chl_spec",
    "phaeo_spec","uncorrect_chl_fluor","correct_chl_fluor","phaeo_fluor","flag_spec","flag_fluor"))

}

#' Load LTER light data from web
#'
#' Downloads Light Extinction of Northern Study Lakes 1981 - current
#'
#' @importFrom readr read_csv
#' @export
loadLTERlight <- function() {
  # Package ID: knb-lter-ntl.259.15 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Light Extinction - Trout Lake Area 1981 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/259/15/7b02f899a766ebda2339003c4e162836"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERlight <-read_csv(infile1, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid", "year4", "daynum","sampledate",
    "extcoef","lightext_flag","comments"))
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
  # Package ID: knb-lter-ntl.31.29 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Secchi Disk Depth; Other Auxiliary Base Crew Sample Data 1981 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/31/29/5a5a5606737d760b61c43bc59460ccc9"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERsecchi <-read_csv(infile1, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid", "year4", "daynum","sampledate",
    "sta","secview","secnview","timeon",
    "timeoff","airtemp","windir", "windspd","waveht", "cloud","ice"))
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
  # Package ID: knb-lter-ntl.34.31 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Snow and Ice Depth 1982 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/34/31/9af7f7d823fd8be3e4e31ccd7d4bb003"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERsnow <- read_csv(infile1, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid", "year4", "daynum","sampledate",
    "sta", "nsnow", "avsnow", "sdsnow", "wlevel", "totice", "nice","whiteice","blueice")) %>%
     mutate(sampledate = as.Date(strptime(sampledate, '%Y-%m-%d')))
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
  # Package ID: knb-lter-ntl.88.28 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Phytoplankton - Madison Lakes Area 1995 - current

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/88/28/f2de15b2fff6ae962a04c150c0a1c510"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERphyto <- read_csv(infile1, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid","year4","sampledate","sta","depth_range","division","taxa_name","gald",
    "cells_per_nu","nu_per_ml","cells_per_ml","biovolume_conc","biomass_conc",
    "relative_total_biovolume","genus"))
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
loadLTERzooplankton <- function() {
  # Package ID: knb-lter-ntl.90.31 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Zooplankton - Madison Lakes Area 1997 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/90/31/5880c7ba184589e239aec9c55f9d313b"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERzoops <- read_csv(infile1, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid","year4","sample_date","station",
    "towdepth","species_code","species_name","density","individuals_measured","avg_length")) %>%
    rename(sampledate = sample_date)
}

#' List of available variables from NTL datasets
#' @export
availableVars <- function() {

  aVars = c("ph", "phair", "alk", "dic", "tic", "doc", "toc", "no3no2", "no2", "nh4", "totnf",
  "totnuf", "totpf", "totpuf", "drsif", "brsif", "brsiuf", "tpm", "totnuf_sloh", "no3no2_sloh",
  "nh4_sloh", "kjdl_n_sloh", "totpuf_sloh", "drp_sloh", "drsif_sloh",
  "cl", "so4", "ca", "mg", "na", "k", "fe", "mn", "cond","o2", "o2sat","frlight",
  "chlor","phaeo")

  return(aVars)
}

#' List of 1-D available variables from NTL datasets
#' @export
availableVars.1D <- function() {

  aVars = c("extcoef", "secview", "secnview")

  return(aVars)
}
