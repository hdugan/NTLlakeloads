#' Load LTER nutrient data from web
#'
#' Downloads Chemical Limnology of Primary Study Lakes: Nutrients, pH and Carbon 1981 - current
#'
#' @importFrom readr read_csv
#' @export
loadLTERnutrients <- function() {

  ############ Load libraries ####################################################
  library(readr)

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
  ############ Load libraries ####################################################
  library(readr)

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
  ############ Load libraries ####################################################
  library(readr)

  # Package ID: knb-lter-ntl.29.27 Cataloging System:https://pasta.edirepository.org.
  # Data set title: North Temperate Lakes LTER:
  # Physical Limnology of Primary Study Lakes 1981 - current ####

  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/29/27/03e232a1b362900e0f059859abe8eb97"
  infile3 <- tempfile()
  download.file(inUrl3,infile3,method="curl")

  LTERtemp <-read_csv(infile3, skip=1, quote ='"',guess_max = 100000, col_names=c(
    "lakeid",
    "year4",
    "daynum",
    "sampledate",
    "depth",
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

#' List of available variables from NTL datasets
#' @export
availableVars <- function() {

  aVars = c("ph", "phair", "alk", "dic", "tic", "doc", "toc", "no3no2", "no2", "nh4", "totnf",
  "totnuf", "totpf", "totpuf", "drsif", "brsif", "brsiuf", "tpm", "totnuf_sloh", "no3no2_sloh",
  "nh4_sloh", "kjdl_n_sloh", "totpuf_sloh", "drp_sloh", "drsif_sloh",
  "cl", "so4", "ca", "mg", "na", "k", "fe", "mn", "cond","o2", "o2sat")

  return(aVars)
}
