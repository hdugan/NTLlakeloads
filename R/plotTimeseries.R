#' Plot interpolate heatmap of entire timeseries
#'
#'
#' @param df.interpolated dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @param var Variable of interest. Use availableVars() to see available variables.
#' @import ggplot2
#' @export
plotTimeseries <- function(df.interpolated, var, saveFig = FALSE) {

  binsize = signif(max(df.interpolated$var,na.rm = T)/20,1)

  pY = ggplot(df.interpolated, aes(x = date, y = depth, z = var)) +
    geom_contour_filled(aes(fill = stat(level)), alpha = 0.9, binwidth = binsize) +
    scale_fill_viridis_d(name = var) +
    guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
    ylab('depth') +
    scale_y_reverse() +
    theme_bw()

  print(pY)

  if (saveFig == TRUE){
    ggsave(paste0('gamHeatMap_',lakeAbr,'_',var,'.png'), width = 7, height = 4)
  }

  return(pY)
}


#' Plot interpolate heatmap of single year
#'
#' @param df.interpolated dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @param var Variable of interest. Use availableVars() to see available variables.
#' @param observations dataframe of observed data. Output of weeklyInterpolate()
#' @param chooseYear year of interest
#' @param limits range for color scale
#' @import ggplot2
#' @export
plotTimeseries.year <- function(df.interpolated, observations, var, chooseYear, saveFig = FALSE) {

  binsize = signif(max(df.interpolated$var,na.rm = T)/20,1)


  if(is.null(observations)) {
    pY = ggplot(df.interpolated, aes(x = date, y = depth, z = var)) +
      geom_contour_filled(aes(fill = stat(level)), alpha = 0.9, binwidth = binsize) +
      scale_fill_viridis_d(name = var) +
      guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
      ylab('depth') +
      # coord_cartesian(xlim = as.Date(c(paste0(chooseYear,'-01-01'), paste0(chooseYear,'-12-31')))) +
      xlim(as.Date(paste0(chooseYear,'-01-01')), as.Date(paste0(chooseYear,'-12-31'))) +
      scale_y_reverse() +
      theme_bw()
  } else {
  pY = ggplot(df.interpolated, aes(x = date, y = depth, z = var)) +
    # geom_rect(aes(xmin = as.Date(paste0(chooseYear,'-01-02')), xmax = as.Date(paste0((chooseYear + 1),'-01-14')), ymin = 0, ymax = max(observations$depth)), color = 'grey50') +
    geom_contour_filled(aes(fill = stat(level)), alpha = 0.9, binwidth = binsize) +
    scale_fill_viridis_d(name = var) +
    guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
    geom_point(data = filter(observations, !is.na(meanVar)), aes(x = sampledate, y = depth), size = 0.5) +
    geom_text(data = filter(observations, !is.na(meanVar)), aes(x = sampledate, y = depth, label= meanVar),
              hjust= -0.2, vjust=1.2, size = 3, color = 'white') +
    scale_color_viridis_c() +
    ylab('depth') +
    xlim(as.Date(paste0(chooseYear,'-01-01')), as.Date(paste0(chooseYear,'-12-31'))) +
    scale_y_reverse()
    # theme_bw()
  }

  print(pY)

  if (saveFig == TRUE) {
    ggsave(paste0('gamHeatMap_',lakeAbr,'_',var,'_',chooseYear,'.png'), width = 7, height = 4)
  }
  return(pY)

}
