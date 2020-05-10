#' Load LTER nutrient data from web
#'
#' Downloads Chemical Limnology of Primary Study Lakes: Nutrients, pH and Carbon 1981 - current
#'
#' @importFrom readr read_csv
#' @importFrom utils download.file
#' @export
loadLTERnutrients <- function() {
  ############# Load data from web #################################################################

  # Package ID: knb-lter-ntl.1.11 Cataloging System:https://pasta.lternet.edu.
  # Data set title: North Temperate Lakes LTER:
  # Chemical Limnology of Primary Study Lakes: Nutrients, pH and Carbon 1981 - current ####
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/1/52/802d63a4c35050b09ef6d1e7da3efd3f"
  infile1 <- tempfile()
  download.file(inUrl1, infile1, method="curl")

  LTERnutrients <- read_csv(infile1, skip=1, quote ='"',guess_max = 20000, col_names=c(
    "lakeid",
    "year4",
    "daynum",
    "sampledate",
    "depth",
    "rep",
    "sta",
    "event",
    "ph",
    "phair",
    "alk",
    "dic",
    "tic",
    "doc",
    "toc",
    "no3no2",
    "no2",
    "nh4",
    "totnf",
    "totnuf",
    "totpf",
    "totpuf",
    "drsif",
    "brsif",
    "brsiuf",
    "tpm",
    "totnuf_sloh",
    "no3no2_sloh",
    "nh4_sloh",
    "kjdl_n_sloh",
    "totpuf_sloh",
    "drp_sloh",
    "drsif_sloh",
    "flagdepth",
    "flagph",
    "flagphair",
    "flagalk",
    "flagdic",
    "flagtic",
    "flagdoc",
    "flagtoc",
    "flagno3no2",
    "flagno2",
    "flagnh4",
    "flagtotnf",
    "flagtotnuf",
    "flagtotpf",
    "flagtotpuf",
    "flagdrsif",
    "flagbrsif",
    "flagbrsiuf",
    "flagtpm",
    "flagtotnuf_sloh",
    "flagno3no2_sloh",
    "flagnh4_sloh",
    "flagkjdl_n_sloh",
    "flagtotpuf_sloh",
    "flagdrp_sloh",
    "flagdrsif_sloh"))
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
  # Chemical Limnology of Primary Study Lakes: Major Ions 1981 - current ####

  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/2/34/3f740d0b77b3caf6930a8ce9cca4306a"
  infile2 <- tempfile()
  download.file(inUrl2,infile2,method="curl")

  LTERions <-read_csv(infile2, skip=1, quote ='"',guess_max = 20000, col_names=c(
    "lakeid",
    "year4",
    "daynum",
    "sampledate",
    "depth",
    "rep",
    "sta",
    "event",
    "cl",
    "so4",
    "ca",
    "mg",
    "na",
    "k",
    "fe",
    "mn",
    "cond",
    "flagcl",
    "flagso4",
    "flagca",
    "flagmg",
    "flagna",
    "flagk",
    "flagfe",
    "flagmn",
    "flagcond"))
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
  # Physical Limnology of Primary Study Lakes 1981 - current ####

  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/29/27/03e232a1b362900e0f059859abe8eb97"
  infile3 <- tempfile()
  download.file(inUrl3,infile3,method="curl")

  LTERtemp <-read_csv(infile3, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid", "year4", "daynum","sampledate","depth",
    "rep",
    "sta",
    "event",
    "wtemp",
    "o2",
    "o2sat",
    "deck",
    "light",
    "frlight",
    "flagdepth",
    "flagwtemp",
    "flago2",
    "flago2sat",
    "flagdeck",
    "flaglight",
    "flagfrlight"))
}

#' Load LTER chlorophyll data from web
#'
#' Downloads Chlorophyll of Northern Study Lakes 1981 - current
#'
#' @importFrom readr read_csv
#' @export
loadLTERchlorophyll <- function() {
  # Package ID: knb-lter-ntl.35.30 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER: Chlorophyll - Trout Lake Area 1981 - current.

  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/35/30/a38bab3c7d90f4c24f3f603d7fac8c2e"
  infile1 <- tempfile()
  download.file(inUrl1,infile1,method="curl")

  LTERchlorophyll <-read_csv(infile1, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid", "year4", "daynum","sampledate",
    "rep","sta","depth","chlor","phaeo", "flagchlor","flagphaeo"))
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
