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
