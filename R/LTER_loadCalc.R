#' Calculate weekly or annual load
#'
#' Input weekly 1-m depth profiles to calculate depth integrated load at weekly or annual timescales
#'
#' @param df dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @param lakeAbr Lake identification, string
#' @param time.res Time resolution. Options are 'weekly' (default) or 'annual'
#' @import dplyr
#' @importFrom lubridate year
#' @export
calcLoad <- function(df, lakeAbr, time.res = 'weekly') {

  # Get lake bathymetry
  data('NTLbathymetry_1m')
  lakeBathy = NTLbathymetry_1m %>% dplyr::filter(LakeID == lakeAbr)

  df.area = df %>%
    dplyr::arrange(date) %>%
    dplyr::left_join(lakeBathy) %>%
    dplyr::mutate(load = var * area) %>%
    as_tibble()

  df.load = df.area %>%
    group_by(date) %>%
    dplyr::summarise(load = sum(load,na.rm = T)/1000000) %>% # kg
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
