#' Calculate weekly or annual mass in the lake 
#'
#' Input weekly 1-m depth profiles to calculate depth integrated mass at weekly or annual timescales using lake bathymetry
#'
#' @param df.interpolated dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @param lakeAbr Lake identification, string
#' @param time.res Time resolution. Options are 'weekly' (gives a daily mass at a weekly timestep) or 
#' 'annual' (gives an annual mass averaged from the weekly data)
#' @param conversion Load unit conversion. Ex. if unit of var is µg/L and the mass will be output in µg.
#' A conversion factor of 1e6 will provide kg. 
#' @import dplyr
#' @importFrom lubridate year week
#' @export
calcMass <- function(df.interpolated, lakeAbr, time.res = 'weekly', conversion = 1) {

  # Get lake bathymetry
  data('NTLbathymetry_1m')
  lakeBathy = NTLbathymetry_1m %>% dplyr::filter(LakeID == lakeAbr)

  df.area = df.interpolated %>%
    dplyr::arrange(date) %>%
    dplyr::left_join(lakeBathy) %>%
    dplyr::mutate(mass = var * area) %>%
    as_tibble()

  df.mass = df.area %>%
    group_by(date) %>%
    dplyr::summarise(mass = sum(mass,na.rm = T)/conversion) %>% # 
    mutate(year = year(date), week = week(date)) %>%
    filter(week != 53)

  # ggplot(df.load) + geom_line(aes(x = date, y = load))

  annual = df.mass %>% group_by(year) %>%
    dplyr::summarise(mass = mean(mass))

  # ggplot(annual) + geom_point(aes(x = year, y = load)) + geom_line(aes(x = year, y = load))

  if (time.res == 'weekly') {
    return(df.mass)
  } else if (time.res == 'annual') {
    return(annual)
  }
}
