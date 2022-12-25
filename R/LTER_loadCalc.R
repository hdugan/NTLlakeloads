#' Calculate weekly or annual load
#'
#' Input weekly 1-m depth profiles to calculate depth integrated load at weekly or annual timescales
#'
#' @param df.interpolated dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @param lakeAbr Lake identification, string
#' @param time.res Time resolution. Options are 'weekly' (gives a daily load at a weekly timestep) or 
#' 'annual' (gives an annual load at an annual timestep)
#' @param conversion Load unit conversion. Ex. if unit of var is µg/L and the load will be output in µg.
#' A conversion factor of 1e6 will provide kg. 
#' @import dplyr
#' @importFrom lubridate year week
#' @export
calcLoad <- function(df.interpolated, lakeAbr, time.res = 'weekly', conversion = 1) {

  # Get lake bathymetry
  data('NTLbathymetry_1m')
  lakeBathy = NTLbathymetry_1m %>% dplyr::filter(LakeID == lakeAbr)

  df.area = df.interpolated %>%
    dplyr::arrange(date) %>%
    dplyr::left_join(lakeBathy) %>%
    dplyr::mutate(load = var * area) %>%
    as_tibble()

  df.load = df.area %>%
    group_by(date) %>%
    dplyr::summarise(load = sum(load,na.rm = T)/conversion) %>% # 
    mutate(year = year(date), week = week(date)) %>%
    filter(week != 53)

  # ggplot(df.load) + geom_line(aes(x = date, y = load))

  annual = df.load %>% group_by(year) %>%
    dplyr::summarise(load = sum(load) * 7)

  # ggplot(annual) + geom_point(aes(x = year, y = load)) + geom_line(aes(x = year, y = load))

  if (time.res == 'weekly') {
    return(df.load)
  } else if (time.res == 'annual') {
    return(annual)
  }
}
