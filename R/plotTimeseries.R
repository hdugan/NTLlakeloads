#' Plot interpolate heatmap of entire timeseries
#'
#'
#' @param df dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @import ggplot2
plotTimeseries <- function(df, saveFig = FALSE) {

  binsize = signif(max(df$var,na.rm = T)/20,1)

  pY = ggplot(df, aes(x = date, y = depth, z = var)) +
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
}


#' Plot interpolate heatmap of single year
#'
#' @param df dataframe of weekly interpolated data. Output of weeklyInterpolate()
#' @param observations dataframe of observed data. Output of weeklyInterpolate()
#' @param chooseYear year of interest
#' @import ggplot2
plotTimeseries.year <- function(df, observations, chooseYear, saveFig = FALSE) {

  binsize = signif(max(df$var,na.rm = T)/20,1)

  pY = ggplot(df, aes(x = date, y = depth, z = var)) +
    geom_contour_filled(aes(fill = stat(level)), alpha = 0.9, binwidth = binsize) +
    scale_fill_viridis_d(name = var) +
    guides(fill = guide_colorsteps(barheight = unit(6, "cm"))) +
    geom_point(data = filter(observations, !is.na(meanVar)), aes(x = sampledate, y = depth), size = 0.5) +
    geom_text(data = filter(observations, !is.na(meanVar)), aes(x = sampledate, y = depth, label= meanVar),
              hjust= -0.2, vjust=1.2, size = 3, color = 'white') +
    scale_color_viridis_c() +
    ylab('depth') +
    xlim(as.Date(paste0(chooseYear,'-01-01')), as.Date(paste0(chooseYear,'-12-01'))) +
    scale_y_reverse() +
    theme_bw()

  print(pY)

  if (saveFig == TRUE) {
    ggsave(paste0('gamHeatMap_',lakeAbr,'_',var,'_',chooseYear,'.png'), width = 7, height = 4)
  }

}
